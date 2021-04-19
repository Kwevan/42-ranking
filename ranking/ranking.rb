#!/usr/bin/ruby

require_relative 'api_token.rb'

@save = false

def user_to_hash(login, json_str, j)
	puts "----"
	bh_date = json_str[j]['blackholed_at']
	print "#{login}  "
	days = get_bh(bh_date)
	puts days
	date = json_str[j]['begin_at']
	date = conv_date(date)
	puts date
	image_url = "https://cdn.intra.42.fr/users/small_#{login}.jpg"
	url = "https://profile.intra.42.fr/users/#{login}"

	lvl = json_str[j]['level']

	subdata = Hash["lvl" => lvl]
	subdata.store("date", date)
	subdata.store("days", days)
	puts "-----\n\n"
	subdata
end

def update_users(firestore, campus)
	puts "\n\n**********    starting #{campus.name}    **********"

	brk = 0
	token = get_ranking_token
	cursus_id = 21
	min = "2019-10-07T01:00:00.000Z"
	max = "2100-04-21T23:42:00.000Z"
	min = "2020-04-01T08:00:00.000Z" if campus.name == "Fremont"
	@users = Array.new()
	data = Hash.new

	i = 1
	route = "/v2/cursus/21/cursus_users"

	loop do
        res = token.get(route, params: {page: {number: i, size: 100}, filter: {campus_id: campus.id}, range: {begin_at: "#{min}, #{max}"}})
		json_str = res.parsed
		hd = res.headers; #puts JSON.pretty_generate(hd)
		user_count = hd['x-total']
		puts user_count

		j = 0
		while json_str.any? &&  !json_str[j].nil?
			login = json_str[j]['user']['login']
			(j+=1; next) if Utils.skip_list_ranking_users(login)
			subdata = user_to_hash(login, json_str, j)
			data.store(login, subdata)
			#brk = 1
	        j += 1
        end

		puts
	puts "page #{i} done"
	puts
	puts

        sleep(0.5)
        i += 1
        break if (!json_str.any? || brk == 1)
 end

	puts "total page  #{i}"


	if (firestore)
		users_ref = firestore.doc "users3/#{campus.name}"
		users_ref.set data
	end
	Utils.save_to_file(@save, data, campus.name)
end


# delete_collection(get_firestore, "users3"); #delete_collection(get_firestore, "logs"); return # clear db

firestore = get_firestore

campuses = get_campuses
if (ARGV.empty? || ARGV[0] == "")
	#update all campuses
	ranking_logs = Hash.new
	campuses.each do |c|
		(puts ".skip #{c.name}"; next)if Utils.skip_list_ranking(c.name)
		update_users(firestore, c)
		time_now = Time.now.strftime("%d %B %Y - %H:%M (UTC+0)")
		puts time_now
		subdata = Hash["ranked" => time_now]
		ranking_logs.store(c.name, subdata)
	end

else

	campus_name = ARGV[0]

	camp = campuses.find {|x| x.name == campus_name}
	(puts "[ #{campus_name} ] Not found"; exit 1) if camp.nil?

	puts camp.name

	if (firestore)
			doc_ref  = firestore.doc "settings/ranking"
			snapshot = doc_ref.get

		if snapshot.exists?
			puts "updating #{campus_name}"
		else
 			 puts "Document #{snapshot.document_id} does not exist!"
		end
		#  puts "#{snapshot.document_id} data: #{snapshot.data}."
	end

	update_users(firestore, camp)
	time_now = Time.now.strftime("%d %B %Y - %H:%M")
	if (firestore)
		snapshot.data[camp.name.to_sym][:ranked] = time_now + " (UTC+0)"
		ranking_logs = snapshot.data
	end
end


update_logs(firestore, "ranking", ranking_logs)

ping
