class My::MembershipsController < My::BaseController
  skip_before_action :ensure_authenticated, only: [:new, :create]

  def new
    @extensions = Config.extensions
  end

  def create
    @member = Member.new(member_params)

    @member.expires_at = DateTime.now

    (params[:member][:extensions] || {}).each do |k, v|
      e = @member.extensions.find_by(name: k) || @member.extensions.new(name: k)
      e.assign_attributes(content: v)
    end
    if @member.invalid?
      flash.now[:error] = @member.errors.full_messages
      render :new, status: :unprocessable_entity
      return
    end

    if Config.payable
      @payment = @member.payments.find_or_create_by!(stripe_id: params[:member][:stripe_payment_intent])

      if @payment.state == :failed
        flash.now[:error] = "Payment was not successfully processed."
        render :new, status: :unprocessable_entity
        return
      end

      if @member.payment_processing?
        @member.save!
        redirect_to my_membership_path
      end

    end

    My::MembershipMailer.with(member: @member).created.deliver_later
    @member.save!
    redirect_to my_membership_path
  end

  def show
    @member = request.env["warden"].user(:my)
    session[:redirect] = request.env["PATH_INFO"]
  end

  def update
    m = request.env["warden"].user(:my)
    m.assign_attributes(member_params)
    if m.username_changed?
      if Member.find(m.username)
        errors = "<ul><li>Username is already taken</li></ul>"
        flash.now[:error] = errors
        m.username = m.username_was
        m.errors.add(:username, "is already taken")
        @member = m
        render :show, status: :unprocessable_entity
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
      render :show, status: :unprocessable_entity
      return
    end
    m.save!
    redirect_to my_membership_path
  end

  private

  def member_params
    params.require(:member).permit(:name, :username, :email, :signature, keycode_imprint_attributes: [:email, :base], address_attributes: [:line1, :line2, :city, :province, :code, :country])
  end
end
