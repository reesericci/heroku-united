class Kiosk::MembersController < ApplicationController
  include Identity::Authenticate

  def edit
    @member = request.env["warden"].user(:identity)
    session[:redirect] = request.env["PATH_INFO"]
  end

  def update
    m = request.env["warden"].user(:identity)
    m.assign_attributes(member_params)
    if m.username_changed?
      if Member.find(m.username)
        errors = "<ul><li>Username is already taken</li></ul>"
        flash.now[:error] = errors
        m.username = m.username_was
        m.errors.add(:username, "is already taken")
        @member = m
        render :edit, status: :unprocessable_entity
        return
      end
    end
    if m.invalid?
      errors = "<ul>"
      m.errors.full_messages.each do |e|
        errors += "<li>#{e}</li>"
      end
      errors += "</ul>"
      flash.now[:error] = errors
      @member = m
      render :edit, status: :unprocessable_entity
      return
    end
    m.save!
    if m.address
      m.address.assign_attributes(address_params)
      if m.address.invalid?
        errors = "<ul>"
        m.address.errors.full_messages.each do |e|
          errors += "<li>#{e}</li>"
        end
        errors += "</ul>"
        flash[:error] = errors
        @member = m
        render :edit, status: :unprocessable_entity
        return
      end
      m.address.save!
    elsif Address.new(address_params.merge({addressable_id: m.id, addressable_type: "Member"})).valid?
      m.assign_attributes(address: Address.new(address_params.merge({addressable_id: m.id, addressable_type: "Member"})))
      if m.invalid?
        errors = "<ul>"
        m.errors.full_messages.each do |e|
          errors += "<li>#{e}</li>"
        end
        errors += "</ul>"
        flash[:error] = errors
        @member = m
        render :edit, status: :unprocessable_entity
        return
      end
      m.save!
    end
    redirect_to edit_kiosk_member_path
  end

  private

  def member_params
    params.require(:member).permit(:name, :username, :email, :signature)
  end

  def address_params
    params.require(:member).permit(address_attributes: [:line1, :line2, :city, :province, :code, :country])[:address_attributes]
  end
end
