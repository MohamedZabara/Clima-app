//
//  WeatherData.swift
//  Clima
//
//  Created by Mohamed Zabara on 3/5/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData : Decodable {
    let name : String
    let main:Main
    let weather:[Weather]
}

struct Main:Decodable {
    let temp : Double
}

struct Weather:Decodable {
    let id : Int
}
