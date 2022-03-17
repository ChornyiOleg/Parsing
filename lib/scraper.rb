#! /usr/bin/env ruby
require 'nokogiri'
require 'open-uri'
require 'csv'

doc = Nokogiri::HTML(URI.open("https://get.foundation/sites/docs/table.html" ))

data_arr = []

headers = []
doc.xpath('//*/table/thead/tr/th').each do |th|
  headers << th.text
end

rows = []
doc.xpath('//*/table/tbody/tr').each_with_index do |row, i|
  rows[i] = {}
  row.xpath('td').each_with_index do |td, j|
    rows[i][headers[j]] = td.text
  end
end
data_arr.push([headers, rows])

p headers
p rows

CSV.open('data.csv', "w") do |csv|
  csv << data_arr
end
