require 'sinatra'

class Resque < Sinatra::Application
  get '/test' do
    content_type :text
    status 200
    "Hello World from Sinatra"
  end
end