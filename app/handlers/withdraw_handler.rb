# frozen_string_literal: true

class WithdrawHandler
  def initialize(event_store)
    @event_store = event_store
  end

  def call(command)
    events = event_store.load_events(command.account_id)
    account = Account.new(command.account_id).load_from_history(events)

    raise 'Insufficient funds' if account.balance < command.amount

    event = MoneyWithdrawn.new(aggregate_id: command.account_id, amount: command.amount)
    event_store.append(event)
  end

  private

  attr_reader :event_store
end
