require 'sinatra'
require 'csv'

get "/" do
  redirect "/index"
end

get "/index" do
  articles = CSV.read('articles.csv')
  erb :index, locals: { news: articles}
end

get "/newest" do
  articles = CSV.read('articles.csv')
  erb :index, locals: { news: articles.reverse }
end

get "/articles" do
  erb :submit
end

post '/index' do
  article = params['article']
  site_name = params['site_name']
  url = params['url']
  num_points = params['num_points']
  uploader = params['uploader']
  time_stamp = params['time_stamp']
  comments = params['comments']

  CSV.open('articles.csv', 'a') do |item|
        item << [article, site_name, url, num_points, uploader, time_stamp, comments]
  end

  redirect '/index'
end
