#
# Cookbook:: starter
# Recipe:: default
#
# Copyright:: 2024, The Authors, All Rights Reserved.
file '/tmp/hello.txt' do
    content 'Hello, world!'
    action :create
  end