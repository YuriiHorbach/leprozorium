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
    	content TEXT,
    	post_id, integer
	)'

	@db.execute 'CREATE TABLE  IF NOT EXISTS Comments 
	(
    	id INTEGER PRIMARY KEY ASC AUTOINCREMENT,
    	create_date DATE,
    	content TEXT
	)'
end



get '/' do
	#get data from db

	@results = @db.execute 'select * from Posts order by id desc'
	erb :index
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

	#save data to bd
	@db.execute 'insert into Posts (content, create_date) values (?, datetime())', [content]


	#redirect to main page

	redirect to '/'

end

#output info about post
get '/details/:post_id' do

	#get variable from url
	post_id = params[:post_id]

	#get list of posts
	#(we will have only 1 post)
	results = @db.execute 'select * from Posts where id = ?', [post_id]

	#take than 1 post in variable row
	@row = results[0]

	#return post in details.erb
	erb :details

end


#post handler
#(browser send data to server and we get data)
post '/details/:post_id' do
	#get variable from url
	post_id = params[:post_id]
	content = params[:content]

	erb "You typed commetn #{content} for post #{post_id}"

end