#!/bin/ruby
require 'sqlite3'


def connect(db_file)
	conn = SQLite3::Database.open(db_file)
	puts("Connection Success!")
	return conn
end


def desconnect(conn)
	if conn.is_a?(SQLite3::Database)
		puts("Closing Connection!")
		conn.close()
	end
end


def execute_and_fetch(conn, command)
	begin
		statement = conn.prepare(command)
		res = statement.execute()
		arr = []
		res.each do |row|
			arr << row.join("\s")
		end
		return arr
	ensure
		statement.close() if statement
	end
	
end



def list(conn, rows, table)
	fetch = execute_and_fetch(conn, "SELECT #{rows} FROM #{table}")
	fetch.each do |row|
		puts row
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
		desconnect(conn)
	end
end


main()
