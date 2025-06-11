require_relative '../app/main'
require 'rspec'

RSpec.describe 'Event Sourcing with CommandBus' do
  let(:store) { EventStore.new }
  let(:bus)   { CommandBus.new }

  before do
    bus.register(DepositCommand, DepositHandler.new(store))
    bus.register(WithdrawCommand, WithdrawHandler.new(store))
  end

  let(:account_id) { "acc-1" }

  def load_account
    events = store.load_events(account_id)
    Account.new(account_id).load_from_history(events)
  end

  it 'processes a deposit command and updates account balance' do
    bus.dispatch(DepositCommand.new(account_id: account_id, amount: 100))
    account = load_account

    expect(account.balance).to eq(100)
  end

  it 'processes a withdraw command and updates account balance' do
    bus.dispatch(DepositCommand.new(account_id: account_id, amount: 200))
    bus.dispatch(WithdrawCommand.new(account_id: account_id, amount: 50))
    account = load_account

    expect(account.balance).to eq(150)
  end

  it 'raises an error when trying to withdraw more than balance' do
    bus.dispatch(DepositCommand.new(account_id: account_id, amount: 100))

    expect {
      bus.dispatch(WithdrawCommand.new(account_id: account_id, amount: 200))
    }.to raise_error("Insufficient funds")
  end

  it 'appends correct events to the event store' do
    bus.dispatch(DepositCommand.new(account_id: account_id, amount: 80))
    bus.dispatch(WithdrawCommand.new(account_id: account_id, amount: 30))

    events = store.load_events(account_id)
    expect(events.size).to eq(2)

    expect(events[0]).to be_a(MoneyDeposited)
    expect(events[0].amount).to eq(80)

    expect(events[1]).to be_a(MoneyWithdrawn)
    expect(events[1].amount).to eq(30)
  end
end