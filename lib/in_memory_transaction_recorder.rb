class InMemoryTransactionRecorder
  def initialize
    @transactions = []
  end

  def record(transaction)
    @transactions << transaction[:product_number]
  end

  def most_popular_items(number)
    @transactions
      .group_by { |product| product }
      .sort_by { |product_number, products| products.count }
      .map { |product_number, products| product_number }
  end
end
