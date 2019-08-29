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

#will execute before any get and post
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



get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end


# handler get query /new
# browser get data from server

get '/new' do
  erb :new
end


# handler post query /new
# browser send data to server

post '/new' do
	#get variable from post
	content = params[:content] #add name of form how to call the textarea


	#check patameters if post is empty
	if content.length <= 0
		@error = 'Type post text'
		return erb :new
	end

	@db.execute 'insert into Posts (content, create_date) values (?, datetime())', [content]




  	erb "You typed #{content}"
end