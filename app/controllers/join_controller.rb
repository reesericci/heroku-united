class JoinController < ApplicationController
  def new
  end

  def create
    m = Member.new(member_params)
    m.build_address(address_params)
    m.expires_at = DateTime.now + Config.membership_length.days
    if m.invalid?
      errors = "<ul>"
      m.errors.full_messages.each do |e|
        errors += "<li>#{e}</li>"
      end
      errors += "</ul>"
      flash.now[:error] = errors
      @member = m
      render :new, status: :unprocessable_entity
      return
    end
    m.save!
    redirect_to join_confirmation_path
  end

  private

  def member_params
    params.require(:member).permit(:name, :username, :email, :signature)
  end

  def address_params
    params.require(:member).permit(address: [:line1, :line2, :city, :province, :code, :country])[:address]
  end
end
