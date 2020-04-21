require 'oystercard'

describe Oystercard do

  describe 'balance' do
  
    it 'balance has 0' do
      expect(subject.balance).to eq(0)
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
      expect { subject.deduct(3) }.to change(subject, :balance).to eq(-3)
    end 
  end

  describe "in_journey?" do
    it "returns false when instance is created" do
      expect(subject.in_journey?).to eq(false)
    end 
  end

  describe "touch_in" do 
    it "Updates in_jounrey to true when touch_in called" do
      expect { subject.touch_in }.to change(subject, :in_journey?).to eq(true)
    end 
  end 
end
