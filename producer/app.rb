#!/usr/bin/env ruby
require 'bunny'

connection = nil

def main
  begin
    connection = Bunny.new(
      :host     => ENV["RABBITMQ_HOST"],
      :vhost    => ENV["RABBITMQ_VHOST"],
      :user     => ENV["RABBITMQ_USER"],
      :password => ENV["RABBITMQ_PASS"],
      :automatically_recover => true,
    )

    connection.start

    channel = connection.create_channel
    queue = channel.queue('hello')
    
    x=0
    interval= ENV["INTERVAL"].to_i

    if interval == 0
      interval = 3
    end

    while x <= 100
      time = Time.now.getutc
      channel.default_exchange.publish("Current time: #{time.to_i}", routing_key: queue.name)
      puts " [x] Sent #{time.to_i}"
      x = x + 1
      sleep interval
    end
    
    connection.close
  #rescue Bunny::TCPConnectionFailedForAllHosts => e
  #rescue Bunny::TCPConnectionFailed => e
  #rescue Bunny::HostListDepleted => e
  rescue Exception => e
    puts e
    sleep 1
    main
  end
end

main
