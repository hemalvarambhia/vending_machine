require 'vending_machine'
describe VendingMachine do
  let(:product_dispenser) { double(:product_dispenser).as_null_object }
  let(:change_dispenser) { double(:change_dispenser).as_null_object }
  let(:catalogue) { double(:product_catalogue).as_null_object }
  let(:display_screen) { double(:display_screen).as_null_object }

  subject(:vending_machine) do
    VendingMachine.new(
      catalogue: catalogue,
      display: display_screen,
      product_dispenser: product_dispenser,
      change_dispenser: change_dispenser
    )
  end

  describe '#dispense' do
    let(:product_number) { '25' }
    let(:amount_inserted) { 50 }
    
    context 'when the customer pays the correct amount for the product' do
      before do
        allow(catalogue).to(
          receive(:price_for).with(product_number).and_return(50)
        )
      end
          
      it 'dispenses the product' do
        expect(product_dispenser).to receive(:dispense).with(product_number)

        vending_machine.dispense(product_number, amount_inserted)
      end

      it 'asks the user to collect their product' do
        expect(display_screen).to(
          receive(:show).with('Please collect your product')
        )

        vending_machine.dispense(product_number, amount_inserted)
      end

      it 'dispenses no change' do
        expect(change_dispenser).not_to receive(:dispense)

        vending_machine.dispense(product_number, amount_inserted)
      end
    end

    context 'when the customer does not insert enough money for the product' do
      before do
        allow(catalogue).to(
          receive(:price_for).with(product_number).and_return 75
        )
      end
          
      it 'does not dispense the product' do
        expect(product_dispenser).not_to receive(:dispense)

        vending_machine.dispense(product_number, amount_inserted)
      end
      
      it 'does not dispense any change' do
        expect(change_dispenser).not_to receive(:dispense)
        
        vending_machine.dispense(product_number, amount_inserted)
      end
      
      it 'asks them to insert the correct amount' do
        expect(display_screen).to(
          receive(:show).with('Please insert the correct amount')
        )
        
        vending_machine.dispense(product_number, amount_inserted)
      end
    end

    context 'when the customer overpays for the product' do
      before do
        allow(catalogue).to(
          receive(:price_for).with(product_number).and_return(50 - 5)
        )
      end
      
      it 'dispenses the correct change'do
        expect(change_dispenser).to receive(:dispense).with(5)

        vending_machine.dispense(product_number, amount_inserted)
      end

      it 'asks the customer to collect their change' do
        expect(display_screen).to(
          receive(:show).with('Please collect your change')
        )

        vending_machine.dispense(product_number, amount_inserted)
      end

      it 'dispenses the product' do
        expect(product_dispenser).to receive(:dispense).with(product_number)

        vending_machine.dispense(product_number, amount_inserted)
      end
    end

    context 'when the product is not listed in the catalogue' do
      it 'returns the customer their money back'

      it 'asks the user to select a different product'

      it 'does not dispense any product'
    end

    context 'when the product is out of stock' do
      it 'returns the customer there money back'

      it 'asks the user to select a different product'

      it 'despenses no product'
    end
  end

  describe '#amount_of_change' do
    let(:expected) do
      {
        200 => 50,
        100 => 1,
        50 => 2,
        20 => 1,
        10 => 1,
        5 => 0,
        2 => 50,
        1 => 100
      }
    end
    
    it 'returns the amount of change in the machine in pence' do
      allow(change_dispenser).to(
        receive(:amount_of_change)
        .and_return(expected)
      )

      expect(vending_machine.amount_of_change).to eq expected
    end
  end

  describe '#products_in_stock' do
    let(:expected) do
      {
        '123' => 10,
        '345' => 5,
        '678' => 25
      }
    end
    
    it 'returns the products in stock (product number & the quantity available)' do
      allow(product_dispenser).to receive(:products_in_stock).and_return(expected)
      
      expect(vending_machine.products_in_stock).to eq expected
    end
  end

  describe '#reload_products' do
    let(:products_to_load) { { 'A1' => 10 } }
    
    it 'reloads the products available in the machine' do
      expect(product_dispenser).to receive(:reload).with(products_to_load)

      vending_machine.reload_products(products_to_load)
    end
  end

  describe '#reload_change' do
    let(:change_to_reload) do
      {
        200 => 10,
        50 => 10,
        1 => 100
      }
    end
    
    it 'puts more change into the machine' do
      expect(change_dispenser).to receive(:reload).with(change_to_reload)

      vending_machine.reload_change(change_to_reload)
    end
  end
end
