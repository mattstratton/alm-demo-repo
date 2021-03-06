#
# Cookbook Name:: my_awesome_app
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

# install various roles and features

%w[
NetFx4
NetFx4Extended-ASPNET45
IIS-WebServerRole
IIS-WebServer
IIS-DefaultDocument
IIS-StaticContent
IIS-HttpErrors
IIS-HttpRedirect
IIS-RequestFiltering
IIS-ISAPIExtensions
IIS-ISAPIFilter
IIS-HttpLogging
IIS-RequestMonitor
IIS-HttpTracing
IIS-WindowsAuthentication
IIS-HttpCompressionStatic
IIS-ManagementConsole
IIS-ManagementService
IIS-NetFxExtensibility45
IIS-ASPNET45
].each do |feature|
  windows_feature feature do
    action :install
    all true
  end
end

user node['my_awesome_app']['apppooluser'] do
  action :create
  password node['my_awesome_app']['apppoolpassword']
end

directory "#{node['my_awesome_app']['webroot']}#{node['my_awesome_app']['sitename']}" do
  recursive true
  action :create
end

# stop and delete the default site
iis_site 'Default Web Site' do
  action [:stop, :delete]
end

iis_site node['my_awesome_app']['sitename'] do
  protocol :http
  port 80
  path "#{node['my_awesome_app']['webroot']}#{node['my_awesome_app']['sitename']}"
  action [:add, :start]
end

# creates a new app pool
iis_pool node['my_awesome_app']['sitename'] do
  runtime_version '4.0'
  pipeline_mode :Integrated
  pool_username node['my_awesome_app']['apppooluser']
  pool_password node['my_awesome_app']['apppoolpassword']
  action :add
end

service "iis" do
  service_name "W3SVC"
  action [:enable, :start]
end