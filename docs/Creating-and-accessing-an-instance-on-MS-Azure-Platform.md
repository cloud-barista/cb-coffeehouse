# A guide to creating and accessing an instance in MS Azure

This article provides a guide to creating and accessing an instance (i.e., a virtual machine) in MS Azure. 

### Table of contents

- [1. Create a virtual machine on the MS Azure portal](#1-Create-a-virtual-machine-on-the-MS-Azure-portal)
 
- [2. Create a virtual machine with MS Azure CLI](#2-Create-a-virtual-machine-with-MS-Azure-CLI)
 
- [3. Access the virtual machine by MobaXterm or Remote Desktop](#3-Access-the-virtual-machine-by-MobaXterm-or-Remote-Desktop)


## 1. Create a virtual machine on the MS Azure portal

### 1.1. Virtual Machine 생성 : 가상 머신 만들기 선택

<p align="center">
  <img src="https://user-images.githubusercontent.com/33706689/129452169-9c24847e-bb7b-4fe3-bdad-46279a7bad7e.png" width="90%" height="90%" >
</p>

### 1.2. Resource Group : 
- Azure 솔루션에 관련된 리소스를 보유하는 컨테이너입니다. 리소스 그룹에는 솔루션에 대한 모든 Resource 또는 Group으로 관리하려는 해당 리소스만 포함될 수 있습니다.
- 새로 만들기 선택 후 리소스 이름 입력

<p align="center">
  <img src="https://user-images.githubusercontent.com/33706689/129452170-16ed89b3-aafd-4034-bcea-f4d256db5b91.png" width="90%" height="90%" >
</p>

### 1.3. 인스턴스 정보 :
- 가상 머신 이름 : Ms Azure에 생성할 VM Name
- 지역 : VM을 생성할 위치
- 이미지 : OS Image
  - Windows 2012-R2, Windows 2016, Window 2019, Ubuntu18, Ubuntu20, CentOS7, CentOS8
- 크기 : 생성할 VM의 CPU, 메모리 크기
- 사용자 이름 : 생성할 VM User Name
- 암호 : 생성할 VM Password
  - Ubuntu : SSH / 암호 설정 둘다 가능
- 인바운드 포트 : VM으로 들어오는 방화벽 규칙

<p align="center">
  <img src="https://user-images.githubusercontent.com/33706689/129452171-1ca600ab-9e1c-4b68-8772-7c9114e379ce.png" width="90%" height="90%" >
</p>

<p align="center">
  <img src="https://user-images.githubusercontent.com/33706689/129452173-25306965-f4e0-41a7-af42-531f3d3d8dd9.png" width="90%" height="90%" >
</p>

<p align="center">
  <img src="https://user-images.githubusercontent.com/33706689/129464405-d2c84956-775e-41a1-b941-c43687fd870b.png" width="90%" height="90%" >
</p>

<p align="center">
  <img src="https://user-images.githubusercontent.com/33706689/129452174-2ef5bfde-2fdc-4489-8f5a-c3ff8a43174c.png" width="90%" height="90%" >
</p>

- Disk : VM에서 사용할 Disk 선택

<p align="center">
  <img src="https://user-images.githubusercontent.com/33706689/129452176-cf33aadc-a4b8-4f1d-bfb2-a85357a42a85.png" width="90%" height="90%" >
</p>

- Network : 
  - 가상 네트워크 : 동일한 가상 네트워크의 가상 머신은 기본적으로 서로 액세스 가능
  - 서브넷 : 가상 네트워크의 일정한 IP 주소 범위 (가상 머신을 서로 격리하거나 인터넷에서 격리하는데 사용)
  - 공용 IP : 가상 네트워크 외부에서 가상 머신과 통신하려는 경우 공유 IP 주소 시용

<p align="center">
  <img src="https://user-images.githubusercontent.com/33706689/129452177-ad47296f-9fa9-4312-a9e4-b412b5748b3c.png" width="90%" height="90%" >
</p>

- Advanced : 
  - 사용자 지정 데이터 (Cloud-init) : VM이 프로비저닝되는 동안 스크립트, 구성 파일 또는 기타 데이터를 가상 머신으로 전달할 수 있습니다.

<p align="center">
  <img src="https://user-images.githubusercontent.com/33706689/129452178-1e99b870-79e0-4b3b-afd9-28fd6e0c3be1.png" width="90%" height="90%" >
</p>
  
- Create VM

<p align="center">
  <img src="https://user-images.githubusercontent.com/33706689/129452179-1b14a9d7-e54b-42dc-ba76-87c22ab9333d.png" width="90%" height="90%" >
</p>


## 2. Create a virtual machine with MS Azure CLI

### 2.1. Install MS Azure CLI
Please, refer to [Install Ms Azure CLI](https://docs.microsoft.com/ko-kr/cli/azure/install-azure-cli)

### 2.2. Steps to create a virtual machine

NOTE - Please, refer to 2.2.8. Parameter Description. (It will be helpful for you in following some steps.)
#### 2.2.1. Login
```
az login -u UserID -p UserPassword
```
#### 2.2.2. Get available VM list
Azure Marketplace에서 사용할 수 있는 VM/VMSS 이미지를 나열
```
az vm image list
```
관련 Options:
  - [-all] : 사용 가능한 이미지를 모두 나열 합니다.
  - [--offer] : 이미지 제품 이름, 부분 이름이 허용 됩니다.
  - [--publisher] : 이미지 게시자 이름, 부분 이름이 허용 됩니다.
  - [--sku] : 이미지 sku 이름, 부분 이름이 (가) 허용 됩니다.
  - [--subscription] : 구독의 이름 또는 ID입니다.

<p align="center">
<img src="https://user-images.githubusercontent.com/33706689/129454996-2923a69b-3a6c-4f5b-bd83-49b2b7dd238d.png" width="90%" height="90%" >
</p>

#### 2.2.3. Create a virtual machine
```
az vm create --resource-group %RESOURCE_GROUP% --name %VM_NAME% --image %VM_IMAGE% --size %VM_SIZE% --admin-username %VM_USER_NAME% --admin-password %VM_PWD% --location %VM_LOCATION%
```

#### 2.2.4. Open port
```
az vm open-port --resource-group %RESOURCE_GROUP% --name %VM_NAME% --port "VM_Port_Num"
```

#### 2.2.5. Attach disk 
```
az vm disk attach -g %RESOURCE_GROUP% --name %VM_NAME% --name %VM_DISK_NAME% --new --size-gb %VM_DISK_SIZE%
```

#### 2.2.6. Run the PowerShell Script on the virtual machine
```
az vm run-command invoke -g %RESOURCE_GROUP% -n %VM_NAME% --command-id RunPowerShellScript --script "Powershell_Script"
```

#### 2.2.7. Check the virtual machine
```
az vm show --resource-group %RESOURCE_GROUP%  --name %VM_NAME%
```

#### 2.2.8. Parameter Description
- [RESOURCE_GROUP](https://docs.microsoft.com/ko-kr/cli/azure/group?view=azure-cli-latest#az_group_create) : 사용할 RESOURCE_Group
```
// Resource_Group을 새로 생성
az group create --location %LOCATION% --name "사용할 Resource_Group_Name"

// Resource_Group이 있는지 확인
az group exists --name "확인할 Resource_Group_Name"
```
- VM_NAME : 사용할 VM 이름
- [VM_IMAGE](https://docs.microsoft.com/ko-kr/cli/azure/vm/image?view=azure-cli-latest#az_vm_image_list) : VM OS version
```
// 사용 가능한 이미지를 모두 나열
az vm image list --all

// 모든 CentOS 이미지를 나열
az vm image list -f CentOS --all
```
- VM_SIZE : 생성할 VM의 CPU, 메모리 크기
```
// 미국 서 부 지역에서 사용 가능한 VM 크기 나열
az vm list-sizes -l westus
```
- VM_USER_NAME : 생성할 VM User Name
- VM_PWD : 생성할 VM Password
- VM_LOCATION : VM을 생성할 지역
```
// 현재 구독에 대해 지원 되는 영역을 나열
az account list-locations
```
- VM_Port_Num : 생성된 VM의 열어 둘 포트 번호
- VM_DISK_NAME : 생성된 VM에 추가할 DISK Name
- VM_DISK_SIZE : 생성된 VM에 추가할 DISK Size (단위 : GB)

## 3. Access the virtual machine by MobaXterm or Remote Desktop

### 3.1. Access the virtual machine by Remote Desktop

- VM 생성 후 Resource Group에 생성되는 리소스들

<p align="center">
<img src="https://user-images.githubusercontent.com/33706689/129464565-5e01d710-4e0a-4dcc-a0c3-73e2d8b0894d.png" width="90%" height="90%" >
</p>

- Windows Virtual Machine Public IP를 확인

<p align="center">
<img src="https://user-images.githubusercontent.com/33706689/129464557-ce378630-ec3c-47d0-9a39-292bcc4575cd.png" width="90%" height="90%" >
</p>

- 로컬 PC의 Remote Desktop에서 Virtual Machine 연결
<p align="center">
<img src="https://user-images.githubusercontent.com/33706689/129464558-cb0b7712-cf53-40cb-82dd-d24c2ade38bd.png" width="90%" height="90%" >
</p>

- 사용자 자격 증명입력
<p align="center">
<img src="https://user-images.githubusercontent.com/33706689/129464559-f277ca23-9e8d-4888-b8e4-8adf6365136d.png" width="90%" height="90%" >
</p>

- 접속 확인

<p align="center">
<img src="https://user-images.githubusercontent.com/33706689/129464561-c51b54d3-bc0b-443c-9242-91d7ed216b7c.png" width="90%" height="90%" >
</p>


### 3.1. Access the virtual machine by MobaXterm

- Linux Virtual Machine Public IP를 확인

<p align="center">
<img src="https://user-images.githubusercontent.com/33706689/129464562-1f81d80a-dcfe-4bd2-8c70-412b1f201d7f.png" width="90%" height="90%" >
</p>

  
- 로컬 PC의 MobaXterm에서 Virtual Machine 연결

<p align="center">
<img src="https://user-images.githubusercontent.com/33706689/129464563-399440fa-dbf2-49d9-9b5f-4d11c04752a5.png" width="90%" height="90%" >
</p>

- 접속 확인
<p align="center">
<img src="https://user-images.githubusercontent.com/33706689/129464564-1115a1b2-fa44-43ea-bcc8-6c9d34a70e52.png" width="90%" height="90%" >
</p>
