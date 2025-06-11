# frozen_string_literal: true

class WithdrawCommand < Command
  attr_reader :account_id, :amount

  def initialize(account_id:, amount:)
    @account_id = account_id
    @amount = amount
    super()
  end
end
