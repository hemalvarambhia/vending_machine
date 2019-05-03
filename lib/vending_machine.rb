class VendingMachine
  def initialize(catalogue:, product_dispenser:, change_dispenser:, display:)
    @catalogue = catalogue
    @product_dispenser = product_dispenser
    @change_dispenser = change_dispenser
    @display = display
  end

  def dispense(product, amount_inserted)
    price_of_product = @catalogue.price_for(product)

    if price_of_product > amount_inserted
      @display.show('Please insert the correct amount')
      return
    end

    if amount_inserted > price_of_product
      change = amount_inserted - price_of_product
      @change_dispenser.dispense(change)
    end
    
    @display.show('Please collect your product')
    @product_dispenser.dispense(product)
  end

  def amount_of_change
    @change_dispenser.amount_of_change
  end

  def products_in_stock
    @product_dispenser.products_in_stock
  end
end
