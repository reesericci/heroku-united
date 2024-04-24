class BroadcastsController < ApplicationController
  def new
  end

  def create
    b = Broadcast.create! broadcast_params
    redirect_back fallback_location: "/broadcasts"
  end

  private

  def broadcast_params
    params.require(:broadcast).permit(:subject, :content)
  end
end
