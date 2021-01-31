//
//  WeatherData.swift
//  Clima
//
//  Created by Денис Богданенко on 30.01.2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let timezone: Int
    let cod: Int
    let id: Int
    let dt: Int
    let sys: WeatherSys
    let coord: WeatherCoord
    let weather: [WeatherWeather]
    let base: String
    let main: WeatherMain
    let visibility: Int
    let wind: WeatherWind
}

struct WeatherCoord: Codable {
    let lon: Double
    let lat: Double
};

struct WeatherWeather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct WeatherMain: Codable {
    var temp: Double
    var feels_like: Double
    var temp_min: Double
    var temp_max: Double
    var pressure: Double
    var humidity: Double
}

struct WeatherWind: Codable {
    let speed: Double
    let deg: Double
};

struct WeatherSys: Codable {
    let sunrise: Int
    let sunset: Int
    let country: String
    let type: Int
    let id: Int
}
