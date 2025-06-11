# frozen_string_literal: true

class MoneyWithdrawn < Event
  attr_reader :amount

  def initialize(aggregate_id:, amount:)
    super(aggregate_id:)
    @amount = amount
  end
end
