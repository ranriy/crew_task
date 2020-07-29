require 'sinatra'
require_relative './absences'

get '/' do 
	absences = CmChallenge::Absences.new
	response.headers['Content-Disposition'] = 'attachment; filename=absences.ics'
	response.headers['Content-Type'] = 'text/calendar; charset=UTF-8'
	absences.user_absences(params['userId']) if params['userId']
	absences.date_range(params['startDate'],params['endDate']) if params['startDate'] and params['endDate']
	absences.to_ical.to_ical
end