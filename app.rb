#coding: utf-8
require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'csv'

csv_data = CSV.read('data/difficulty.latest.csv', headers:true)

datas = Array.new

before /.*\.js/ do
  content_type 'application/javascript'
end

5.times do |i|
  datas[i] = csv_data.clone.map do |data|
    data
  end
  datas[i].delete_at(0)
  datas[i].sort! do |a,b|
    index = "n#{i+1}"
    b[index].to_i <=> a[index].to_i
  end
end


get '/' do
    File.read('sample.html')
end

get '/sample.js' do
    File.read('sample.js')
end

get '/level/:id' do
  id = params['id'].to_i
  datas[id-1].map do |data|
        data["gage"] = data["n#{id}"]
        data["author"] = data["first"] + " " + data["last"]
	data.to_h
  end.to_json
end

