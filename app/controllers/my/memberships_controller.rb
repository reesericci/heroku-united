class My::MembershipsController < My::BaseController
  skip_before_action :ensure_authenticated, only: [:new, :create]

  def new
    @extensions = Config.extensions
  end

  def create
    m = Member.new(member_params.merge!({extensions_attributes: mapped_extensions}))
    m.expires_at = DateTime.now + Config.membership_length.days

    if m.invalid?
      flash.now[:error] = m.errors.full_messages
      render :new, status: :unprocessable_entity
      return
    end

    m.save!

    # TODO: make this a callback instead
    My::MembershipMailer.with(member: m).created.deliver_later

    redirect_to my_membership_path
  end

  def show
    Journey.basecamp = request.env["PATH_INFO"]
  end

  def update
    m = My.member
    m.assign_attributes(member_params.merge!({extensions_attributes: mapped_extensions}))

    # TODO: make this a validation
    if m.username_changed? && Member.find(m.username)
      m.username = m.username_was
      return
    end

    if m.invalid?
      flash.now[:error] = m.errors.full_messages
      render :show, status: :unprocessable_entity
      return
    end

    m.save!
    redirect_to my_membership_path
  end

  private

  def member_params
    params.require(:member).permit(:name, :username, :email, :signature, keycode_imprint_attributes: [:email, :base], address_attributes: [:line1, :line2, :city, :province, :code, :country], extensions_attributes: {})
  end

  def mapped_extensions
    attrs = member_params[:extensions_attributes]
    attrs.keys.map { |e| {name: e, content: attrs[e]} }
  end
end
