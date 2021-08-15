# A guide to creating and accessing an instance in MS Azure

> [1. Create Virtual Machine With Web](#1-Create-Virtual-Machine-With-Web)
> 
> [2. Create Virtual Machine With CLI](#2-Create-Virtual-Machine-With-CLI)
> 
> [3. Running Virtual Machine With MobaXterm and Remote desktop](#3-Running-Virtual-Machine-With-MobaXterm-and-remote-desktop)


## #1-Create-Virtual-Machine-With-Web

  ### Virtual Machine 생성 : 가상 머신 만들기 선택

      ![1](https://user-images.githubusercontent.com/33706689/129452169-9c24847e-bb7b-4fe3-bdad-46279a7bad7e.png)

  ### Resource Group : 
    - Azure 솔루션에 관련된 리소스를 보유하는 컨테이너입니다. 리소스 그룹에는 솔루션에 대한 모든 Resource 또는 Group으로 관리하려는 해당 리소스만 포함될 수 있습니다.
    - 새로 만들기 선택 후 리소스 이름 입력

      ![2](https://user-images.githubusercontent.com/33706689/129452170-16ed89b3-aafd-4034-bcea-f4d256db5b91.png)

  ### 인스턴스 정보 :
    - 가상 머신 이름 : Ms Azure에 생성할 VM Name
    - 지역 : VM을 생성할 위치
    - 이미지 : OS Image
      - Windows 2012-R2, Windows 2016, Window 2019, Ubuntu18, Ubuntu20, CentOS7, CentOS8
    - 크기 : 생성할 VM의 CPU, 메모리 크기
    - 사용자 이름 : 생성할 VM User Name
    - 암호 : 생성할 VM Password
      - Ubuntu : SSH / 암호 설정 둘다 가능
    - 인바운드 포트 : VM으로 들어오는 방화벽 규칙

      ![3](https://user-images.githubusercontent.com/33706689/129452171-1ca600ab-9e1c-4b68-8772-7c9114e379ce.png)

      ![4](https://user-images.githubusercontent.com/33706689/129452173-25306965-f4e0-41a7-af42-531f3d3d8dd9.png)

      ![4-1](https://user-images.githubusercontent.com/33706689/129464405-d2c84956-775e-41a1-b941-c43687fd870b.png)

      ![5](https://user-images.githubusercontent.com/33706689/129452174-2ef5bfde-2fdc-4489-8f5a-c3ff8a43174c.png)

  - Disk : VM에서 사용할 Disk 선택

      ![6](https://user-images.githubusercontent.com/33706689/129452176-cf33aadc-a4b8-4f1d-bfb2-a85357a42a85.png)

  - NetWork : 
    - 가상 네트워크 : 동일한 가상 네트워크의 가상 머신은 기본적으로 서로 액세스 가능
    - 서브넷 : 가상 네트워크의 일정한 IP 주소 범위 (가상 머신을 서로 격리하거나 인터넷에서 격리하는데 사용)
    - 공용 IP : 가상 네트워크 외부에서 가상 머신과 통신하려는 경우 공유 IP 주소 시용

      ![7](https://user-images.githubusercontent.com/33706689/129452177-ad47296f-9fa9-4312-a9e4-b412b5748b3c.png)

  - advanced : 
    - 사용자 지정 데이터 (Cloud-init) : VM이 프로비저닝되는 동안 스크립트, 구성 파일 또는 기타 데이터를 가상 머신으로 전달할 수 있습니다.

      ![8](https://user-images.githubusercontent.com/33706689/129452178-1e99b870-79e0-4b3b-afd9-28fd6e0c3be1.png)
    
  - Create VM

      ![9](https://user-images.githubusercontent.com/33706689/129452179-1b14a9d7-e54b-42dc-ba76-87c22ab9333d.png)



## #2-Create-Virtual-Machine-With-CLI

  - [Ms Azure CLI download](https://docs.microsoft.com/ko-kr/cli/azure/install-azure-cli)

  - Ms Azure CLI Command

    1. az login -u UserID -p UserPassword
  
    2. az vm image list : Azure Marketplace에서 사용할 수 있는 VM/VMSS 이미지를 나열
      - [-all] : 사용 가능한 이미지를 모두 나열 합니다.
      - [--offer] : 이미지 제품 이름, 부분 이름이 허용 됩니다.
      - [--publisher] : 이미지 게시자 이름, 부분 이름이 허용 됩니다.
      - [--sku] : 이미지 sku 이름, 부분 이름이 (가) 허용 됩니다.
      - [--subscription] : 구독의 이름 또는 ID입니다.

      ![10](https://user-images.githubusercontent.com/33706689/129454996-2923a69b-3a6c-4f5b-bd83-49b2b7dd238d.png)

    3. az vm create --resource-group %RESOURCE% --name %VM_NAME% --image %VM_IMAGE% --size %VM_SIZE% --admin-username %VM_USER_NAME% --admin-password %VM_PWD% --location %VM_LOCATION% : 조건에 VM 생성

    4. az vm open-port --resource-group %RESOURCE% --name %VM_NAME% --port "VM_Port_Num" : VM Port 열기

    5. az vm disk attach -g %RESOURCE% --name %VM_NAME% --name "VM_DISK_NAME --new --size-gb %VM_SIZE% : 생성된 VM에 Disk 추가

    6. azure group delete --name %RESOURCE% : Ms Azure Resource Group 삭제

    7. az vm delete -g %RESOURCE% -n %VM_NAME% --yes : Ms Azure VM 삭제

    8. az vm run-command invoke -g %RESOURCE% -n %VM_NAME% --command-id RunPowerShellScript --script "Powershell_Script" : Ms Azure Windows VM Powershell Script 실행

    9. az vm show --resource-group %RESOURCE%  --name %VM_NAME% : Ms Azure VM 확인



## #3-Running-Virtual-Machine-With-MobaXterm-and-remote-desktop

  - VM 생성 후 Resource Group에 생성되는 리소스들

    ![11](https://user-images.githubusercontent.com/33706689/129464565-5e01d710-4e0a-4dcc-a0c3-73e2d8b0894d.png)

  - Running Windows Virtual Machine

    1. Windows Virtual Machine Public IP를 확인

      ![12](https://user-images.githubusercontent.com/33706689/129464557-ce378630-ec3c-47d0-9a39-292bcc4575cd.png)

    2. 로컬 PC의 remote desktop에서 Virtual Machine 연결

      ![13](https://user-images.githubusercontent.com/33706689/129464558-cb0b7712-cf53-40cb-82dd-d24c2ade38bd.png)

      ![14](https://user-images.githubusercontent.com/33706689/129464559-f277ca23-9e8d-4888-b8e4-8adf6365136d.png)

    3. 접속 확인

      ![15](https://user-images.githubusercontent.com/33706689/129464561-c51b54d3-bc0b-443c-9242-91d7ed216b7c.png)


  - Running Linux Virtual Machine

    1. Linux Virtual Machine Public IP를 확인

      ![16](https://user-images.githubusercontent.com/33706689/129464562-1f81d80a-dcfe-4bd2-8c70-412b1f201d7f.png)
    
    2. 로컬 PC의 MobaXterm에서 Virtual Machine 연결

      ![17](https://user-images.githubusercontent.com/33706689/129464563-399440fa-dbf2-49d9-9b5f-4d11c04752a5.png)

    3. 접속 확인

      ![18](https://user-images.githubusercontent.com/33706689/129464564-1115a1b2-fa44-43ea-bcc8-6c9d34a70e52.png)