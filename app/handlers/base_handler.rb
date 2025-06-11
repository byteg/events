# frozen_string_literal: true

class BaseHandler
  def initialize(event_store)
    @event_store = event_store
  end

  private

  attr_reader :event_store
end
