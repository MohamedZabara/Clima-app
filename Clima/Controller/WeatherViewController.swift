//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController{
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchTextField.delegate = self
        weatherManager.delegate = self
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
    }
    
    @IBAction func currentLocationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
}

//MARK: - UITextFieldDelegate

    extension WeatherViewController:UITextFieldDelegate{
    @IBAction func searchPressed(_ sender: UIButton) {
        print(searchTextField.text!)
        searchTextField.endEditing(true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(searchTextField.text!)
        textField.endEditing(true)
        
        return true
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        }
        else{
            textField.placeholder = "Select a certain country"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // do whatever you want to do for the code
       if let city = searchTextField.text {
        weatherManager.fetchWeather(cityName: city)
        }
        
        textField.text = ""
        textField.placeholder = "Search"
    }
}
//MARK: - WeatherManagerDelegate

    extension WeatherViewController:WeatherManagerDelegate{
    func updateUI(_ weatherMnager : WeatherManager,weather:WeatherModel) {
        
        DispatchQueue.main.async {
            self.conditionImageView.image = UIImage(systemName: weather.weatherName)
            self.temperatureLabel.text = weather.temperature
            self.cityLabel.text = weather.cityName
        }
        
        
    }
    func checkError(error: Error) {
        print(error)
    }
    
}

extension WeatherViewController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let longitude = location.coordinate.longitude
            let latitude = location.coordinate.latitude
            weatherManager.fetchWeather(latitude,longitude)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

