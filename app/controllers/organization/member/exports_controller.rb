class Organization::Member::ExportsController < Organization::BaseController
  def show
    members = Member.order(created_at: :desc)
    @export = members.extend(Exportable).export(params[:type])
    render csv: @export.to_data,
      filename: @export.filename
  end
end
