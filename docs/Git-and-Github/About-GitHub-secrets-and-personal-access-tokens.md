# About GitHub secrets and personal access tokens

We sometimes see **`GITHUB_TOKEN` secret** when using GitHub Actions (e.g., `github-token: ${{secrets.GITHUB_TOKEN}}`). And also, there is another token which is **the personal access tokens (PATs)**. I would like to describe those and I hope this is helpful for you to understand the secrets and tokens.

This article mainly describes the use of GitHub secrets (e.g., `GITHUB_TOKEN` secret) in GitHub Actions. PATs will be described briefly. Of course, Those could be used in many ways. 

## Two Tokens?
Actually, one is the secret and another is the token.
- **`GITHUB_TOKEN` secret**: This is **a secret in a repository**.
  - You can see this menu on `In a repository > Setting > Secrets`
- **Personal access token**: This is **an alternative to using passwords for authentication to GitHub** when using the GitHub API or the command line.
  - You can see this menu on `Profile image in the top right > Setting > Developer settings > Personal access tokens`


## Secrets
Secrets include:
- encrypted secrets, and
- `GITHUB_TOKEN` secret.
### Encrypted secrets
Secrets are encrypted environment variables that you create in a repository or organization. The secrets you create are available to use in GitHub Actions workflows.

Please, see [Encrypted secrets](https://docs.github.com/en/free-pro-team@latest/actions/reference/encrypted-secrets) from GitHub Docs.

### GITHUB_TOKEN secret
GitHub automatically creates a `GITHUB_TOKEN` secret to use in your workflow. You can use the `GITHUB_TOKEN` to authenticate in a workflow run.

Please, see [Authentication in a workflow](https://docs.github.com/en/free-pro-team@latest/actions/reference/authentication-in-a-workflow) from GitHub Docs.


## Personal access tokens
You should create a personal access token to use in place of a password with the command line or with the API.
### How to create a personal access token
Please, see [Creating a personal access token](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/creating-a-personal-access-token) from GitHub Docs.
### Example
To authenticate against the GitHub Container Registry, you will need to create a new personal access token (PAT) with the appropriate scopes. (see [here](https://github.com/docker/login-action#github-container-registry))


## References (Unorganized)
- [Build and push Docker images](https://github.com/marketplace/actions/build-and-push-docker-images)
- [Publishing Docker images](https://docs.github.com/en/free-pro-team@latest/actions/guides/publishing-docker-images)
- [Encrypted secrets](https://docs.github.com/en/free-pro-team@latest/actions/reference/encrypted-secrets)
- [Secrets in Actions](https://docs.github.com/en/free-pro-team@latest/rest/reference/actions#secrets)
- [Github Actions으로 배포 자동화하기](https://velog.io/@bluestragglr/Github-Action%EC%9C%BC%EB%A1%9C-%EB%B0%B0%ED%8F%AC-%EC%9E%90%EB%8F%99%ED%99%94%ED%95%98%EA%B8%B0)
- [Creating a personal access token](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/creating-a-personal-access-token)
- [Authentication in a workflow](https://docs.github.com/en/free-pro-team@latest/actions/reference/authentication-in-a-workflow)
- [github api 사용방법](https://taetaetae.github.io/2017/03/02/github-api/)
- [GitHub 인증을 위한 개인 액세스 토큰 생성하기](https://jootc.com/p/201905122828)
- [[Github Actions] Github API를 사용하는 스크립트 모음](https://eunjin3786.tistory.com/194)
- [Creating a Personal Access Token for GitHub](https://medium.com/@isharailanga/creating-a-personal-access-token-for-github-dbc453158029)