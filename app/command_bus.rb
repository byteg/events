# frozen_string_literal: true

class CommandBus
  def initialize
    @handlers = {}
    @middlewares = []
  end

  def register(command_class, handler)
    handlers[command_class] = handler
  end

  def use(middleware)
    middlewares << middleware
  end

  def dispatch(command)
    handler = @handlers[command.class]
    raise "No handler registered for #{command.class}" unless handler

    chain = build_middleware_chain(handler)
    chain.call(command)
  end

  private

  attr_reader :handlers, :middlewares

  def build_middleware_chain(handler)
    middlewares.reverse.inject(handler) do |next_handler, middleware|
      ->(command) { middleware.call(command, next_handler) }
    end
  end
end
