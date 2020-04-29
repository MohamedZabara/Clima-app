//
//  WeatherManager.swift
//  Clima
//
//  Created by Mohamed Zabara on 3/5/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func updateUI(_ self:WeatherManager,weather:WeatherModel)
    func checkError(error:Error)
}

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=e72ca729af228beabd5d20e3b7749713&units=metric"
    var delegate : WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    func fetchWeather(_ lat: CLLocationDegrees,_ lon: CLLocationDegrees){
        
        let urlString = "\(weatherURL)&lat=\(lat)&lon=\(lon)"
        print(urlString)
        performRequest(with: urlString)
    }
    
    //    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
    //        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
    //        performRequest(with: urlString)
    //    }
    
    func performRequest(with urlString: String) {
        
        //1. create URL
        if let url = URL(string: urlString) {
            //2.Create URL session
            let session = URLSession(configuration: .default)
            //3.Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
//                    print(error!)
                    self.delegate?.checkError(error: error!)
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.updateUI(self,weather:weather)
                        
                    }
                }
            }
            //4.start the task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data)->WeatherModel?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            // let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            // return weather
            let weather = WeatherModel(cityName: name, weatherId: id, temp: temp)
            
            
            print(weather.weatherName)
            print(weather.temperature)
            return weather
         
        } catch {
//            print(error)
            self.delegate?.checkError(error: error)
            return nil
        }
    }
    
}

