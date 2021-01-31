//
//  WeatherManagerDelegate.swift
//  Clima
//
//  Created by Денис Богданенко on 30.01.2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didWeatherDataReceived (weatherData: WeatherModel)
    func didErrorHappenedWhileWeatherDataReceive (error: Error)
    func didErrorHappenedWhileWeatherDataDecoding (error: Error)
};
