class ConfigurationController < ApplicationController
  include Authenticatable
  skip_before_action :ensure_configured, :ensure_authenticated, only: [:new, :create]

  def new
    if Config.first
      redirect_to root_path, flash: {error: "This instance is already configured"}
    end
  end

  def create
    if Config.first
      redirect_to root_path, flash: {error: "This instance is already configured"}
      return
    end
    c = Config.new(config_params)
    c.save!
    redirect_to root_path
  end

  def edit
  end

  def update
    c = Config.first
    c.assign_attributes(config_params)
    if c.invalid?
      errors = "<ul>"
      m.errors.full_messages.each do |e|
        errors += "<li>#{e}</li>"
      end
      errors += "</ul>"
      flash.now[:error] = errors
      render :edit, status: :unprocessable_entity
      return
    end
    c.save!
    redirect_back fallback_location: "/confguration"
  end

  private

  def config_params
    params.require(:config).permit(:organization, :membership_length, :email, :password, smtp: [:server, :port, :username, :password, :box, :domain])
  end
end
