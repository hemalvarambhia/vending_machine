class BritishChangeDispenser
  attr_reader :amount_of_change
  def initialize(change)
    @amount_of_change = change
  end
  
  def dispense(change)
    coins = change_for(change)
    coins.each { |coin| @amount_of_change[coin] = 0 }
  end

  def change_for(change)
    required_denominations =
      available_denominations.reject { |coin| coin > change }
    return [ change ] if change == required_denominations.first
    [required_denominations.first] +
      change_for(change - required_denominations.first)
  end

  private

  def available_denominations
    @amount_of_change.select { |_, quantity| quantity > 0 }.keys
  end
end
