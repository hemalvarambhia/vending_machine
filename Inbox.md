# Design Tension

The `dispense` method on the `VendingMachine`
has a clause in it that when the customer does not insert the correct amount (too little), nothing is dispensed and a message is shown to them to add more coins. A question worth asking is, should the `VendingMachine` ever be in this state at dispense time? Given that most machines have a slot to insert coins, this scenario should be unlikely. Perhaps this clause is better placed elsewhere.
