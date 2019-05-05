class ChangeDispenser
  attr_reader :amount_of_change

  def initialize(change)
    @amount_of_change = change
  end
  
  def dispense(change)
    coins_by_denomination = coins_for(change)
            .group_by { |coin| coin }
            .map { |denomination, coins| [ denomination, coins.count ] }
            .to_h
    coins_by_denomination.each do |denomination, quantity|
      @amount_of_change[denomination] = @amount_of_change[denomination] - quantity
    end
  end

  def coins_for(change)
    required_denominations =
      available_denominations.reject { |coin| coin > change }
    return [ change ] if change == required_denominations.first
    [required_denominations.first] +
      coins_for(change - required_denominations.first)
  end  

  private

  def available_denominations
    @amount_of_change.select { |_, quantity| quantity > 0 }.keys
  end
end
