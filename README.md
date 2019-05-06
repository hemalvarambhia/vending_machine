# Vending Machine Exercise

## Development Assumptions
In terms of modeling, I have assumed the vending machine consists of:

- a product catalogue listing the products and their prices in pence/cents;
- a product dispenser;
- a change dispenser;
- a display to show the user any instructions.

It is assumed that:
- all currencies are in pence/cents etc. e.g. £2.55
is taken as 255p, modelling them as integers for now until there is a clear need to introduce the concept of money; and
- product numbers take the form 'A10', 'B5' etc.


No edge cases have been considered in solving this problem beyond any
specified in the functional requirements.
Nevertheless, edge cases have been identified and listed as pending tests and would be the topic of a conversation with the manufacterer of the vending machine.

In terms of reviewing the work I recommend starting with the
`vending_machine_spec.rb` which is a unit test for the vending machine.
I used top down TDD with mock objects to develop the solution and the vending
machine is the top level unit test. The interfaces discovered where then used
to TDD the next layer down.

I have not developed a more realistic product dispenser and catalogue as I'd like to discuss those a bit more should the opportunity arise but through mock objects I have been able to define contracts for them. I used those to create a `BasicProductDispenser` for the purposes of a demo, which has not been tested as the logic is deemed to be very simple. `TerminalDisplay` has not been tested for the same reason and it is an object that sits at the system boundary (it interacts with STDOUT). I added an integrated test with some real objects to stay honest, however  (`vending_machine_integrated_spec.rb`).

Due to time constraints I have developed the interfaces for reloading products and change but have not yet implemented the reload method for the product dispenser. Nevertheless I hope the other work on dispensing change or products show how I would have done this.

The way the work has been done (using dependency inversion) means
that we can support any currency since that detail has been isolated in the change dispenser. Similarly we have encapsulated the vending machine from implementation details of the product dispenser and product catalogue so the code is, hopefully, SOLID. The parts of the machine listed above are now polymorphic objects with clearly defined contracts.

## Executing the program
For now, due to time constraints, I have created a script where we
assume a customer has bought a product, number 'A1', costing 50p and inserts
65p, meaning they get 15p change back. For simplicity, for this script,
I created a class called `AllProductsFiftyPence` where, of course, all
products are 50p.

**Ruby Version Required:** `2.5.0`
### Running the program:
- `bundle install`
- `ruby run_vending_machine.rb`

### Running the tests:
- `bundle exec rspec -cfd`
