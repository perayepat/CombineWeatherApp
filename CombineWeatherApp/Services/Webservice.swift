import Foundation
import Combine

class Webservice{
    
    func fetchWeather(city:String) -> AnyPublisher<Weather,Error> {
        guard let url = URL(string: Constants.URLs.weather(city: city)) else {
            fatalError("Invalid URL")
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map{$0.data}
            .decode(type: WeatherResponse.self, decoder: JSONDecoder()) /// this takes into consideration what were taking in from the map
            .map{$0.main}
            .receive(on: RunLoop.main) /// Reviece on main thread so the UI can cahgen
            .eraseToAnyPublisher() /// Can be used by any publisher
    }
}
