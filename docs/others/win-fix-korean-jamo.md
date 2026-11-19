---
title: Windows에서 macOS 한글 파일명 자소 분리(NFD → NFC) 해결 가이드
tags: [windows, macos, powershell, korean, unicode, nfd, nfc]
---

# Windows에서 macOS 한글 파일명 자소 분리(NFD → NFC) 해결 가이드

macOS에서 생성된 한글 파일명을 Windows로 가져왔을 때 자음과 모음이 분리되는 현상(예: `ㅎ ㅏ ㄴ ㄱ ㅡ ㄹ` → `한글`)은 운영체제 간 유니코드 정규화 방식의 차이(macOS: **NFD**, Windows: **NFC**) 때문에 발생합니다.

본 가이드는 Windows 탐색기의 **마우스 우클릭 메뉴**에 PowerShell 기반의 일괄 변환 기능을 등록하여, 개별 파일 및 폴더(하위 경로 포함)의 한글 자소를 즉시 결합하는 방법을 안내합니다.

---

## 1. 사전 준비 및 원리

* **동작 방식:** .NET의 `String.Normalize([System.Text.NormalizationForm]::FormC)` 메서드를 사용하여 NFD(조합형) 문자열을 NFC(완성형)로 변환합니다.
* **지원 범위:**
  * **특정 개별 파일 우클릭 시:** 해당 파일명 변환
  * **특정 폴더 우클릭 시:** 해당 폴더 내 모든 하위 파일 및 폴더명 재귀적 변환
  * **폴더 내부 빈 공간 우클릭 시:** 현재 열린 폴더 내 모든 하위 파일 및 폴더명 재귀적 변환

---

## 2. 시스템 변경 사항 요약 (안전성 안내)

본 설치 스크립트는 **관리자 권한을 요구하지 않으며**, 현재 로그인된 사용자 계정(`CurrentUser`) 영역 내에서만 동작합니다. 실행 시 시스템에 적용되는 변경 사항은 다음 세 가지가 전부입니다.

1. **로컬 스크립트 파일 1개 생성**
   * **경로:** `C:\Scripts\FixKoreanNFC.ps1`
   * **역할:** 우클릭 메뉴 선택 시 백그라운드에서 실행되어 대상 파일/폴더명의 유니코드를 NFD에서 NFC로 변환합니다.

2. **현재 사용자 PowerShell 실행 정책 변경**
   * **대상 범위:** `CurrentUser` (시스템 전체가 아닌 현재 계정만 적용)
   * **설정값:** `RemoteSigned` (로컬 PC에 직접 생성한 스크립트 파일 실행을 허용하며, 외부 다운로드 스크립트는 여전히 서명을 요구함)

3. **우클릭 컨텍스트 메뉴 레지스트리 키 3개 등록**
   * **등록 위치 (`HKEY_CURRENT_USER` 하위 — 현재 계정만 적용):**
     * `HKCU\Software\Classes\*\shell\FixKoreanNFC` (모든 개별 파일 우클릭 시)
     * `HKCU\Software\Classes\Directory\shell\FixKoreanNFC` (특정 폴더 우클릭 시)
     * `HKCU\Software\Classes\Directory\Background\shell\FixKoreanNFC` (폴더 내부 빈 공간 우클릭 시)
   * **역할:** 탐색기 우클릭 메뉴에 `한글 자소 분리 해결 (NFC 변환)` 항목을 표시하고 위 `.ps1` 스크립트를 연결합니다.

> **참고:** 모든 변경 내역은 하단 **6. 제거 방법(언인스톨)** 스크립트를 통해 흔적 없이 원상 복구할 수 있습니다.

---

## 3. 한 번에 설치하기 (PowerShell 자동 설정)

PowerShell을 실행한 뒤 아래 스크립트 블록 전체를 복사하여 붙여넣으면 **스크립트 파일 생성, 실행 정책 허용, 우클릭 레지스트리 등록**이 한 번에 완료됩니다.

```powershell
# 1. 스크립트 저장 디렉터리 생성 및 PowerShell 스크립트 작성
New-Item -Path "C:\Scripts" -ItemType Directory -Force | Out-Null

@'
param([string]$TargetPath)

if (-not $TargetPath) { $TargetPath = Get-Location }

if (Test-Path -LiteralPath $TargetPath -PathType Leaf) {
    $item = Get-Item -LiteralPath $TargetPath
    $normalized = $item.Name.Normalize([System.Text.NormalizationForm]::FormC)
    if ($item.Name -ne $normalized) {
        Rename-Item -LiteralPath $item.FullName -NewName $normalized
    }
} else {
    Set-Location -LiteralPath $TargetPath
    Get-ChildItem -Recurse | Sort-Object { $_.FullName.Length } -Descending | ForEach-Object {
        $normalized = $_.Name.Normalize([System.Text.NormalizationForm]::FormC)
        if ($_.Name -ne $normalized) {
            Rename-Item -LiteralPath $_.FullName -NewName $normalized
        }
    }
}
'@ | Set-Content -LiteralPath "C:\Scripts\FixKoreanNFC.ps1" -Encoding UTF8

# 2. 현재 사용자 계정의 로컬 스크립트 실행 정책 허용
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force

# 3. 우클릭 컨텍스트 메뉴 레지스트리 등록 (개별 파일 / 폴더 / 폴더 배경)
$regPaths = @(
    "HKCU:\Software\Classes\*\shell\FixKoreanNFC",
    "HKCU:\Software\Classes\Directory\shell\FixKoreanNFC",
    "HKCU:\Software\Classes\Directory\Background\shell\FixKoreanNFC"
)

foreach ($path in $regPaths) {
    $cmdPath = "$path\command"
    $targetArg = if ($path -like "*Background*") { "%V" } else { "%1" }
    
    New-Item -Path $cmdPath -Force | Out-Null
    Set-ItemProperty -LiteralPath $path -Name "(Default)" -Value "한글 자소 분리 해결 (NFC 변환)"
    Set-ItemProperty -LiteralPath $path -Name "Icon" -Value "powershell.exe"
    Set-ItemProperty -LiteralPath $cmdPath -Name "(Default)" -Value "powershell.exe -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File `"C:\Scripts\FixKoreanNFC.ps1`" -TargetPath `"$targetArg`""
}

Write-Host "설치가 완료되었습니다." -ForegroundColor Green
```

---

## 4. 사용 방법

1. 자소가 분리된 **파일**, **폴더**, 또는 **폴더 내부의 빈 공간**을 마우스 오른쪽 버튼으로 클릭합니다.
   * **Windows 11 사용자:** 기본 우클릭 메뉴 하단의 **더 많은 옵션 표시**를 누르거나, 대상을 선택한 상태에서 **`Shift + 우클릭`**을 누릅니다.
2. 메뉴에서 **`한글 자소 분리 해결 (NFC 변환)`** 항목을 클릭합니다.
3. 백그라운드에서 스크립트가 실행되며 파일명 및 폴더명이 완성형 한글로 즉시 변경됩니다.

(참고: 파일 선택 > Shift + 마우스 우클릭)
<img width="1563" height="538" alt="image" src="https://github.com/user-attachments/assets/b53c95b9-d4c4-4992-82fc-85580d8ec465" />

(참고: 폴더 내부의 빈 공간을 Shift + 마우스 우클릭)
<img width="1784" height="959" alt="image" src="https://github.com/user-attachments/assets/a2b01130-cb9c-40e9-8b0a-e00035dd7e6c" />

---

## 5. 트러블슈팅 및 주의사항

* **PowerShell 경로 와일드카드(`*`) 처리:** 레지스트리 경로(`HKCU:\Software\Classes\*\...`)를 PowerShell 명령어로 직접 다룰 때 `-Path` 옵션을 사용하면 `*`가 와일드카드로 인식되어 명령이 대기 상태에 빠질 수 있습니다. 수동 수정 시 반드시 `-LiteralPath` 옵션을 사용해야 합니다.
* **ZIP 압축 파일 사전 예방:** macOS에서 압축된 `.zip` 파일을 Windows 기본 탐색기로 해제하면 자소가 분리됩니다. 원본 압축 파일이 있는 경우 **반디집(Bandizip)** 또는 **NanaZip**을 사용하여 압축을 해제하면 옵션(`맥에서 압축한 파일의 한글 자소 분리 현상 자동 보정`)을 통해 풀리는 즉시 NFC로 변환됩니다.

---

## 6. 제거 방법 (언인스톨)

등록한 우클릭 메뉴와 스크립트 파일을 삭제하려면 PowerShell에서 아래 명령어를 실행합니다.

```powershell
# 레지스트리 메뉴 제거
Remove-Item -LiteralPath "HKCU:\Software\Classes\*\shell\FixKoreanNFC" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -LiteralPath "HKCU:\Software\Classes\Directory\shell\FixKoreanNFC" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -LiteralPath "HKCU:\Software\Classes\Directory\Background\shell\FixKoreanNFC" -Recurse -Force -ErrorAction SilentlyContinue

# 스크립트 파일 삭제
Remove-Item -LiteralPath "C:\Scripts\FixKoreanNFC.ps1" -Force -ErrorAction SilentlyContinue

Write-Host "제거가 완료되었습니다." -ForegroundColor Yellow
```
