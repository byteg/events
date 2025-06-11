# frozen_string_literal: true

require_relative 'event_store'
require_relative 'command_bus'
require_relative 'handlers/deposit_handler'
require_relative 'handlers/withdraw_handler'
require_relative 'commands/command'
require_relative 'commands/deposit_command'
require_relative 'commands/withdraw_command'
require_relative 'aggregates/account'
require_relative 'events/event'
require_relative 'events/money_deposited'
require_relative 'events/money_withdrawn'
require_relative 'middleware/logging_middleware'

event_store = EventStore.new
bus = CommandBus.new

bus.register(DepositCommand, DepositHandler.new(event_store))
bus.register(WithdrawCommand, WithdrawHandler.new(event_store))

bus.use(LoggingMiddleware.new)

bus.dispatch(DepositCommand.new(account_id: 'acc-1', amount: 200))
bus.dispatch(WithdrawCommand.new(account_id: 'acc-1', amount: 80))
