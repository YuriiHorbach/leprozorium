#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

#db init
def init_db
	@db = SQLite3::Database.new 'leprozorium.db'
	@db.results_as_hash = true
end

before do
	init_db
end

#configuration code
configure do
	init_db
	@db.execute 'CREATE TABLE  IF NOT EXISTS Posts 
	(
    	id INTEGER PRIMARY KEY ASC AUTOINCREMENT,
    	create_date DATE,
    	content TEXT
	)'
end

#will execute before any get and post


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