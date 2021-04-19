require_relative 'api_token.rb'

class Campus
	attr_accessor :id, :name
end


def replace_invalid_char(name)
	name = name.gsub('ã', 'a')
end

def get_campuses

@brk = 1000000

campuses = Array.new

  token = get_campus_token

  i = 1

  loop do
    json_str = token.get("/v2/campus", params: {page: {number: i}}).parsed

    j = 0
    while json_str.any? && !json_str[j].nil?
      count = json_str[j]['users_count']
      id = json_str[j]['id']
      name = json_str[j]['name']
     ( puts "\n[#{name} skipped]"; j+=1;  next ) if count < 200

      puts "------------------------------------------------------------------"
      puts name
      puts "id: #{id}"
      puts "count: #{count}"
      puts
      puts "------------------------------------------------------------------"
    c = Campus.new
    c.id = id
    c.name = replace_invalid_char(name)
    campuses << c
    j += 1
    end
    i += 1
    sleep(0.5)
    break if (!json_str.any? || i == @brk)
  end
  campuses
end


