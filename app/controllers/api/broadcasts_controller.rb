class Api::BroadcastsController < Api::BaseController
  def index
    @broadcasts = Broadcast.all.sort_by(&:created_at).reverse
  end

  def create
    @broadcast = Broadcast.new(broadcasts_params)
    if @broadcast.invalid?
      render json: @broadcast.errors, status: 400
      return
    end

    @broadcast.save!

    render "show"
  end

  def show
    @broadcast = Broadcast.find_by(id: params[:id])
  end

  def destroy
    Broadcast.find_by(id: params[:id])&.destroy!

    render json: Broadcast.ids
  end

  private

  def broadcasts_params
    params.permit(:subject, :content, :broadcast)
  end
end
