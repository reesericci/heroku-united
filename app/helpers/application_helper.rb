module ApplicationHelper
  def qr_code(data)
    RQRCode::QRCode.new(data).as_svg(offset: 8, use_path: true, shape_rendering: "crispEdges", fill: :white, module_size: 2)
  end
end
