class Oystercard
  attr_reader :balance

  BALANCE_LIMIT = 90
  MIN_FARE = 1

  def initialize
    @balance = 0 
    @in_journey = false
  end

  def top_up(amount)
    raise "Exceeds max balance of £#{BALANCE_LIMIT}" if (balance + amount) > BALANCE_LIMIT
    @balance += amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    raise "Below minimum limit of £#{Oystercard::MIN_FARE}" if @balance < MIN_FARE 
    @in_journey = true 
  end

  def touch_out
    deduct(MIN_FARE)
    @in_journey = false 
  end

  private 
  
  def deduct(fare)
    @balance -= fare
  end 

end
