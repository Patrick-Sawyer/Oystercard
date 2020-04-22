# oystercard
Makers Week 2 challenge

In order to use public transport
As a customer
I want money on my card

In order to keep using public transport
As a customer
I want to add money to my card

In order to pay for my journey
As a customer
I need my fare deducted from my card

In order to get through the barriers.
As a customer
I need to touch in and out.

In order to pay for my journey
As a customer
I need to have the minimum amount (£1) for a single journey.

In order to pay for my journey
As a customer
When my journey is complete, I need the correct amount deducted from my card

In order to pay for my journey
As a customer
I need to know where I've travelled from

In order to know where I have been
As a customer
I want to see all my previous trips

Domain Model::

| Object     | Message |
| ---        | ---   |
| Oystercard | balance |
|            | top_up(amount) += balance
             | deduct(fare) -= balance
             | in_journey? = false
             | touch_in(station) - updates @in_journey? true
                        - throws error when below min balance
                        - updates entry_station
             | touch_out - updates to false
                        - changes balance by min fare
               update_entry_station(station) -
             | constant = min balance 


#test
check in_jounrey is false when new instance
touch_in - eq (true)
touch_out - eq(false )
