class JoinController < ApplicationController
  def new
  end

  def create
    m = Member.new(member_params)
    m.expires_at = DateTime.now + Config.membership_length.days
    if m.invalid?
      errors = "<ul>"
      m.errors.full_messages.each do |e|
        errors = errors + "<li>#{e}</li>"
      end
      errors = errors + "</ul>"
      flash.now[:error] = errors
      @member = m
      render :new, status: :unprocessable_entity
      return
    end
    m.save!
    redirect_to "/join/confirmation"
  end

  private
    # Using a private method to encapsulate the permissible parameters
    # is just a good pattern since you'll be able to reuse the same
    # permit list between create and update. Also, you can specialize
    # this method with per-user checking of permissible attributes.
    def member_params
      params.require(:member).permit(:name, :username, :email)
    end
end
