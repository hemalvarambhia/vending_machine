require 'vending_machine'
require 'all_products_fifty_pence'
require 'basic_product_dispenser'
require 'change_dispenser'

class StringBasedDisplay
  def initialize(string_io)
    @output_display = string_io
  end

  def show(message)
    @output_display.puts(message)
  end
end

describe VendingMachine do
  let(:the_console) { StringIO.new }
  let(:vending_machine) do
    described_class.new(
      catalogue: AllProductsFiftyPence.new,
      product_dispenser: BasicProductDispenser.new(
        'A1' => 10, 'A2' => 20, 'A3' => 30
      ),
      change_dispenser: ChangeDispenser.new(
        200 => 10,
        100 => 10,
        50 => 10,
        20 => 10,
        10 => 10,
        5 => 10,
        2 => 10,
        1 => 10  
      ),
      display: StringBasedDisplay.new(the_console)
    )
  end

  let(:expected_products_remaining) { { 'A1' => 9, 'A2' => 20, 'A3' => 30 } }
  let(:expected_change_remaining) do
    {
      200 => 10,
      100 => 10,
      50 => 10,
      20 => 10,
      10 => 10,
      5 => 9,
      2 => 10,
      1 => 10
    }
  end

  it 'dispenses the correct product' do
    vending_machine.dispense('A1', 55)
    
    expect(vending_machine.products_in_stock).to eq expected_products_remaining
  end

  it 'dispenses the correct amount of change' do
    vending_machine.dispense('A1', 55)
    
    expect(vending_machine.amount_of_change).to eq expected_change_remaining
  end

  it 'asks the user to collect their change' do
    vending_machine.dispense('A1', 55)
    
    expect(the_console.string).to match /Please collect your change/
  end

  it 'asks the user to collect their product' do
    vending_machine.dispense('A1', 55)
    
    expect(the_console.string).to match /Please collect your product/
  end
end
