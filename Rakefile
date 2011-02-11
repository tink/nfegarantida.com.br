desc "deploy site to server"
task :deploy do
  require 'rubygems'
  require 'highline/import'
  require 'net/scp'
  puts 'This _site/ will be deployed to the server'
  username = ask("Username:  ") { |q| q.echo = true }
  password = ask("Password:  ") { |q| q.echo = "*" }

  Net::SCP.start('alpha.nfegarantida.com.br', username, :password => password) do |scp|
    scp.upload '_site/', '/var/www/', :recursive => true
  end
end
