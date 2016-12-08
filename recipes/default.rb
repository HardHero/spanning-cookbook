#
# Cookbook Name:: spanning-cookbook
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'apache2'
include_recipe 'apache2::mod_ssl'

apache_conf 'spanning' do
      enable true
end
directory '/var/www/html/spanning/' do
  owner node['apache']['user']
  group node['apache']['group']
  mode 00755
  recursive true
  action :create
end
template '/var/www/html/spanning/index.html' do
  source 'index.html.erb'
  owner node['apache']['user']
  group node['apache']['group']
  mode 00744
end

service "apache2" do
  action :restart
end
