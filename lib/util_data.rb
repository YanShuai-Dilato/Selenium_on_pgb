require 'json' # json parser
require 'rubygems'

## A module providing all the testing data using simple interface

json = File.read("..\\data\\data_xpath.json")
xpaths = JSON.parse(json)

puts xpaths["start_page"]["home"]


