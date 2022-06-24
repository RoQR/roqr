require 'victor'

class QrGenerator
  def self.gen(link, fill: '#fff', color: '#000', border: 4)
    qr = RQRCode::QRCode.new(link)
    scale = 11
    len = qr.modules.size
    @svg = Victor::SVG.new class: 'x', width: (border * 2 + len) * scale, height: (border * 2 + len) * scale,
                           style: { background: fill }
    @svg.build do
      qr.modules.each_with_index do |row, i|
        row.each_with_index do |mod, j|
          rect x: j * scale + border * scale, y: i * scale + border * scale, height: scale, width: scale,
               fill: mod ? color : fill, shape_rendering: 'crispEdges'
        end
      end
    end
    @svg.render
  end
end
