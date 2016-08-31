require_relative 'config'
require 'rubygems'
require 'json'
require 'rest-client'
require 'pi_piper'

include PiPiper

successful_pin = PiPiper::Pin.new(:pin => 17, :direction => :out)
failed_pin     = PiPiper::Pin.new(:pin => 18, :direction => :out)

while true
  json = JSON.parse(RestClient::Request.execute method: :get, url: URL, user: USERNAME, password: PASSWORD)
  status = json['results']['result'][0]['state']
  if status == 'successful'
    puts "#{Time.now}: Successful!"
    successful_pin.on
    failed_pin.on
  else
    puts "#{Time.now}: Failed!"
    failed_pin.on
    successful_pin.off
  end
  sleep 5
end