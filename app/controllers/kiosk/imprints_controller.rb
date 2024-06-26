class Kiosk::ImprintsController < ApplicationController
  def rotate
    Imprint.find(params[:id])&.rotate!
    redirect_back_or_to kiosk_member_path
  end
end
