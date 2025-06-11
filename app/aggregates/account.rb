# frozen_string_literal: true

class Account
  attr_accessor :id, :balance

  def initialize(id)
    @id = id
    @balance = 0
  end

  def apply(event)
    case event
    when MoneyDeposited
      self.balance += event.amount
    when MoneyWithdrawn
      self.balance -= event.amount
    end
  end

  def load_from_history(events)
    events.each { |event| apply(event) }
    self
  end
end
