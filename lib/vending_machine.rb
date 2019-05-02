class VendingMachine
  def initialize(item_dispenser:, change_dispenser:)
    @item_dispenser = item_dispenser
  end

  def dispense(product, amount_payed)
    @item_dispenser.dispense(product)
  end
end
