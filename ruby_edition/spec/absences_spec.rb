require_relative '../cm_challenge/absences'

RSpec.describe 'Absences' do
  describe '#to_ical' do
    let(:ical) { CmChallenge::Absences.new.to_ical }
    
    it { expect(ical.class).to eq Icalendar::Calendar }
    it { expect(ical.events.length).to eq 42 }

    it 'shows vacation and sickness with employee name' do
      expect(ical.events.first.summary).to eq 'Mike is sick'
      expect(ical.events[1].summary).to eq 'Mike is on vacation'
    end

    it { expect(ical.events.first.description).to be_empty }
    it { expect(ical.events.first.dtstart.to_s).to eq '2017-01-13' }
    it { expect(ical.events.first.dtend.to_s).to eq '2017-01-13' }
  end

  describe '#user_absences' do
    let(:absences) { CmChallenge::Absences.new.user_absences(649) }

    it { expect(absences.length).to eq 3 }
    it { expect(absences.first[:user_id]).to eq 649 }
    it { expect(absences[1][:user_id]).to eq 649 }
    it { expect(absences[2][:user_id]).to eq 649 }
  end

  describe '#date_range' do
    let(:absences) { CmChallenge::Absences.new.date_range('2017-01-01','2017-02-01') }

    it { expect(absences.length).to eq 3 }
    it { expect(absences.first[:start_date]).to be >= '2017-01-01' }
    it { expect(absences.first[:end_date]).to be  <= '2017-02-01' }
  end
end
