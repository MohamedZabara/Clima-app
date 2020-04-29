//
//  WeatherModel.swift
//  Clima
//
//  Created by Mohamed Zabara on 3/9/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let cityName : String
    let weatherId : Int
    let temp : Double
    
    var weatherName : String{
        switch weatherId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
    var temperature : String{
        return String(format: "%.1f", temp)
    }
    
}
