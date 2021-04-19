
def conv_date(date)
    date = Date.parse date
    date.strftime("%b %y").downcase
end

def get_bh(date)
    return ("0") if date.nil?
    date = Date.parse date
    now = Date.today
    #date  = DateTime.strptime('2022-07-13', '%Y-%m-%d')
    (date - now - 1).to_i
end

class Utils

  def self.skip_list(name)
    exclude = ["Cape-Town", "Cluj", "Helsinki", "Johannesburg", "Chisinau", "Kyiv", "Bucharest"]    
	exclude.each do |x|
     return true if name.include? x
     end
     return false
   end


  def self.skip_list_ranking(name)
    exclude = ["nothing to exclude"]
    exclude.each do |x|
     return true if name.include? x
     end
     return false
   end


  def self.skip_list_ranking_users(login)
    exclude = ["salty", "gpinchon", "apuel", "evanheum", "clafoutis", "irhett", "aunko", "punko", "tunko", "sunko", "rrandom", "lunko", "mathilde", "spidey", "eliotva2", "rcross"]
    ret = exclude.include? login
	if ret
	puts "yes"
	else 
	puts "no"
	end
	ret
  end

  def self.get_duration(starting_time)

	time_now = Time.now
	duration = time_now - starting_time

	duration = Time.at(duration).utc.strftime("%H:%M:%S")

  end

	def self.save_to_file(save, data, campus)
		return if (!save)
		directory = "data/ranking/"
		file_path = "#{directory}#{campus}.txt"
		data = data.sort_by {|_key, value| value["lvl"]}
		data = data.reverse

		FileUtils.mkdir_p(directory) unless Dir.exist?(directory)
		data = JSON.pretty_generate(data)
		data[data.size - 1] = ""
		data[0] = ""
		data = data.gsub("  [").with_index { |m, i| "\n#{1+i}.#{m.gsub("  ", "")}" }
		File.write("#{file_path}", data)
end

end
