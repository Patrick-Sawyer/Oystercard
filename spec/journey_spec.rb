require 'journey'

describe Journey do
  subject(:journey){ described_class.new(entry_station)}
  let(:entry_station){ double :entry_station, entry_station: 'Old Street', zone: 4 }
  let(:exit_station){ double :exit_station, entry_station: 'New Street', zone: 3 }

  it 'stores the entry station' do
    expect(subject.entry_station).to eq entry_station
  end

  describe '#end_journey' do
    it 'returns a hash of the entire journey with fare' do
      expect(subject.end_journey(exit_station)).to eq({entry_station: entry_station, exit_station: exit_station, fare: Journey::MIN_FARE})
    end
  end
end
