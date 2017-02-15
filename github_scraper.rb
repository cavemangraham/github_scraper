require 'HTTParty'
require 'Nokogiri'
require 'csv'

email_array = []
state_array = ['AK', 'AL', 'AR', 'AZ', 'CA', 'CO', 'CT', 'DC', 'DE', 'FL', 'GA', 'HI', 'IA', 'ID', 'IL', 'IN', 'KS', 'KY', 'LA', 'MA', 'MD', 'ME', 'MI', 'MN', 'MO', 'MS', 'MT', 'NC', 'ND', 'NE', 'NH', 'NJ', 'NM', 'NV', 'NY', 'OH', 'OK', 'OR', 'PA', 'RI', 'SC', 'SD', 'TN', 'TX', 'UT', 'VA', 'VT', 'WA', 'WI', 'WV', 'WY']

state_array.each do |state|
  for result_page in 1..100

    page = HTTParty.get("https://github.com/search?p=#{result_page}&q=repos%3A>10+location%3A#{state}&ref=searchresults&type=Users")

    parse_page = Nokogiri::HTML(page)

      parse_page.css('.email').map do |a|
        email_text = a['href']
        email_text = email_text[7..-1]
        email_text = email_text
        puts email_text
        email_array.push(email_text)
      end
    sleep 15
    puts "next page"
  end
end

puts email_array.count

CSV.open('github_emails_50_states.csv', 'w') do |csv|
  email_array.each do |email|
    csv << [email]
  end
end
