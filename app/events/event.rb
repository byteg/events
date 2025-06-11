# frozen_string_literal: true

class Event
  attr_reader :aggregate_id, :timestamp

  def initialize(aggregate_id:)
    @aggregate_id = aggregate_id
    @timestamp = Time.now
  end
end
