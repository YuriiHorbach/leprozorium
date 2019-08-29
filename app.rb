#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

#db init
def init_db
	@db = SQLite3::DataBase.new 'leprozorium.db'
	@db.resusts_as_hash = true
end

before do

end

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end



get '/new' do
  erb :new
end

post '/new' do

	content = params[:content] #add name of form how to call the textarea


  	erb "You typed #{content}"
end