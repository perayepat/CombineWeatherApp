import UIKit
import Combine

class ViewController: UIViewController {
    
    @IBOutlet weak var weatherTempLabel: UILabel!
    @IBOutlet weak var cityTextField: UITextField!
    
    /// We want to retain the instance
    private var webservice: Webservice = Webservice()
    private var cancellable: AnyCancellable? /// when we don't know about the publisher being used
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPublihsers()
        
    }
    private func setupPublihsers(){
        ///we are going to use this publisher to notify us when we can update and make changes to the main app
        ///Debounce allows you to wait for a amount of time and then do somthing
        ///For assigning and updating multiple items on the screen the sink is the best option
        ///`addPercentEncoding` for cities that have  a space in between them
        let publisher  = NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification,object: self.cityTextField)
        
        self.cancellable = publisher.compactMap{
            ($0.object as! UITextField).text?
                .addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        }
        .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
        .flatMap { city in
            return self.webservice.fetchWeather(city: city)
                .catch{_ in Just(Weather.placeholder)}
                .map{$0}
        }
        .sink{
            self.weatherTempLabel.text = "\($0.temp ?? 0.0) 𝇋"
        }
    }
}
    
    /*
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
     */
