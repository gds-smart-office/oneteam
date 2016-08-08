require 'rubygems'
require 'json'
require 'rest-client'
require 'pi_piper'

include PiPiper

plan = 'TR-ARRP'
url = "http://www.ida-gds.com/bamboo/rest/api/latest/result/#{plan}.json?expand=results[0].result&expand=results.result.jiraIssues"
user = 'poh_kah_kong'
password = 'p@ssw0rd'
successful_pin = PiPiper::Pin.new(:pin => 17, :direction => :out)
failed_pin     = PiPiper::Pin.new(:pin => 18, :direction => :out)
while true
  json = JSON.parse(RestClient::Request.execute method: :get, url: url, user: user, password: password)
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