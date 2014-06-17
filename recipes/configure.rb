#
# Cookbook Name:: opsworks-resque
# Recipe:: default
#
# Copyright (C) 2014 PEDRO AXELRUD
#
# All rights reserved - Do Not Redistribute
#

node[:deploy].each do |application, deploy|
  template "/etc/init/resque.conf" do
    source "resque.conf.erb"
    mode "0644"
  end

  i = 1
  node['resque']['workers'].each do |queue, quantity|
    quantity.times do
      template "/etc/init/resque-#{i}.conf" do
        source "resque-n.conf.erb"
        mode "0644"
        variables queue: queue, instance: i, deploy: deploy, application: application
      end
      i+=1
    end
  end
end
