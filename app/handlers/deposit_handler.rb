# frozen_string_literal: true

class DepositHandler
  def initialize(event_store)
    @event_store = event_store
  end

  def call(command)
    event = MoneyDeposited.new(aggregate_id: command.account_id, amount: command.amount)
    event_store.append(event)
  end

  private

  attr_reader :event_store
end
