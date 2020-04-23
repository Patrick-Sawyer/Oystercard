require 'oystercard'

describe Oystercard do

  describe 'balance' do

    it 'balance has 0' do
      expect(subject.balance).to eq(0)
    end
  end

  describe "journeys" do
    it "defaults to an empty array" do
      expect(subject.journeys).to eq []
    end
  end

  describe 'top_up' do

    it 'adds topup amount to balance' do
      expect { subject.top_up(3) }.to change(subject, :balance).to eq(3)
    end

    it 'raises error when top_up goes over £90' do
      expect { subject.top_up(91) }.to raise_error("Exceeds max balance of £#{Oystercard::BALANCE_LIMIT}")
    end
  end

  describe "deduct" do
    it "deducts given fare from balance" do
      expect { subject.send(:deduct, 3) }.to change(subject, :balance).to eq(-3)
    end
  end

  describe "in_journey?" do
    it "returns false when instance is created" do
      expect(subject.in_journey?).to eq(false)
    end
  end

  describe "touch_in error" do
    let(:station) { double :station }
    it "raises error when card balance is below min limit" do
      expect { subject.touch_in(station) }.to raise_error("Below minimum limit of £#{Journey::MIN_FARE}")
    end
  end

  describe 'touch_in' do

    let(:station) { double :station }

    before(:each) do
      subject.top_up(2)
      subject.touch_in(station)
    end

    it "Updates in_journey to true when touch_in called" do
      expect(subject).to be_in_journey
    end

    it "updates current_journey variable when touch_in called" do
      expect(subject.current_journey).to be_a_kind_of(Journey)
    end

    it "updates current_journey variable to nil when touch_out called" do
      subject.touch_out(station)
      expect(subject.current_journey).to eq(nil)
    end
  end

  describe "touch_out" do

    let(:station) { double :station }

    before(:each) do
      subject.top_up(2)
      subject.touch_in(station)
    end

    it "Updates in_journey to false when touch_out called" do
      subject.touch_out(station)
      expect(subject).not_to be_in_journey
    end

    it "Deducts min fare when touch_out called" do
      expect { subject.touch_out(station) }.to change{subject.balance}.by(-Journey::MIN_FARE)
    end
  end

  describe "array" do
    let(:station1) { double :station1 }
    let(:station2) { double :station2 }
    it "stores a journey in hash in an array" do
      subject.top_up(2)
      subject.touch_in(station1)
      subject.touch_out(station2)
      expect(subject.journeys).to eq [{entry_station: station1, exit_station: station2, fare: Journey::MIN_FARE}]
    end
  end

end
