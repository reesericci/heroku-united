class Expirable::AdvisementJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Expirable.find_each do |e|
      mail(e)
    end
  end

  private

  def mail(e)
    if e.expiry_advised != relative_expiring(e)
      Expirable::AdvisoryMailer.with(expirable: e).send(relative_expiring(e)).deliver_later
    end
  end

  def relative_expiring(e)
    :expired if e.expired
    :day if e.day_only?
    :week if e.week_only?
    :month if e.month_only?
  end
end
