rg = "automation"

subnet = {
   agentsubnet= {
        name = "agentsubnet"
        cidr = ["10.0.0.0/25"]
        nsg  = "agnetnsg"
       
    }

   jumpboxsubnet =   {
        name = "jumpboxsubnet"
        cidr = ["10.0.0.128/25"]
        nsg  = "jumpboxnsg"
        

    }

}


security_rule = {
  agnetnsg=  {
  name                        = "AllowOut"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name =  "agnetnsg"
  }
jumpboxnsg=  {
  name                        = "AllowRdp"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name =  "jumpboxnsg"
}

}

Vnet = "Vnet"
nsgagent = "agnetnsg"


