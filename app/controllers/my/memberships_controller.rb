class My::MembershipsController < My::BaseController
  skip_before_action :ensure_authenticated, only: [:new, :create]

  def new
    @extensions = Config.extensions
  end

  def create
    m = Member.new(member_params)
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
    rendered = false
    params[:member][:extensions].each do |k, v|
      e = m.extensions.find_by(name: k) || m.extensions.new(name: k)
      e.assign_attributes(content: v)
      if e.invalid?
        errors = "<ul>"
        m.errors.full_messages.each do |e|
          errors += "<li>#{e}</li>"
        end
        errors += "</ul>"
        flash.now[:error] = errors
        @member = m
        m.delete
        render :new, status: :unprocessable_entity
        rendered = true
        break
      end
      e.save!
    end
    JoinMailer.with(member: m).confirmation.deliver_later unless rendered
    redirect_to my_membership_path unless rendered
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
