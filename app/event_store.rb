# frozen_string_literal: true

class EventStore
  def initialize
    @events = Hash.new { |h, k| h[k] = [] }
  end

  def append(event)
    events[event.aggregate_id] << event
  end

  def load_events(aggregate_id)
    events[aggregate_id]
  end

  private

  attr_reader :events
end
