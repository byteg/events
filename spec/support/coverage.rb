require 'simplecov'

SimpleCov.start do
  enable_coverage :branch
  add_filter '/spec/'

  SimpleCov.minimum_coverage 90

  add_group 'Commands',     'app/commands'
  add_group 'Handlers',     'app/handlers'
  add_group 'Events',       'app/events'
  add_group 'Aggregates',   'app/aggregates'
  add_group 'Middleware',   'app/middleware'
  add_group 'Infrastructure', 'app/event_store.rb'
end

puts "[SimpleCov] Coverage tracking started..."