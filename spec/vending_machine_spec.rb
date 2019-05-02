require './lib/vending_machine'
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
      change_dispenser: change_dispenser,
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
      
      it 'dispenses the product' do
        expect(product_dispenser).to receive(:dispense).with(product_number)

        vending_machine.dispense(product_number, amount_inserted)
      end
    end

    context 'when the product is not listed in the catalogue' do
      it 'asks the user to select a different product'

      it 'does not dispense any change'

      it 'does not dispense any product'
    end
  end
end
