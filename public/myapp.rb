# this is myapp.rb referred to above
require 'sinatra'
get '/' do
  "Worked on dreamhost"
end

get '/foo/:bar' do
  "You asked for foo/#{params[:bar]}"
end