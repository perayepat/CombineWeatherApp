import Foundation

struct WeatherResponse: Codable{
    let main: Weather
}

struct Weather: Codable{
    let temp: Double?
    let humidity: Double?
    
    static var placeholder: Weather{
        return Weather(temp: nil, humidity: nil)
        /// When we provide the wrong city name 
    }
}
