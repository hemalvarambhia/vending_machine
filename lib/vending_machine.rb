require 'forwardable'
class VendingMachine
  extend Forwardable
  def_delegator :@display, :show

  def initialize(catalogue:, product_dispenser:, change_dispenser:, display:, transaction_recorder:)
    @catalogue = catalogue
    @transaction_recorder = transaction_recorder
    @product_dispenser = product_dispenser
    @change_dispenser = change_dispenser
    @display = display
  end

  def dispense(product_number, amount_inserted)
    price_of_product = @catalogue.price_for(product_number)

    if price_of_product > amount_inserted
      show('Please insert the correct amount')
      return
    end

    if amount_inserted > price_of_product
      change = amount_inserted - price_of_product
      dispense_change(change)
    end

    dispense_product(product_number)
    @transaction_recorder.record(product: product_number, price: price_of_product)
  end

  def reload_products(products_to_load)
    @product_dispenser.reload(products_to_load)
  end

  def reload_change(change_to_load)
    @change_dispenser.reload(change_to_load)
  end

  def amount_of_change
    @change_dispenser.amount_of_change
  end

  def products_in_stock
    @product_dispenser.products_in_stock
  end

  private

  def dispense_change(change)
    show('Please collect your change')
    @change_dispenser.dispense(change)
  end

  def dispense_product(product_number)
    show('Please collect your product')
    @product_dispenser.dispense(product_number)
  end
end
