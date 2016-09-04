#!/bin/ruby
require 'sqlite3'


def connect(db_file)
	conn = SQLite3::Database.open(db_file)
	puts("Connection Success!")
	return conn
end


def list(conn, rows, table)
	begin
		prep = conn.prepare("SELECT #{rows} FROM #{table}")
		fetch = prep.execute()
		fetch.each do |row|
			puts row.join("\s")
		end
	ensure
		prep.close if prep
	end
end


def main()
	begin	
		if ARGV.length < 2
			raise "usage: #{$0} <db> <table>"
		elsif not File.file?(ARGV[0])
			raise "\'#{ARGV[0]}\' is not a db file"
		end
		conn = connect(ARGV[0])
		list(conn, "*", "agend")
		conn.close()
	rescue Exception => e
		puts e.message
	ensure
		if conn
			puts("Closing Connection!")
			conn.close()
		end
	end
end


main()
