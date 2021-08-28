require 'uri'
require 'net/http'
require 'json'

def request (src, api_key)
    url = URI("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10&api_key=eGI2GGO79VxU8CKtjpNYJs1zgaxhsKZCNElvNSOQ")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)
    response = https.request(request)
    return JSON.parse response.read_body
end

def buid_web_page (hash)
    websetting = [
        '<!DOCTYPE html>',
        '<html lang="es">',
        '<head>',
            '<meta charset="UTF-8">',
            '<meta http-equiv="X-UA-Compatible" content="IE=edge">',
            '<meta name="viewport" content="width=device-width, initial-scale=1.0">',
            '<meta name="author" content="Cristian Vera">',
            '<meta name="description" content="Fotos de Robot Curiosity en Marte">',
            '<meta name="keywords" content="marte, espacio, robots, ciencia, science, space, mars, curiosity">',
            '<title>Mars Curiosity Photos</title>',
            '<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">',
        '</head>',
        '<body class="container bg-secondary">',
            '<ul class="container bg-dark">',
                '!li',
            '</ul>',
        '</body>',
        '</html>'
    ]

    img_array = []
    hash["photos"].each do |img_url|
      img_array.append "<li><img src='#{img_url["img_src"]}' class='container mb-1'></li>"
    end
    file = File.open("index.html", "w")
    websetting.each do |tags|
        if tags != '!li'
            file.puts(tags)
        else
            img_array.each do |li_img|
                file.puts(li_img)
            end
        end
    end
end

urlsrc = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10"
keyapi = "eGI2GGO79VxU8CKtjpNYJs1zgaxhsKZCNElvNSOQ"

req = request(urlsrc, keyapi)
buid_web_page (req)