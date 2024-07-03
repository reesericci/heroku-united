class Api::MembersController < Api::BaseController
  def index
    @members = Member.all.sort_by(&:created_at).reverse
  end

  def create
    # be sure to use extensions_attributes and not extensions!
    @member = Member.new(member_params)

    if @member.invalid?
      render json: @member.errors, status: 400
    else
      @member.save!
      render "show"
    end
  end

  def update
    @member = Member.find_by(username: params[:username])
    @member.assign_attributes(member_params)

    if @member.invalid?
      render json: @member.errors, status: 400
    else
      @member.save!
      render "show"
    end
  end

  def show
    @member = Member.find_by(username: params[:username])
  end

  def destroy
    Member.find_by(username: params[:username]).destroy!
    render json: Member.ids
  end

  private

  def member_params
    params.require(:member).permit(:username, :name, :email, :pronouns, :banned, :expires_at, :extensions_attributes, address_attributes: [:line1, :line2, :city, :province, :code, :country])
  end
end
