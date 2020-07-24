require 'sinatra'
require_relative 'cm_challenge/absences'

get '/' do 
	response.headers['Content-Disposition'] = 'attachment; filename=absences.ics'
	response.headers['Content-Type'] = 'text/calendar; charset=UTF-8'
	CmChallenge::Absences.new.to_ical.to_ical
end