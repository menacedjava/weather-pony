use "collections"
use "net/http"
use "json"

actor Main
  new create(env: Env) =>
    let city = "Tashkent"
    let api_key = "YOUR_API_KEY"
    let url = "http://api.openweathermap.org/data/2.5/weather?q=" + city + "&appid=" + api_key + "&units=metric"
    HTTPClient(env.root as AmbientAuth).get(url, WeatherHandler)

class WeatherHandler is HTTPHandler
  fun ref apply(response: HTTPResponse ref) =>
    try
      let body = String.from_array(response.body)
      let json = JsonDoc.parse(body)?.data as JsonObject
      let main = json.data("main") as JsonObject
      @printf[I32]("Temp: %.2f°C\n".cstring(), (main.data("temp") as JsonNumber).f64())
    else
      @printf[I32]("Xatolik\n".cstring())
    end
