class Api::MembersController < Api::BaseController
  def index
    @members = Member.all.sort_by(&:created_at).reverse
  end

  def create
    @member = Member.new(members_params)
    if @member.invalid?
      render json: @member.errors, status: 400
      return
    end

    @member.save

    render "show"
  end

  def update
    @member = Member.find_by(username: params[:username])
    @member&.assign_attributes(member_params)
    if @member&.invalid?
      render json: @member.errors, status: 400
      return
    end

    @member&.save!

    render "show"
  end

  def show
    @member = Member.find_by(username: params[:username])
  end

  def destroy
    Member.find_by(username: params[:username])&.destroy
    
    render json: Member.ids
  end

  private

  def members_params
    params.permit(:username, :name, :email, :pronouns, :auxillary, :banned, :expires_at)
  end

  def member_params
    params.require(:member).permit(:username, :name, :email, :pronouns, :auxillary, :banned, :expires_at)
  end
end
