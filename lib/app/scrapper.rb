


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


require 'nokogiri'
require 'open-uri'
require 'rubygems'
require 'pry'
require 'google_drive'
require 'csv'

#Program that scrap and save content from val d'oise townhall
class Scrapper

  @D=[]
  @name = []
  @email = []

  # def that scrap one email from a val d'oise city
  def get_townhall_email(townhall_url)
    page = Nokogiri::HTML(open(townhall_url))
    page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').each do |node|
      return node.text
      end
  end

  #Scrap the name and email of all val d'oise cities
  def get_townhall_urls
    page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
    page.xpath("//tr[2]//p/a").map do |node|
      @name = node.text
      @email = get_townhall_email("http://annuaire-des-mairies.com/"+node["href"])
      end
      @D = Hash[@names.zip(@email)]
  end

#Def to save datas into json
  def save_as_JSON
    tempHash = @D.inject(:merge)
    File.open("../../db/emails.json","w") do |f|
     f.write(tempHash.to_json)
    end
  end 
  
  #Def to save datas into spreadsheet
  def save_as_spreadsheet
    session = GoogleDrive::Session.from_config("config.json")
    ws = session.spreadsheet_by_key("1X0Tt2Nh2sLgEJ_9-MVE6HdhrSSzFz-2zCfkmLLApbuE/edit?usp=sharing").worksheets[0]
    ws.reload
    i = 0
    n = get_townhall_urls.count
    while i <= 4
        ws[i+1, 1] = @emails[i]
        ws[i+1, 2] = @names[i]
    i +=1
    end
    ws.save
  end

#Def to save datas into csv
  def save_as_csv
    CSV.open("./db/#{@name}.csv", "wb") {|csv| @result_scrap.to_a.each {|elem| csv << elem} }
  end
# Perform to launch the program
  def perform
    get_townhall_urls
    save_as_JSON
    save_as_spreadsheet
    save_as_csv
  end 

end
