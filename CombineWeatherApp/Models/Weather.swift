import Foundation

struct WeatherResponse: Codable{
    let main: Weather
}

struct Weather: Codable{
    let temp: Double?
    let humidity: Double?
    
}
