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
product_dispenser = BasicProductDispenser.new('A1' => 2, 'A2' => 10, 'A3' => 10)

vending_machine = VendingMachine.new(
  catalogue: product_catalogue,
  display: terminal_display,
  change_dispenser: change_dispenser,
  product_dispenser: product_dispenser
)
puts "Products in stock: #{vending_machine.products_in_stock}"
puts "Change in the vending machine: #{vending_machine.amount_of_change}"

product_to_buy = 'A1'
amount_to_insert = 65
puts "Buy product '#{product_to_buy}' costing #{product_catalogue.price_for(product_to_buy)}p, put #{amount_to_insert}p in to the machine"
vending_machine.dispense(product_to_buy, amount_to_insert)

puts "Products in stock: #{vending_machine.products_in_stock}"
puts "Change in the vending machine: #{vending_machine.amount_of_change}"

puts "Reload Product 'A1': #{vending_machine.reload_products('A1' => 9)}"
puts "Products in stock: #{vending_machine.products_in_stock}"

puts "Reload Change: #{vending_machine.reload_change(10 => 1, 5 => 1)}"
puts "Change in the vending machine: #{vending_machine.amount_of_change}"
