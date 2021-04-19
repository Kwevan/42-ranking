require 'rubygems'
require 'json'
require "oauth2"
require "google/cloud/firestore"
require 'fileutils'
require 'dotenv/load'

require_relative 'Campus.rb'
require_relative 'Utils.rb'
require_relative 'ping.rb'
require_relative 'FirestoreUtils.rb'


def get_token(uid, secret)
	client = OAuth2::Client.new(uid, secret, site: "https://api.intra.42.fr")
	token = client.client_credentials.get_token
end

def get_ranking_token
	uid = ENV['RANK_UID']
	secret = ENV['RANK_SECRET']
	get_token(uid, secret)
end


def get_campus_token
	uid = ENV['CAMP_UID']
	secret = ENV['CAMP_SECRET']
	get_token(uid, secret)
end

def get_firestore
	firestore = Google::Cloud::Firestore.new 
	puts "Created Cloud Firestore client with given project ID."
	firestore
#	return nil
end

