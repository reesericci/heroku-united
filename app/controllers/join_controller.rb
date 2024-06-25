class JoinController < ApplicationController
  def new
  end

  def create
    m = Member.new(member_params)
    m.build_address(address_params)
    params[:member][:extensions].each do |k, v|
      if m.extensions.find_by(name: k).blank?
        m.extensions.new(name: k, content: v)
      else
        m.extensions.find_by(name: k).assign_attributes(content: v)
      end
    end
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
    m.extensions.each { |e| e.save! }
    JoinMailer.with(member: m).confirmation.deliver_later
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
