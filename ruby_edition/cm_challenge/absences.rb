require 'icalendar'
require_relative './api'

module CmChallenge
  class Absences
      def to_ical
        cal = Icalendar::Calendar.new
        CmChallenge::Api.absences.each do |record|
            cal.event do |e|
              e.dtstart     = Icalendar::Values::Date.new(record[:start_date].tr('-',''))
              e.dtend       = Icalendar::Values::Date.new(record[:end_date].tr('-',''))
              e.summary     = summary(record[:user_id],record[:type])
              e.description = record[:member_note]
              e.ip_class    = "PRIVATE"
            end
        end
        cal.publish
        cal
      end

      def summary(user_id,type)
        member_record = CmChallenge::Api.members.find { |record| record[:user_id]==user_id } 
        type == 'vacation' ? member_record[:name] + ' is on vacation' : member_record[:name] + ' is sick'
      end
  end
end
