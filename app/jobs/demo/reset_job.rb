class Demo::ResetJob < ApplicationJob
  queue_as :default

  def perform(*args)
    ActiveRecord::SessionStore::Session.destroy_all
    Config.delete_all
    Config.create!(FactoryBot.attributes_for(:config))
    Member.delete_all
  end
end
