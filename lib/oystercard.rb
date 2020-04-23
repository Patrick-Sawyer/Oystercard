class Oystercard
  attr_reader :balance, :journeys, :current_journey

  BALANCE_LIMIT = 90
  # MIN_FARE = 1

  def initialize
    @balance = 0
    # @entry_station = nil
    @journeys = []
    @current_journey = nil
  end

  def top_up(amount)
    raise "Exceeds max balance of £#{BALANCE_LIMIT}" if (balance + amount) > BALANCE_LIMIT
    @balance += amount
  end

  def in_journey?
    !!@current_journey
  end

  def touch_in(entry_station)
    # journey = Journey.new(entry_station)
    raise "Below minimum limit of £#{Journey::MIN_FARE}" if @balance < Journey::MIN_FARE
    @current_journey = Journey.new(entry_station)
  end

  def touch_out(exit_station)
    deduct(Journey::MIN_FARE)
    @journeys << @current_journey.end_journey(exit_station)
    @current_journey = nil
  end

  private

  def deduct(fare)
    @balance -= fare
  end
end
