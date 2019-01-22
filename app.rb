require 'bundler'
Bundler.require

$:.unshift File.expand_path("./lib", __FILE__)
$:.unshift File.expand_path("./db/", __FILE__)
require 'app/scrapper'
#require 'emails.json'
#require 'emails.csv'

Scrapper.new.perform
# EmailsJason.new.perform
# EmailsCsv.new.perform