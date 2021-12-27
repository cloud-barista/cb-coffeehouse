Multi-Factor Authentication (MFA) 설정 후 GitHub Actions의 워크플로우 업데이트를 위해 기존 워크플로우를 수정, 커밋, 푸시하던 도중

**How to resolve “refusing to allow an OAuth App to create or update workflow” on git push** 문제가 발생하였고

이를 해결한 방법을 공유 드립니다.

운영체제는 Windows 10를 사용 중 입니다.

### [예상 원인]
1. 기존에 사용하던 인증 정보는 Username + Password 기반이었기 때문에 Workflow 권한 설정이 안되어 있을 가능성이 있습니다.
2. 기존에 사용하던 인증 정보는 Personal Access Token (PAT) 기반 인증 이었음에도 Workflow 권한 설정안했을 가능성이 있습니다.

### [해결 방법]
1. 기존 인증 정보를 삭제 합니다.
   - Windows 키 > 자격 증명 관리자 > Windows 자격 증명
   - GitHub 관련 자격 증명을 삭제
<p align="center">
  <img src="https://user-images.githubusercontent.com/7975459/108473380-4d90d200-72d1-11eb-96c0-4b58f51fbaf4.png">
</p>
<p align="center">
  <img src="https://user-images.githubusercontent.com/7975459/108473401-541f4980-72d1-11eb-9b10-c9e74b99a032.png">
</p>
<p align="center">
  <img src="https://user-images.githubusercontent.com/7975459/108473437-5da8b180-72d1-11eb-9b1c-391929443a7d.png">
</p>

2. GitHub Docs의 [Creating a personal access token](https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token)을 참고하여 PAT를 생성(**PAT 생성 시 workflow 체크!!**) 합니다.
<p align="center">
  <img src="https://user-images.githubusercontent.com/7975459/108457980-fd0c7b00-72b6-11eb-952f-fdf5c53e37b5.png" width="70%" height="70%" >
</p>

3. PAT 생성(기존에 생성한 PAT가 있는데 저장하지 않았다면 Regenerate ..)
   - 복사해두세요~~

4. Push를 진행하면 로그인창(+MFA)이 뜨는데 이때 **Username과 조금 전 생성한 PAT 입력합니다.**