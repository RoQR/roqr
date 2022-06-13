module IconsHelper
  def show_svg(path)
    File.open("app/assets/icons/#{path}.svg", "rb") do |file|
      raw file.read
    end
  end
end
