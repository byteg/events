# frozen_string_literal: true

class DepositCommand < Command
  attr_reader :account_id, :amount

  def initialize(account_id:, amount:)
    @account_id = account_id
    @amount = amount
    super()
  end
end
