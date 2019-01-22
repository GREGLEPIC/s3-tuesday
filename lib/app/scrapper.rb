


##****************************************************************************
# RUBY - Recovery of TownHall emails
#*****************************************************************************
#   Ruby's Program - Email Recovery 
#   Written by: Grégory Rouxel Oldrà
#   
#   Description:
# 		- From the website 'http://annuaire-des-mairies.com/val-d-oise.html' we access all cities
# 		- For each city, we recover its email address and store both name & email in an array
#
#****************************************************************************

#scrapping de mails du Val d'Oise


class Scrapper

  def initialize()
    @D=[]
  end

  def get_townhall_email(townhall_url)
    page = Nokogiri::HTML(open(townhall_url))
    page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').each do |node|
      return node.text
      end
  end

  def get_townhall_urls ()
    page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
    page.xpath("//tr[2]//p/a").each do |node|
      name = node.text
      email = get_townhall_email("http://annuaire-des-mairies.com/"+node["href"])
      @D << {name => email}
      end
    # puts @D.to_s
    return @D
  end

  def cityhall_scrapper ()
    # puts "\n\n\n\n\n\n\n\n Array de mairies  \n\n\n\n\n\n\n\n"
    get_townhall_urls
  end

  def save_as_JSON
    File.open("./../db/emails.json","w") do |f|
      f.write(cityhall_scrapper.to_json)
    end               
  end
end

Scrapper.new 





