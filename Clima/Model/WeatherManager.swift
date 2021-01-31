//
//  File.swift
//  Clima
//
//  Created by Денис Богданенко on 29.01.2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=XXX";
    
    var delegate: WeatherManagerDelegate?;
    
    func getWeather(cityName: String) {
        let url = "\(weatherURL)&q=\(cityName)";
        
//        print(url);
        
        performRequest(url);
    }
    
    func getWeather(lat latitute: Double, lon longitude: Double) {
        let url = "\(weatherURL)&lat=\(latitute)&lon=\(longitude)";
        
        performRequest(url);
    };
    
    func performRequest (_ resourceURL: String) {
        // 1. Create a URL
        
        if let url = URL(string: resourceURL) {
            
            // 2. Create a URLSession
            let session = URLSession(configuration: .default);
            
            // 3. Give session a task
            let task = session.dataTask(with: url) {data,response,error in
                if (error != nil) {
                    delegate?.didErrorHappenedWhileWeatherDataReceive(error: error!);
                    return;
                }
                
                if let safeData = data {
                    if let weather = parseJSON(data: safeData) {
                        delegate?.didWeatherDataReceived(weatherData: weather);
                    }
                }
            };
            
            // 4. Start the task
            task.resume();
        }
    }
    
    func parseJSON (data: Data) -> WeatherModel? {
        let decoder = JSONDecoder();
        
        do {
            let parsed = try decoder.decode(WeatherData.self, from: data);
            
            let weatherId = parsed.weather[0].id
            let temp = parsed.main.temp;
            let name = parsed.name;
            
            let weather = WeatherModel(conditionId: weatherId, cityName: name, temperature: temp);
            
            return weather;
        } catch {
            delegate?.didErrorHappenedWhileWeatherDataDecoding(error: error);
            
            return nil;
        }
    }
};
