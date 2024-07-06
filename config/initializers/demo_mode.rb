# frozen_string_literal: true

# See README at https://github.com/Betterment/demo_mode

DemoMode.configure do
  current_user_method :current_user

  splash_base_controller_name "My::Journey::BaseController"

  app_base_controller_name "ApplicationController"

  password { "correct-horse-battery-staple" }
end

if Rails.env.demo?
  Rails.application.config.after_initialize do
    if ActiveRecord::Base.connection.table_exists?(Config.table_name) &&
        ActiveRecord::Base.connection.table_exists?(ActiveRecord::SessionStore::Session.table_name) &&
        ActiveRecord::Base.connection.table_exists?(Member.table_name)
      Config.delete_all
      Config.create!(FactoryBot.attributes_for(:config))
      Member.delete_all
      ActiveRecord::SessionStore::Session.destroy_all
    end
  end
end
