
# spanning-cookbook


## The Goal
The goal is to update the configuration of multiple Apache web servers with redundancy, so that only one server is down at a time.

## Requirements
Ubuntu 14.04


## How I did it

1.  Created the spanning-cookbook that did the following:

      1.  Sets up and runs apache2
      2.  Add the apache2 configuration file `spanning.conf` from the `spanning.conf.erb` template in this cookbook
      3.  Restarts Apache2 service on the server to apply the new configuration


2.  Added the cookbook to my hosted chef server at chef.io `
            berks upload
3.  Created a role to for the spanning-cookbook
4.  Bootstrapped 2 nodes with this cookbook with the following command:
      knife bootstrap 54.165.255.214 -N spanning1 -r 'role[webservers]' --ssh-user ubuntu --sudo -i ~/.ssh/tk-hardhero.pem
5.  Changed the spanning.conf.erb template to use `/var/www/html/spanning` as the route for the vhost instead of `/var/www/html`.
6.  Updated the metadata.rb with a new version
7. `berks upload` to push the new version of the cookbook
5.  Ran the following command to refresh the cookbook on both servers. The `-C 1` will only execute one node at a time so that only one server will be down at a given time.
        knife ssh 'role:webservers' "sudo chef-client" -x ubuntu -i ~/.ssh/tk-hardhero.pem -C 1
