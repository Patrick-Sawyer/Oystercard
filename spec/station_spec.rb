require 'station'

describe Station do
  describe 'zone' do

    subject(:station){ described_class.new("Old Street", 4) }

    it 'saves zone as variable' do
      expect(station.zone).to eq(4)
    end
    it 'saves name as variable' do
      expect(station.name).to eq("Old Street")
    end
  end
end
