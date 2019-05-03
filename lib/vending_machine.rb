class VendingMachine
  def initialize(catalogue:, product_dispenser:, change_dispenser:, display:)
    @catalogue = catalogue
    @product_dispenser = product_dispenser
    @change_dispenser = change_dispenser
    @display = display
  end

  def dispense(product_number, amount_inserted)
    price_of_product = @catalogue.price_for(product_number)

    if price_of_product > amount_inserted
      @display.show('Please insert the correct amount')
      return
    end

    if amount_inserted > price_of_product
      change = amount_inserted - price_of_product
      dispense_change(change)
    end
    
    dispense_product(product_number)
  end

  def amount_of_change
    @change_dispenser.amount_of_change
  end

  def products_in_stock
    @product_dispenser.products_in_stock
  end

  private

  def dispense_change(change)
    @display.show('Please collect your change')
    @change_dispenser.dispense(change)
  end

  def dispense_product(product_number)
    @display.show('Please collect your product')
    @product_dispenser.dispense(product_number)
  end
end
