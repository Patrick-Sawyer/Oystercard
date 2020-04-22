require './lib/oystercard'

card = Oystercard.new
card.top_up(6)
puts card.in_journey?
card.touch_in("Holborn")
puts card.in_journey?
puts card.entry_station
card.touch_out
puts card.entry_station
puts card.in_journey?
