class QrController < ApplicationController
  layout 'empty'

  def new
    @svg = QrGenerator.gen(background: '#fff')
  end
end

class QrGenerator
  def self.gen(background:)
    qr = RQRCode::QRCode.new('https://google.com')
    scale = 10
    len = qr.modules.size
    @svg = Victor::SVG.new class: 'x', width: len*scale, height: len*scale, style: { background: background }
    @svg.build do 
      qr.modules.each_with_index {|row, i|
        row.each_with_index  {|col, j| 
          rect x: j*scale, y: i*scale, height: scale, width: scale, style: {transform: "rotate(45deg)"}, fill: col ? '#000' : background 
        }
      }
    end
    @svg.save 'test'
    @svg
  end
end
