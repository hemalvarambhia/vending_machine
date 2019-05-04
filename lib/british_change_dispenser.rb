class BritishChangeDispenser
  attr_reader :amount_of_change
  def initialize(change)
    @amount_of_change = change
  end
  
  def dispense(change)
    # TODO
  end

  def change_for(change)
    return [ change ] if change == available_denominations.first
    [change - available_denominations.first] +
      change_for(change - available_denominations.first)
  end

  private

  def available_denominations
    @amount_of_change.select { |_, quantity| quantity > 0 }.keys
  end
end
