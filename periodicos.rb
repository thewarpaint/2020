require "date"
require "open-uri"

def get_date_path(date)
  return date.strftime("%Y/%m/%d")
end

def get_el_universal_url(date)
  date_path = get_date_path(date)

  return "https://tar.mx/periodicos-mexico/dl/#{date_path}/el-universal_t.jpg"
end

def get_la_jornada_url(date)
  date_path = get_date_path(date)

  return "https://tar.mx/periodicos-mexico/dl/#{date_path}/la-jornada_t.jpg"
end

def get_milenio_url(date)
  date_path = get_date_path(date)

  return "https://tar.mx/periodicos-mexico/dl/#{date_path}/milenio_t.jpg"
end

def get_reforma_url(date)
  date_path = get_date_path(date)

  return "https://tar.mx/periodicos-mexico/dl/#{date_path}/reforma_t.jpg"
end

start = Date.parse("2020-01-01")
stop = Date.today

start.step(stop, 1).each do |date|
  image_url = get_milenio_url(date)
  local_image_path = "./assets/milenio/#{date.to_s}.jpg"

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
