#! /usr/bin/env ruby
##****************************************************************************
# RUBY - Recovery of TownHall emails
#*****************************************************************************
#   Ruby's Program - Email Recovery 
#   Written by: Grégory Rouxel Oldrà
# 	Date: Date of modification
#   
#   Description:
# 		- From the website 'http://annuaire-des-mairies.com/val-d-oise.html' we access all cities
# 		- For each city, we recover its email address and store both name & email in an array
# 		
# 	Gems:

require 'rspec'
require 'pry'
require 'nokogiri'
require 'open-uri'
#
#****************************************************************************

#scrapping de mails du Val d'Oise

D=[]

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
          D << {name => email}
          end
          # puts D.to_s
          return D
      end

def cityhall_scrapper ()
  # puts "\n\n\n\n\n\n\n\n Array de mairies  \n\n\n\n\n\n\n\n"
  get_townhall_urls
end

p cityhall_scrapper

