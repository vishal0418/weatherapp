//
//  ViewController.swift
//  WeatherApp
//
//  Created by Vishal Patel on 26/10/23.
//

import UIKit
import CoreLocation
import MapKit


class DashboardVC: UIViewController {

    // Label
    @IBOutlet weak var lblCityName: UILabel!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblMinTemp: UILabel!
    @IBOutlet weak var lblMaxTemp: UILabel!
    @IBOutlet weak var lblPressure: UILabel!
    @IBOutlet weak var lblWindSpeed: UILabel!
    
    // Other
    let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeGetRequest("Ahmedabad")
    }
    
    //MARK: - Private Helper Method
    private func setData(_ data: Weather) {
        
        lblCityName.text = data.name
        lblTemp.text = "\(data.main.temp)"
        lblMinTemp.text = "\(data.main.tempMin)"
        lblMaxTemp.text = "\(data.main.tempMax)"
        lblPressure.text = "\(data.main.pressure)"
        lblWindSpeed.text = "\(data.wind.speed)"
    }
}

//MARK: - Action Method
extension DashboardVC {
    
    @IBAction func didTapSelectCity(_ sender: UIButton) {
        self.view.endEditing(true)
        
        if let VC = storyboard?.instantiateViewController(withIdentifier: "SelectCityVC") as? SelectCityVC {
            VC.onComplete = { [weak self] cityName in
                self?.makeGetRequest(cityName)
            }
            navigationController?.pushViewController(VC, animated: true)
        }
    }
}

//MARK: - API Call
extension DashboardVC {
    
    func makeGetRequest(_ cityName: String) {
        // Create a URL
        
        let apiURL = baseURL + "?q=\(cityName)&appid=\(AppDelegate.APIKEY)"
        
        if let url = URL(string: apiURL) {
            
            // Create a URLSession configuration
            let config = URLSessionConfiguration.default
            
            // Create a URLSession
            let session = URLSession(configuration: config)
            
            // Create a data task
            let task = session.dataTask(with: url) { [weak self] (data, response, error) in
                // Check for errors
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                // Check for response status code
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode != 200 {
                        print("HTTP Status Code: \(httpResponse.statusCode)")
                        return
                    }
                }
                
                // Check if data is available
                if let data = data {
                    // Convert data to a String
                    do {
                        let weatherData = try JSONDecoder().decode(Weather.self, from: data)
                        DispatchQueue.main.async {
                            self?.setData(weatherData)
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                }
            }
            
            // Start the data task
            task.resume()
        }
    }
}
