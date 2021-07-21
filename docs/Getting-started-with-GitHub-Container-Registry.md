# Getting started with GitHub Container Registry
Command Line Interface (CLI)와 GitHub Actions에서 GitHub Container Registry를 사용하는 방법을 설명합니다. 순차적으로 따라할 수 있도록 구성하였습니다. GitHub Container Registry에 대한 설명은 다음 글을 참고하세요. :smile:

:arrow_forward: [About GitHub Container Registry](https://github.com/cb-contributhon/cb-coffeehouse/wiki/About-GitHub-Container-Registry)

## Prerequisites
### Personal access token (PAT)
:arrow_forward: [About GitHub secrets and personal access tokens](https://github.com/cb-contributhon/cb-coffeehouse/wiki/About-GitHub-secrets-and-personal-access-tokens)
#### Steps to create a personal access token
1. GitHub 로그인

2. 우측 상단 GitHub Profile 클릭(아래 그림 참고)   
<p align="center">
  <img src="https://user-images.githubusercontent.com/7975459/96961140-066f1c00-153f-11eb-8ee5-5688a1b430e6.png" width="20%" height="20%" >
</p>

3. Settings 클릭

4. 좌측 목록 하단의 Developer settings 클릭

5. 좌측 목록 하단의 Personal access tokens 클릭

6. 우측 상단의 Generate new tokens 클릭 

7. Note 입력

8. Scope 선택 

   1. "Select scopes"에 있는 Read more about OAuth scopes 링크를 참고하시기 바랍니다.

   2. GHCR사용을 위해서는 주로 `write:packages`,`read:packages`, `delete:packages`를 선택합니다.

   3. `repo` scope에 대해서는 아래 노트를 참고하기 바랍니다.(모든 Collaborators의 Repository 접근 허용과 관련 있습니다.)

      > **Note:** If you select the `write:packages` scope, deselect the `repo` scope when creating the PAT. Adding a PAT with the `repo` scope as a secret in your repository allows the credential to be accessible to all collaborators in the repository. This gives unnecessary additional access when a PAT with the `repo` scope is used within an action. For more information on security best practices for actions, see "[Security hardening for GitHub Actions](https://docs.github.com/en/free-pro-team@latest/actions/getting-started-with-github-actions/security-hardening-for-github-actions#considering-cross-repository-access)." - *[Authenticating to GitHub Container Registry](https://docs.github.com/en/free-pro-team@latest/packages/managing-container-images-with-github-container-registry/pushing-and-pulling-docker-images#authenticating-to-github-container-registry)*

9. Generate token 클릭

## How to use GHCR
### Using GHCR with Command Line Interface (CLI)

1. GitHub Container Registry 로그인

   ```bash
   docker login ghcr.io -u <YOUR_GITHUB_ID>
   ```

2. Container image 조회

   ```bash
   docker images -a
   ```

3. 이미지 태그

   ```bash
   docker tag <YOUR_IMAGE_ID> ghcr.io/<YOUR_GITHUB_ID>/<YOUR_IMAGE_NAME>:<YOUR_TAG>
   ```

4. 이미지 푸시

   ```
   docker push ghcr.io/<YOUR_GITHUB_ID>/<YOUR_IMAGE_NAME>:<YOUR_TAG>
   ```

### Using GHCR with GitHub Actions

To be updated
   

## Where to find container images
- Organization > Packages (e.g., [Packages in Cloud-Barista organization](https://github.com/orgs/cloud-barista/packages))

  ![image](https://user-images.githubusercontent.com/7975459/96963197-302a4200-1543-11eb-82d1-be6cdc03d781.png)

- Private account > Packages
