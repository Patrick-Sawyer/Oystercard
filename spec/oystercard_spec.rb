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
      expect { subject.send(:deduct, 3) }.to change(subject, :balance).to eq(-3)
    end 
  end

  describe "in_journey?" do
    it "returns false when instance is created" do
      expect(subject.in_journey?).to eq(false)
    end 
  end

  describe "touch_in" do 
    
    it "raises error when card balance is below min limit" do
      expect { subject.touch_in }.to raise_error("Below minimum limit of £#{Oystercard::MIN_FARE}")
    end 

    it "Updates in_journey to true when touch_in called" do
      subject.top_up(2)
      subject.touch_in
      expect(subject).to be_in_journey
    end 
  end 

  describe "touch_out" do
    before(:each) do
      subject.top_up(2)
      subject.touch_in
    end

    it "Updates in_journey to false when touch_out called" do
      subject.touch_out
      expect(subject).not_to be_in_journey
    end 

    it "Deducts min fare when touch_out called" do

      expect { subject.touch_out }.to change{subject.balance}.by(-Oystercard::MIN_FARE)
    end 
  end 

end
