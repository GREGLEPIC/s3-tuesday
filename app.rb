require 'bundler'
require 'open-uri'
require 'pry'
Bundler.require

$:.unshift File.expand_path("./../lib", __FILE__)
require 'app/scrapper'

Scrapper.new.perform


