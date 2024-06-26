class Api::MembersController < Api::BaseController
  def index
    @members = Member.all.sort_by(&:created_at).reverse
  end

  def create
    @member = Member.new(member_params)
    if @member.invalid?
      render json: @member.errors, status: 400
      return
    end

    @member.save!

    returned = false

    params[:extensions].each do |k, v|
      e = if @member.extensions.find_by(name: k).present?
        e = @member.extensions.find_by(name: k)
        e.assign_attributes(content: v)
        e
      else
        @member.extensions.new(name: k, content: v)
      end
      if e.invalid?
        @member.delete
        render json: e.errors, status: 400
        returned = true
        break
      end
      e.save!
    end

    if @member.address
      a = @member.address
      a.assign_attributes(address_params)
      if a.invalid?
        @member.delete
        render json: a.errors, status: 400
        return
      end
    else
      a = begin
        Address.new(address_params.merge({addressable_id: @member.id, addressable_type: "Member"}))
      rescue => e
        @member.delete
        render json: e.to_json, status: 400
        return
      end
      if a.invalid?
        @member.delete
        render json: a.errors, status: 400
        return
      end
      @member.update!(address: a)
    end

    render "show" unless returned
  end

  def update
    @member = Member.find_by(username: params[:username])
    @member&.assign_attributes(member_params)
    params[:extensions].each do |k, v|
      if member.extensions.find_by(name: k).present?
        member.extensions.find_by(name: k).update!(content: v)
      else
        member.extensions.create!(name: k, content: v)
      end
    end
    if @member.address
      a = @member.address
      a.assign_attributes(address_params)
      if a.invalid?
        render json: a.errors, status: 400
        return
      end
    else
      a = begin
        Address.new(address_params.merge({addressable_id: @member.id, addressable_type: "Member"}))
      rescue => e
        @member.delete
        render json: e.to_json, status: 400
        return
      end
      if a.invalid?
        @member.delete
        render json: a.errors, status: 400
        return
      end
      @member.update!(address: a)
    end

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
    Member.find_by(username: params[:username])&.destroy!
    render json: Member.ids
  end

  private

  def member_params
    params.require(:member).permit(:username, :name, :email, :pronouns, :banned, :expires_at)
  end

  def address_params
    params.require(:address).permit(:line1, :line2, :city, :province, :code, :country)
  end

  def extensions_params
    params.require(:member)[:extensions]
  end
end
