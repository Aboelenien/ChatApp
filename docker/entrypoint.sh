#! /bin/bash
rails db:create db:migrate

rm tmp/pids/server.pid

puma -C config/puma.rb
