class Broadcast < ApplicationRecord
  extend Instigative
  has_rich_text(:content)
  broadcasts_refreshes
  validates :subject, :content, presence: true

  trigger :sent, "Sent"

  after_create_commit do |b|
    Member.where_active.each do |m|
      e = BroadcastMailer.with(broadcast: self, member: m).broadcast_email
      e.deliver_later
    end

    fire_sent!
  end
end
