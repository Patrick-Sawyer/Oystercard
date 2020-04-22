class Oystercard
  attr_reader :balance, :entry_station, :journeys

  BALANCE_LIMIT = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @entry_station = nil
    @journeys = []
  end

  def top_up(amount)
    raise "Exceeds max balance of £#{BALANCE_LIMIT}" if (balance + amount) > BALANCE_LIMIT
    @balance += amount
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(station)
    update_entry_station(station)
    raise "Below minimum limit of £#{Oystercard::MIN_FARE}" if @balance < MIN_FARE
  end

  def touch_out(station)
    deduct(MIN_FARE)
    @journeys << {entry: entry_station, exit: station}
    @entry_station = nil
  end

  private

  def deduct(fare)
    @balance -= fare
  end

  def update_entry_station(station)
    @entry_station = station
  end
end
