# frozen_string_literal: true

class DepositHandler < BaseHandler
  def call(command)
    event = MoneyDeposited.new(aggregate_id: command.account_id, amount: command.amount)
    event_store.append(event)
  end
end
