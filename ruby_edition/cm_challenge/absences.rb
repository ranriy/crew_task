require 'icalendar'
require_relative './api'

module CmChallenge
  class Absences
      def initialize
        @absences = CmChallenge::Api.absences
        @members = CmChallenge::Api.members
      end

      def to_ical
        cal = Icalendar::Calendar.new
        @absences.each do |record|
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
        member_record = @members.find { |record| record[:user_id]==user_id } 
        type == 'vacation' ? member_record[:name] + ' is on vacation' : member_record[:name] + ' is sick'
      end

      def user_absences(user_id)
        @absences = @absences.select { |record| record[:user_id]==user_id.to_i }
      end

      def date_range(start_date,end_date)
        @absences = @absences.select { |record| Date.parse(record[:start_date])>= Date.parse(start_date) and Date.parse(record[:end_date])<=Date.parse(end_date) }
      end
  end
end
