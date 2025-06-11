# frozen_string_literal: true

require_relative 'event_store'
require_relative 'command_bus'
require_relative 'handlers/base_handler'
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

events = event_store.load_events('acc-1')
account = Account.new('acc-1')
account.load_from_history(events)

puts "Account balance: #{account.balance}"
