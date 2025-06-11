# frozen_string_literal: true

class LoggingMiddleware
  def call(command, next_handler)
    puts "[LOG] Dispatching #{command.class} with data: #{command.inspect}"
    start = Time.now

    result = next_handler.call(command)

    duration = ((Time.now - start) * 1000).round(2)
    puts "[LOG] Done #{command.class} in #{duration}ms"

    result
  rescue StandardError => e
    puts "[ERROR] #{command.class} failed: #{e.message}"
    raise
  end
end
