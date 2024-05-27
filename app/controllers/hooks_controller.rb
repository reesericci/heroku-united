class HooksController < ApplicationController
  def index
    @trigger = Rails.application.triggers[params[:trigger_id].to_sym]
  end
end
