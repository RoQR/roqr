require 'victor'

class QrGenerator
  def self.gen(link, fill: '#fff', color: '#000', position_border: '#000', position_core: '#000', quiet_zone: 4)
    qr = RQRCode::QRCode.new(link)
    scale = 11
    len = qr.modules.size
    @svg = Victor::SVG.new class: 'x', width: (quiet_zone * 2 + len) * scale, height: (quiet_zone * 2 + len) * scale,
                           style: { background: fill }
    @svg.build do
      qr.modules.each_with_index do |row, i|
        row.each_with_index do |mod, j|
          module_type = if (j == 0 || j == 6 || j == (len - 7) || j == len - 1) && 0 <= i && i <= 6
                          'position_border'
                        elsif [0, 6].include?(j) && (len - 7) <= i && (i <= len - 1)
                          'position_border'
                        elsif (i == 0 || i == 6 || i == (len - 7) || i == len - 1) && j.between?(0, 6)
                          'position_border'
                        elsif [0, 6].include?(i) && (len - 7) <= j && (j <= len - 1)
                          'position_border'
                        elsif i.between?(2, 4) && j.between?(2, 4)
                          # top left
                          'position_core'
                        elsif i.between?(len - 5, len - 3) && j.between?(2, 4)
                          # bottom left
                          'position_core'
                        elsif i.between?(2, 4) && j.between?(len - 5, len - 3)
                          # top right
                          'position_core'
                        elsif mod
                          'dark'
                        else
                          'light'
                        end
          fill_color = case module_type
                       when 'position_border'
                         position_border
                       when 'position_core'
                         position_core
                       when 'dark'
                         color
                       when 'light'
                         fill
                       end
          rect x: j * scale + quiet_zone * scale, y: i * scale + quiet_zone * scale, height: scale, width: scale,
               fill: fill_color, shape_rendering: 'crispEdges'
        end
      end
    end
    @svg.render
  end
end
