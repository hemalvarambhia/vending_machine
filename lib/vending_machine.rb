class VendingMachine
  def initialize(catalogue:, item_dispenser:, change_dispenser:, display:)
    @catalogue = catalogue
    @item_dispenser = item_dispenser
    @display = display
  end

  def dispense(product, amount_inserted)
    price_of_product = @catalogue.price_for(product)

    if price_of_product > amount_inserted
      @display.show('Please insert the correct amount')
      return
    end

    @item_dispenser.dispense(product)
  end
end
