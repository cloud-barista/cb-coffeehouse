# How to deploy KeyCloak on Kubernetes

I would like to briefly summarize how to deploy Keycloak on Kubernetes.

## Prerequisites
- Kubernetes cluster
- `service.type: LoadBalancer` available

## Get started with Keycloak

1. Check the version of Keycloak container image (see [Keycloak website](https://www.keycloak.org/))
2. (Optional) Create a directory for manifests (i.e., keycloak.yaml)
    ```bash
    mkdir keycloak
    cd keycloak
    ```
3. Get Keycloak YAML
    ```bash
    wget -q -O - https://raw.githubusercontent.com/keycloak/keycloak-quickstarts/latest/kubernetes/keycloak.yaml
    ```
4. Set the version (e.g., `$$VERSION$$` -> 22.0.1)
    ```bash
    sed -i 's/\$\$VERSION\$\$/22.0.1/g' keycloak.yaml
    ```
5. Change admin ID and password
    - Default ID and password: admin
    - Modify `[MODIFY_HERE]` in the following command (e.g., `sed -i 's/admin/coffee/g' keycloak.yaml``)
    ```bash
    sed -i 's/admin/[MODIFY_HERE]/g' keycloak.yaml
    ```
6. Create Keycloak
    ```bash
    kubectl create -f keycloak.yaml
    ```
7. Check if it's running
    - Check pod
        ```bash
        kubectl get pod 
        ```
        (Result)
        ```
        NAME                        READY   STATUS    RESTARTS   AGE
        keycloak-64fd66c46c-tfptm   1/1     Running   0          37h
        ```
    - Check service
        ```
        kubectl get svc
        ```
        (Result - EXTERNAL_IP is masked)
        ```    
        NAME         TYPE           CLUSTER-IP       EXTERNAL-IP       PORT(S)          AGE
        keycloak     LoadBalancer   10.254.226.212   xxx.xxx.xxx.xxx   8080:30059/TCP   37h
        ```
8. Open and explore Keycloak website
    <p align="center">
        <img src="https://github.com/cloud-barista/cb-coffeehouse/assets/7975459/7249b18c-47df-4d3f-acf4-e78636eb701d" width="100%" height="100%">
    </p>

## References
- [Get started with Keycloak on Kubernetes](https://www.keycloak.org/getting-started/getting-started-kube)
- [keycloak 이란??](https://league-cat.tistory.com/397)
- [AWS 에서 Keycloak 기반 서비스 인증 체계 구축 하기 (1편) - 키클록(Keycloak) 이란?](https://devocean.sk.com/blog/techBoardDetail.do?ID=165131)
- [Keycloak 설치 구성](https://tommypagy.tistory.com/441)
- [[Keycloak] 설치 및 간단한 SSO 인증 시스템 구현](https://to-moneyking.tistory.com/79)
