class BasicProductDispenser
  attr_reader :products_in_stock

  def initialize(products_in_stock)
    @products_in_stock = products_in_stock
  end

  def dispense(product_number)
    @products_in_stock[product_number] = @products_in_stock[product_number] - 1 
  end

  def reload(products)
    products.each do |product_number, quantity|
      @products_in_stock[product_number] =
        @products_in_stock[product_number] + quantity 
    end
  end
end
