# frozen_string_literal: true

require_relative 'handler_base'

class DepositHandler < HandlerBase
  def call(command)
    event = MoneyDeposited.new(aggregate_id: command.account_id, amount: command.amount)
    event_store.append(event)
  end
end
