# terraform-vms  
**Kevin Steven Nieto Curaca - A00395466**  

In this project, we successfully built two virtual machines, one running Linux and the other Windows, using Terraform. For this, we leveraged the infrastructure provided by Azure services, specifically using the following resources:  

### Providers  

1. **azurerm**: Responsible for providing and managing the necessary commands to use Azure resources.  
2. **random_string**: Used to generate random text strings to save time when creating unique names, mainly for domain names.  

### Resources  

1. **Resource Group**: Used as a container for all resources. In this case, we used the "East US" location.  
2. **Azure Virtual Network**: Creates the virtual space where all resources will reside. It is essential to define the IP range for this space; in this project, we used `10.0.0.0/16`.  
3. **Azure Subnet**: Related to the virtual network, subnets can be created. In this case, a `/24` subnet was applied to increase the number of available networks.  
4. **Azure Public IP**: Used to uniquely identify a resource on the internet. Each VM must have its own public IP if remote access is needed.  
5. **Azure Network Interface Card (NIC)**: Provides the network interface for each VM. Like the public IP, each NIC must be unique per resource. It is assigned to the subnet where the VM will reside and is linked to a previously created IP address.  
6. **Azure Network Security Group (NSG)**: After setting up the necessary networking resources, security rules must be configured for each NIC.  
   - For the **Linux VM**, an SSH connection is allowed via **port 22**.  
   - For the **Windows VM**, RDP access is allowed via **port 3389**.  
7. **Network NIC and Security Group Association**: Each NSG must be linked to its corresponding NIC to enforce the configured security rules. This resource handles that association.  

### Solution Diagram  

![image](https://github.com/user-attachments/assets/7246308c-cda9-4c7e-a309-859df4b53c8e)

![image](https://github.com/user-attachments/assets/8a9973d4-b198-4848-8aae-ddef71f92d71)

It is important to note that both VMs can be in the same Virtual Network and Subnet, as applied in this case. The only elements that must be unique are the **NIC** and the **Public IP**.  

Regarding the project structure, the **main file was divided into five files**, each named in the format **c1-functionX, c2-functionY**, and so on.  

To avoid code duplication, Terraform's `count` parameter was used in resources that needed replication. This allows defining the number of instances to be created for a specific resource, and these instances can later be accessed as a list.  

The `count` parameter was used for:  
- NIC creation  
- Public IPs  
- NIC and NSG associations  

Everything was managed through **variables** using the `terraform.tfvars` file, making it a configurable setup.  

## Selected VM Images  

It is important to define the VM sizes and OS images used:  

## Virtual Machine Specifications  

| **Resource**  | **Name**         | **Size**              | **Disk Type**  | **Image**  |  
|--------------|-----------------|----------------------|---------------|------------|  
| **Linux VM**  | `linuxvm-1`      | Standard_DS1_v2      | Standard_LRS  | RedHat RHEL 8.3 (Gen2) |  
| **Windows VM** | `windowsvm-1`   | Standard_B1s        | Standard_LRS  | Windows Server 2022 Datacenter Azure Edition |  

### Additional Details  

- **VM Names**:  
  - **Linux VM**: `linuxvm-1`  
  - **Windows VM**: `windowsvm-1`  

- **Sizes**:  
  - **Linux VM**: `Standard_DS1_v2`  
  - **Windows VM**: `Standard_B1s`  
  - Pricing and specifications vary based on the selected Azure VM size.  

- **Disks**:  
  - **Standard_LRS** storage is used for the OS disk.  

- **Images**:  
  - **Linux**: RedHat RHEL 8.3 (Gen2), latest available version.  
  - **Windows**: Windows Server 2022 Datacenter Azure Edition, latest available version.  

### Cost Considerations  
- VM size and disk pricing depend on the selected Azure region.  
- For exact pricing, refer to the [Azure Pricing Calculator](https://azure.microsoft.com/en-us/pricing/calculator/).  

### Connection Verification  

1. **SSH connection to the Linux VM** via port **22** using the private key:

![image](https://github.com/user-attachments/assets/a5fa5658-1af1-41e8-bdfe-8b113d25fa77)

![image](https://github.com/user-attachments/assets/a22b7911-b22f-4358-ac8b-1287acc3777d)

2. **RDP connection to the Windows VM** via port **3389**, using the configured username and password:

![image](https://github.com/user-attachments/assets/1779fde9-4c7a-4608-9e0d-919537deee9f)

**Note:**  
When connecting to the Windows VM, I encountered several issues due to a supposed certificate error. This problem occurs when the **Windows VM resource name does not match the computer name**. If they are not identical, FreeRDP (used for connecting from Linux to the Windows VM) will throw an error. To avoid this, the names must be the same.  
Finally i got the same certification error,  so the problem is not completely related to the computers and resource name.  In order to solve this problem I change my windows OS to :

![image](https://github.com/user-attachments/assets/6180cebd-3eca-41a3-8cab-2a3ddea988d6)

And then i can connect again, also I modified the terraform code to allow the SSH connection by Username and Password, avoiding the use of .pem to insert manually private keys.

## Terraform State and Azure Setup

### Terraform State File

The `terraform.tfstate` file is automatically created when you run `terraform apply` for the first time. This file:

- Tracks the current state of your deployed infrastructure
- Maps real-world resources to your configuration
- Stores metadata about your resource configuration
- Is critical for Terraform to understand what has been deployed and what needs to change

The state file is located in the terraform-manifests directory and should be treated with care as it contains sensitive information.

### Azure Authentication Process

To deploy resources to Azure using Terraform, you first need to authenticate using the Azure CLI:

```bash
az login
```

This command opens a web browser for authentication. If the browser fails to open (as it did in my case with Wayland display), it falls back to X11:

```
A web browser has been opened at https://login.microsoftonline.com/organizations/oauth2/v2.0/authorize. 
Please continue the login in the web browser. If no web browser is available or if the web browser 
fails to open, use device code flow with `az login --use-device-code`.
Error: Failed to open Wayland display, fallback to X11. WAYLAND_DISPLAY='wayland-0' DISPLAY=':0'
```

After authentication, you'll see your available tenants and subscriptions:

```
No     Subscription name    Subscription ID                       Tenant
-----  -------------------  ------------------------------------  -----------------
[1] *  Azure for Students   xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  Universidad Icesi
```

In this case, I'm using the Universidad Icesi tenant with the Azure for Students subscription. Once authenticated, Terraform can use these credentials to deploy resources to your Azure subscription.

### Deployment Script

First config the `terraform.tfvars` file with your Azure credentials and other necessary variables. This file is used to set the values for the variables defined in the Terraform configuration files.
that is ignored by git, so you can create your own file with the same name and set the values for the variables.  
```bash
cd terraform-manifests
```

```bash
touch terraform.tfvars
```

```
my-subscription_id = ""
rs-location = "eastus"
rs-name = ""
password = ""
user = "azureuser"
```

Then, initialize the Terraform working directory:

```bash
chmod +x creation.sh
./creation.sh
```

This script handles the necessary Terraform commands to initialize, plan, and apply the configuration to create the virtual machines in Azure.

then connect to the VMs using SSH for Linux and RDP for Windows.  
```bash
ssh azureuser@<linux_vm_public_ip>
```

then install git and config the git user
```bash
sudo apt install git
git config --global user.name "espinosa"
git config --global user.email "santiagoespinosagiraldo@gmail.com"
```
config ssh key
```bash
ssh-keygen -t ed25519 -C "santiagoespinosagiraldo1@gmail.com"
```
```bash
cat ~/.ssh/id_ed25519.pub
```
copy the public key and add it to your github account, then add the private key to the ssh agent



then clone the repository
```bash 
git clone git@github.com:2025-1-PI1-G1/202501-proyecto-equipo5.git
```
```bash
cd 202501-proyecto-equipo5
```

exit from the VM
```bash
exit
```

we need to destroy the resources created by terraform, for that we can use the command
```bash
az vm deallocate --resource-group integrador1new --name linuxvm-1
```
```bash
terraform destroy -auto-approve
```

