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
    
    begin
      puts ' [*] Waiting for messages. To exit press CTRL+C'
      # block: true is only used to keep the main thread
      # alive. Please avoid using it in real world applications.
      queue.subscribe(block: true) do |_delivery_info, _properties, body|
        puts " [x] Received #{body}"
      end
    rescue Interrupt => _
      connection.close
    
      exit(0)
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
