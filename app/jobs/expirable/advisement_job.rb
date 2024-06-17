class Expirable::AdvisementJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Expirable.find_each do |e|
      if e.expired? && e.expiry_advised != :expired
        Expirable::AdvisoryMailer.with(expirable: e).expired.deliver_later
      elsif e.day_only? && e.expiry_advised != :day
        Expirable::AdvisoryMailer.with(expirable: e).day.deliver_later
      elsif e.week_only? && e.expiry_advised != :week
        Expirable::AdvisoryMailer.with(expirable: e).week.deliver_later
      elsif e.month_only? && e.expiry_advised != :month
        Expirable::AdvisoryMailer.with(expirable: e).month.deliver_later
      end
    end
  end
end
