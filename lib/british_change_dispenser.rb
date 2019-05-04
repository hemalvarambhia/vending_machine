class BritishChangeDispenser
  attr_reader :amount_of_change
  def initialize(change)
    @amount_of_change = change
  end
  
  def dispense(change)
    # TODO
  end

  def change_for(change)
    [ change ]
  end
end
