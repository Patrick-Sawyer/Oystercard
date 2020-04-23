class Journey

  attr_reader :entry_station
  MIN_FARE = 1

  def initialize(station)
    @entry_station = station
  end

  def end_journey(exit_station)
    {entry_station: entry_station, exit_station: exit_station, fare: MIN_FARE}
  end
end
