#!/bin/ruby

require 'sqlite3'



def connect(db_file)
	conn = SQLite3::Database.open(db_file)
	puts "Connection Success!"
	return conn
end


def desconnect(conn)
	return unless conn.is_a?SQLite3::Database
	puts "Closing Connection!"
	conn.close()
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
	begin
		fetch = execute_and_fetch(conn, "SELECT #{rows} FROM #{table}")
		puts "------------ LISTING #{rows} FROM #{table} -------------"
		fetch.each do |row|
			puts row
		end
		puts "------------------- end -------------------------"
	rescue Exception => e
		puts e.message
	end
end


def update(conn, rows, table)
	rows_arr = [rows]
	rows_arr.each do |col|
		loop do
			puts "value in '#{col}' youd like to update: (enter nothing to skip)"
			opt = $stdin.gets.chomp
			break unless opt != ''
			puts "enter a new value for #{col} of #{opt}: "
			new_val = $stdin.gets.chomp
			conn.execute2("UPDATE #{table} SET #{col} = '#{new_val}' WHERE #{col} = '#{opt}'")
		end
	end
end






def control(conn)
	def get_table_n_rows(action)
		which = ["which table youd like to", "which rows youd like to"]
		puts "#{which[0]} #{action}: "
		table = $stdin.gets.chomp
		puts "#{which[1]} #{action}: "
		rows = $stdin.gets.chomp
		return table, rows
	end

	loop do
		puts "select an operation: list, update, add, quit: "
		option = $stdin.gets.chomp.downcase
		case option
		when "list"
			table, rows = get_table_n_rows('list')
			list(conn, rows, table)
		when 'update'
			table, rows = get_table_n_rows('update')
			update(conn, rows, table)
		when "quit"
			break
		end

	end
end



begin
	if ARGV.length < 1
		raise "usage: #{$0} <db>"
	elsif not File.file?(ARGV[0])
		raise "\'#{ARGV[0]}\' is not a db file"
	end
	conn = connect(ARGV[0])
	control(conn)
rescue Exception => e
	puts e.message

ensure
	desconnect(conn)

end




