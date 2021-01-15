require "date"

MONTHS_ES = {
  1 => "enero",
  2 => "febrero",
  3 => "marzo",
  4 => "abril",
  5 => "mayo",
  6 => "junio",
  7 => "julio",
  8 => "agosto",
  9 => "septiembre",
  10 => "octubre",
  11 => "noviembre",
  12 => "diciembre",
}

def get_yaml_data(date)
  month = MONTHS_ES[date.month]
  date_dashes = date.strftime("%Y-%m-%d")
  date_slashes = date.strftime("%Y/%m/%d")

  <<~DATA
    "#{date_dashes}":
      title: "dosmilveinte.mx - #{month} #{date.day}"
      description: "Las portadas de los periódicos mexicanos el #{date.day} de #{month} de #{date.year}"
      dayString: "#{date.day} de #{month}"
      prevLink: "/#{date.prev_day.strftime("%Y/%m/%d")}"
      nextLink: "/#{date.next_day.strftime("%Y/%m/%d")}"
      covers:
        - link: "https://www.eluniversal.com.mx/sites/default/files/edicion_impresa/#{date_slashes}/eu#{date.strftime("%d%m%y")}_a1-01.pdf"
          imageUrl: "/assets/images/el-universal/#{date_dashes}.jpg"
        - link: "https://www.jornada.com.mx/#{date_slashes}/portada.pdf"
          imageUrl: "/assets/images/la-jornada/#{date_dashes}.jpg"
        - link: "https://www.reforma.com/libre/online07/aplicacionei/Pagina.html?seccion=primera&fecha=#{date.strftime("%Y%m%d")}"
          imageUrl: "/assets/images/reforma/#{date_dashes}.jpg"
        - link: "https://cdn2.excelsior.com.mx/Periodico/flip-nacional/#{date.strftime("%d-%m-%Y")}/portada.pdf"
          imageUrl: "/assets/images/excelsior/#{date_dashes}.jpg"
  DATA
end

start = Date.parse("2020-01-15")
stop = Date.parse("2020-01-31")

start.step(stop, 1).each do |date|
  puts get_yaml_data(date)
end
