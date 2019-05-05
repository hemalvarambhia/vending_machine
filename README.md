# Vending Machine Exercise

## Development Assumptions
In terms of modeling, I have assumed the vending machine consists of:

- a product catalogue listing the products and their prices in pence/cents;
- a product dispenser;
- a change dispenser;
- a display to show the user any instructions.

No edge cases have been considered in solving this problem beyond the any
specified in the functional requirements.
Nevertheless, edge cases have been identified and listed as pending tests and would be the topic of a conversation with the manufacterer of the vending machine.

It is assumed that all currencies are in pence/cents etc. e.g. £2.55
is taken as 255p and that product numbers take the form 'A10', 'B5' etc.

In terms of reviewing the work I recommend starting with the
`vending_machine_spec.rb` which is a unit test for the vending machine.
I used top down TDD with mock objects to develop the solution and the vending
machine is the top level unit test. The interfaces discovered where then used
to TDD the next layer down.
The `BasicProductDispenser` and `TerminalDisplay` have not been tested as the logic is considered to be very simple.

## Executing the program
For now, due to time constraints, I have created a script where we
assume a customer has bought a product, number 'A1', costing 50p and inserts
65p, meaning they get 15p change back. For simplicity, for this script,
I created a class called `AllProductsFiftyPence` where, of course, all
products are 50p.

**Ruby Version Required:** `2.5.0`
### Running the program:
`ruby run_vending_machine.rb`
