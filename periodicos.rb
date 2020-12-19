require "date"
require "open-uri"

def get_date_path(date)
  return date.strftime("%Y/%m/%d")
end

# newspaper is one of: el-universal, excelsior, la-jornada, milenio, reforma
def get_image_url(newspaper, date)
  date_path = get_date_path(date)

  return "https://tar.mx/periodicos-mexico/dl/#{date_path}/#{newspaper}_t.jpg"
end

start = Date.parse("2020-01-01")
stop = Date.today

start.step(stop, 1).each do |date|
  newspaper = "milenio"
  image_url = get_image_url(newspaper, date)
  local_image_path = "./assets/#{newspaper}/#{date.to_s}.jpg"

  begin
    open(image_url) do |image|
      File.open(local_image_path, "wb") do |file|
        file.write(image.read)
      end
    end

    puts("Successsfully saved #{local_image_path}")
  rescue => e
    puts("Couldn't download file #{image_url}", e)
  end
end
