#!/usr/bin/ruby

require "google/cloud/firestore"


def get_firestore
    project_id = ENV['PROJECT_ID']
    firestore = Google::Cloud::Firestore.new project_id: project_id
end



def add_to_db(firestore, user)
city_ref = firestore.doc "heroku_scheduler/#{user}"

tz = Time.now.getlocal.zone
  data = {
    time_zone: "#{tz}",
  }

   city_ref.set data

end



def ping
	firestore = get_firestore
	(puts "**** Firestore not found ****"; return;) if (!firestore)
	time = time_now = Time.now.strftime("%d %B %Y - %H:%M - %L")
	add_to_db(firestore, time)
end
