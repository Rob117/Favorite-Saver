require 'mechanize'
require 'uri'
require 'csv'

agent = Mechanize.new
agent.user_agent_alias = "Mac Safari"
page = agent.get("file:///#{Dir.pwd}/page.html")

CSV.open('results.csv', 'w') do |csv|
page.at('.videoUList').search('#moreData li').
  search('.thumbnail-info-wrapper').search('.title').each do |t|
    n = t.children[1]
    csv << [n.attributes['href'].value, n.children[0].text]
  end
end
