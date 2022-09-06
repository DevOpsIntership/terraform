Vmnetworking = {
  agent1 = {
    nicname = "agent1-nic"
    Ipname = "agnet1-ip"
    allocation = "Dynamic"
    subnetname = "agentsubnet"
  }
    agent2 = {
    nicname = "agent2-nic"
    Ipname = "agnet2-ip"
    allocation = "Dynamic"
    subnetname = "agentsubnet"
  }
  
  jumpbox = {
      nicname = "jumpbox-nic"
      Ipname = "jumpbox-ip"
      allocation = "Static"
      subnetname = "jumpboxsubnet"
  }
}
Vmlinux= {
  agent1={
     name = "agnet1"
    Vmsize = "Standard_D1_v2"
    diskname = "agent1-OSDisk"
    disksku = "Standard_LRS"
    publisher = "Canonical"
    offer =  "UbuntuServer"
    sku = "16.04-LTS"
  }
  agent2= {
    name = "agnet2"
    Vmsize = "Standard_D1_v2"
    diskname = "agent2-OSDisk"
    disksku = "Standard_LRS"
    publisher = "Canonical"
    offer =  "UbuntuServer"
    sku = "16.04-LTS"
  }

}


Vmwindows = {
   jumpbox = {
    name = "jumpbox"
    Vmsize = "Standard_D1_v2"
    diskname = "jumpbox-OSDisk"
    disksku = "Standard_LRS"
    publisher = "MicrosoftWindowsServer"
    offer =  "WindowsServer"
    sku = "2019-Datacenter"
    
  }
}


rg = "automation"
