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
