class Expirable::AdvisementJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Expirable.find_each do |e|
      e.advisory&.send
    end
  end
end
