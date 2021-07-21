Note - This article was edited on July 6th, 2021. You can freely improve this article whenever you want.

Credentials are unfamiliar for cloud beginners who use cloud management consoles for the first time :sweat:

I hope this article will be helpful to those who are having trouble creating credentials. :sunglasses:

**This article was written based on [poc-farmoni's README](https://github.com/cloud-barista/poc-farmoni), and I would like to express my gratitude to the contributors, <ins>[powerkimhub](https://github.com/powerkimhub), [seokho-son](https://github.com/seokho-son), and [jihoon-seo](https://github.com/jihoon-seo)</ins>.**

## Index
- [Amazon Web Services (AWS)](https://github.com/cloud-barista/cb-coffeehouse/wiki/A-step-by-step-guide-to-creating-credentials-of-each-cloud-service-provider#amazon-web-services-aws) 
- [Google Cloud Platform (GCP)](https://github.com/cloud-barista/cb-coffeehouse/wiki/A-step-by-step-guide-to-creating-credentials-of-each-cloud-service-provider#google-cloud-platform-gcp)
- [Microsoft (MS) Azure](https://github.com/cloud-barista/cb-coffeehouse/wiki/A-step-by-step-guide-to-creating-credentials-of-each-cloud-service-provider#microsoft-ms-azure)
- [Alibaba Cloud](https://github.com/cloud-barista/cb-coffeehouse/wiki/A-step-by-step-guide-to-creating-credentials-of-each-cloud-service-provider#alibaba-cloud)


## A step-by-step guide to creating credentials of each cloud service provider
### Amazon Web Services (AWS)
Reference: [Getting Started with the AWS SDK for Go](https://docs.aws.amazon.com/ko_kr/sdk-for-go/v1/developer-guide/setting-up.html)

1. Sign In to the Console

2. Open the [IAM console](https://console.aws.amazon.com/iam/home)
![image](https://user-images.githubusercontent.com/7975459/113285829-5e981e80-9326-11eb-8ead-4e589612fc20.png)

3. Choose your IAM user name (not the check box).
If the IAM user name doesn't exist, please add it.
![image](https://user-images.githubusercontent.com/7975459/113286508-44127500-9327-11eb-892e-134dcc4e921c.png)

4. Open the Security credentials tab, and then choose Create access key.
![image](https://user-images.githubusercontent.com/7975459/113286791-a4091b80-9327-11eb-8e61-ef875c6439de.png)

5. To see the new access key, choose Show. Your credentials resemble the following:
- Access key ID: AKIAIOSFODNN7EXAMPLE
- Secret access key: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY

6. To download the key pair, choose Download .csv file. Store the keys
![image](https://user-images.githubusercontent.com/7975459/113286963-df0b4f00-9327-11eb-8ccc-0a43690e4fdc.png)

* * *

### Google Cloud Platform (GCP)
Reference: [Launching a Google Compute Instance via the API](https://github.com/danackerson/googleComputeEngine)

1. Sign In to the Console

2. Create a project
![image](https://user-images.githubusercontent.com/7975459/113289811-ae2d1900-932b-11eb-87c3-3568039469cf.png)

3. Create a new Account including the roles "Compute Admin" & "Service Account User"
![image](https://user-images.githubusercontent.com/7975459/113289956-e7658900-932b-11eb-9a39-17302954fa36.png)
![image](https://user-images.githubusercontent.com/7975459/113290257-57740f00-932c-11eb-85c3-0636c6ffdaf3.png)

4. Choose the created service account
![image](https://user-images.githubusercontent.com/7975459/113290442-9bffaa80-932c-11eb-84db-2983b89261f7.png)

5. Open the KEYS tab, choose ADD KEY, and choose to CREATE (The private key is automatically saved to your computer.)
![image](https://user-images.githubusercontent.com/7975459/113290653-e97c1780-932c-11eb-81f3-4dbf559f30b3.png)

* * *

### Microsoft (MS) Azure
Reference: [Manage credentials in Azure Automation - Create a new credential asset](https://docs.microsoft.com/en-us/azure/automation/shared-resources/credentials?tabs=azure-powershell#create-a-new-credential-asset)

#### Command-line interface (CLI)
- Azure CLI 인증 키 설정
```Shell
# curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
# az login
# mkdir ~/.azure
# cd ~/.azure
# az ad sp create-for-rbac --sdk-auth > azure.auth
```

- VM SSH 접속 키
```Shell
# cp ~/.gcp/gce-vm-key ~/.azure/azure-vm-key
# cp ~/.gcp/gce-vm-key.pub ~/.azure/azure-vm-key.pub
# ssh -i “~/.azure/azure-vm-key" <username>@<VM IP addr>
```

#### Portal
1. Sign In to the Portal

2. Open Azure Active Directory
![image](https://user-images.githubusercontent.com/7975459/113390983-ba69b280-93cd-11eb-9631-467bfca5d3ab.png)

3. Open App registrations
![image](https://user-images.githubusercontent.com/7975459/113391202-1fbda380-93ce-11eb-8e57-53cf092b9f09.png)

4. Create a New registration   
**NOTE - After creation, save the application (client) ID, Object ID, and Directory (tenant) ID**
![image](https://user-images.githubusercontent.com/7975459/113391370-68755c80-93ce-11eb-836b-a1cbca7e0d41.png)

5. Open Certificates & secrets and create a New client secrets   
**NOTE - Save client secrets' key and value because you won't be able to see it later**
![image](https://user-images.githubusercontent.com/7975459/113392272-d40bf980-93cf-11eb-9054-76537ca18694.png)

6. Expose an API by adding a scope
![image](https://user-images.githubusercontent.com/7975459/122876686-c469d480-d370-11eb-90ee-165204f54119.png)

7. Open Subscriptions   
**NOTE - Save the subscription ID**
![image](https://user-images.githubusercontent.com/7975459/122875427-32ad9780-d36f-11eb-91cd-66c967d62768.png)

8. Choose a subscription to allocate the app
![image](https://user-images.githubusercontent.com/7975459/122875787-aea7df80-d36f-11eb-9258-1195e7937236.png)

9. Add role assignment on Access control (IAM)
![image](https://user-images.githubusercontent.com/7975459/122876035-fd557980-d36f-11eb-8a46-31d756f7da4a.png)

The following will be needed for API calls.
- Client ID
- ClientSecret (Value)
- Tenant ID
- Subscription ID

* * *

### Alibaba Cloud
Reference: [Create an AccessKey pair for a RAM user](https://www.alibabacloud.com/help/doc-detail/116401.htm)

1. Sign In to the console
![image](https://user-images.githubusercontent.com/7975459/124533628-a78fcf80-de4d-11eb-9589-3e54ede3bda7.png)

2. Open the [RAM console](https://ram.console.aliyun.com/overview) 

3. Choose Identities > Users and then choose Create User
![image](https://user-images.githubusercontent.com/7975459/124534424-34875880-de4f-11eb-9239-55e5465eccf2.png)

4. Fill in the form
![image](https://user-images.githubusercontent.com/7975459/124534777-e45cc600-de4f-11eb-827c-446a2db37edd.png)

5. Click the username of the target RAM user in the User Logon Name/Display Name column
![image](https://user-images.githubusercontent.com/7975459/124535198-b461f280-de50-11eb-982b-b6f214608495.png)

6. Click Create Access Key and download the Access Key   
**NOTE - Save client secrets' key and value because you won't be able to see it later**
![image](https://user-images.githubusercontent.com/7975459/124535542-3a7e3900-de51-11eb-9eb0-782a8b004926.png)

7. Setup permission (if needed)
![image](https://user-images.githubusercontent.com/7975459/124535855-da3bc700-de51-11eb-9f02-040da88f99c8.png)

The following will be needed for API calls.
- AccessKeyId
- AccessKeySecret


# Additional contributions are always welcome 😍 