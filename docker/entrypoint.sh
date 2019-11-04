#! /bin/bash
rails db:create

rm tmp/pids/server.pid

puma -C config/puma.rb
