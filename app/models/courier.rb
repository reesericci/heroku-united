class Courier < ApplicationRecord
  include Hookable

  has_rich_text :content

  def call!
    CourierMailer.with(content: content, subject: subject, to: to).hook_email.deliver_later
  end
end
