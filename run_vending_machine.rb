$LOAD_PATH << 'lib'
require 'terminal_display'
require 'all_products_fifty_pence'
require 'change_dispenser'
require 'vending_machine'
require 'basic_product_dispenser'
terminal_display = TerminalDisplay.new
product_catalogue = AllProductsFiftyPence.new
change_dispenser =
  ChangeDispenser.new(
    200 => 10,
    100 => 10,
    50 => 10,
    20 => 10,
    10 => 10,
    5 => 10,
    2 => 10,
    1 => 10
  )
product_dispenser = BasicProductDispenser.new('A1' => 10, 'A2' => 10, 'A3' => 10)

vending_machine = VendingMachine.new(
  catalogue: product_catalogue,
  display: terminal_display,
  change_dispenser: change_dispenser,
  product_dispenser: product_dispenser
)
puts "Products in stock: #{vending_machine.products_in_stock}"
puts "Change in the vending machine: #{vending_machine.amount_of_change}"

vending_machine.dispense('A1', 65)

puts "Products in stock: #{vending_machine.products_in_stock}"
puts "Change in the vending machine: #{vending_machine.amount_of_change}"
