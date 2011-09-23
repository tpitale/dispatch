require File.expand_path('../config', File.dirname(__FILE__))
require 'rubygems'
require 'bundler'

Bundler.setup(:default, :daemon)
Bundler.require(:default, :daemon)

autoload :Project, Configuration.root+'/models/project'

require 'json' # yajl
require 'pp'

$logger = Logger.new($stdout)

t = Thread.new {EM.run {}}

puts "Started the EM thread"

# can this websocket be a class itself?
EM::WebSocket.start(:host => '0.0.0.0', :port => 8080) do |websocket|
  $logger.warn "Server started on 0.0.0.0:8080"
  websocket.onopen { puts "Client Connected" }

  websocket.onmessage do |msg|
    puts "Received message: #{msg}"
    hash = JSON.parse(msg)

    websocket.send({'status' => 'started'}.to_json)

    deploy = lambda do
      if project = Project.find(hash['name'])
        return project.deploy_to(hash['stage'])
      end
    end

    deploy_complete = lambda { |*args|
      puts "Deploy Complete!"
      p args
      websocket.send({'status' => 'complete', 'log' => args.first}.to_json)
    }

    EM.defer(deploy, deploy_complete)
  end

  websocket.onclose { puts "Websocket Closed" }
  websocket.onerror { |e| puts "err #{e.inspect}" }
end

t.join