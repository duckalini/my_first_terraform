# Modules

Modules are reusable chunks of code - used like building blocks to create environments. 

Modules are made up of variables, resources, data and outputs. 
Variables are inputs - which can have default values and be overridden by whatever you pass in. You can use these variables to create unique resource names or configure different environments.
They can also return outputs which can then be passed over to other modules. Terraform tracks dependencies, so it’ll know what order to create things (it does error if there’s a cyclic dependency).
