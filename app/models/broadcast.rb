class Broadcast < ApplicationRecord
  has_rich_text(:content)
  broadcasts_refreshes
  validates :subject, :content, presence: true

  after_create_commit do |b|
    Member.where_active.each do |m|
      e = Organization::BroadcastMailer.with(broadcast: self, member: m).new
      e.deliver_later
    end
  end
end
