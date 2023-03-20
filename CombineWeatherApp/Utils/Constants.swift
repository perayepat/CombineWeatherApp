import Foundation

struct Constants {
    
    struct URLs{
        static func weather(city: String) -> String{
            return "Https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=eae28478e34c91fb1aa982fd794df659&units=metric"
        }
        static let weather = "Https://api.openweathermap.org/data/2.5/weather?q=Durban&appid=eae28478e34c91fb1aa982fd794df659&units=metric"
    }
}
