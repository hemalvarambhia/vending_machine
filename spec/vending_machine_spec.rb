require './lib/vending_machine'
describe VendingMachine do
  let(:item_dispenser) { double(:item_dispenser).as_null_object }
  let(:change_dispenser) { double(:change_dispenser).as_null_object }

  subject(:vending_machine) do
    VendingMachine.new(
      item_dispenser: item_dispenser,
      change_dispenser: change_dispenser,
    )
  end

  describe '#purchase' do
    let(:product_number) { '25' }
    let(:amount_payed) { 50 }

    context 'when the customer pays the correct amount for the item' do
      it 'dispenses the item' do
        expect(item_dispenser).to receive(:dispense).with(product_number)

        vending_machine.dispense(product_number, amount_payed)
      end

      it 'dispenses no change' do
        expect(change_dispenser).not_to receive(:dispense)

        vending_machine.dispense(product_number, amount_payed)
      end
    end
  end
end
