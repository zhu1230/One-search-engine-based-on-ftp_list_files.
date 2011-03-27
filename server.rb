require 'sinatra'
require 'haml'
require 'sqlite3'
set :port, 8080
set :lines, File.open('./list.txt').readlines
set :db,SQLite3::Database.new( "new.database" )
 get '/' do 
	addcount
   haml :show,:locals => {:count => getcount}
	
 end

post '/query' do
search = params[:search]
@results = Array.new
# File.open('./list.txt') do |f|
# 	f.readlines.each do |line|
# 		(@results << line) if line.include? search
# 	end
# end
options.lines.each do |line|
		line2=line.encode("UTF-8","GBK").encode("UTF-8")
		puts line
		
		(@results << line2) if line2.include? search
		# puts 
end
haml :result
end


get '/do' do
	initdb
end

def getcount
	options.db.execute("select count from counts limit 1 ;").first.first
end
def addcount
	options.db.execute("update counts set count=count+1 ;")
end
def initdb
	# options.db.execute("create table counts (id INTEGER PRIMARY KEY, count INTEGER)");
	options.db.execute("insert into counts (id,count) values (NULL,0);");
end

	