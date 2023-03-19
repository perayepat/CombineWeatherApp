import UIKit
import Combine

class ViewController: UIViewController {

    @IBOutlet weak var weatherTempLabel: UILabel!
    
    /// We want to retain the instance
    private var webservice: Webservice = Webservice()
    private var cancellable: AnyCancellable? /// when we don't know about the publisher being used
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cancellable = self.webservice.fetchWeather(city: "AHOY")
            .catch{_ in Just(Weather.placeholder)}
            .map{ weather in
                if let temp = weather.temp{
                    return "\(temp) C"
                } else{
                    return "Error getting weather"
                }
            }
            .assign(to: \.text, on: self.weatherTempLabel)
    }


}

