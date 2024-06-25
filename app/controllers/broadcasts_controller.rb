class BroadcastsController < SecretController
  def new
  end

  def create
    Broadcast.create! broadcast_params
    redirect_back fallback_location: broadcasts_path
  end

  private

  def broadcast_params
    params.require(:broadcast).permit(:subject, :content)
  end
end
