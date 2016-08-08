require 'rubygems'
require 'json'
require 'rest-client'

plan = 'TR-ARRP'
url = "http://www.ida-gds.com/bamboo/rest/api/latest/result/#{plan}.json?expand=results[0].result&expand=results.result.jiraIssues"
user = 'poh_kah_kong'
password = 'p@ssw0rd'
while true
  json = JSON.parse(RestClient::Request.execute method: :get, url: url, user: user, password: password)
  p json['results']['result'][0]['state']
  sleep 5
end