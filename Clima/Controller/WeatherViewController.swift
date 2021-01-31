//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var gpsButtonView: UIButton!
    
    var weatherManager = WeatherManager();
    
    var locationManager = CLLocationManager();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // нужно для textFieldShouldReturn и других таким методов,
        // которые пришли из делегата
        searchTextField.delegate = self;
        weatherManager.delegate = self;
        locationManager.delegate = self;
        
        locationManager.requestWhenInUseAuthorization();
        getGPSLocation();
    }
    
    @IBAction func onGetGPSLocationClick(_ sender: UIButton) {
        getGPSLocation()
    }
}

//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    @IBAction func onSearchClick(_ sender: UIButton) {
        searchTextField.endEditing(true);
    }
    
    //    это тоже работает
    //    @IBAction func onPrimaryAction(_ sender: UITextField) {
    //        searchTextField.endEditing(true);
    //        print(searchTextField.text!);
    //        print("IT IS ME!")
    //    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true);
        return true;
    }
    
    // когда вызывается метод endEditing,
    // то данный метод будет вызыван и здесь можно осуществить
    // проверку поля на корректность ввода
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if (textField.text != "") {
            return true;
        } else {
            textField.placeholder = "Type something";
            return false;
        }
    }
    
    // отработает когда будет ивент о завершении редактирования
    // это скорее всего при нажатии на ретурн-кнопку либо при скрытии клавиатуры ввода
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            weatherManager.getWeather(cityName: city);
        }
        
        
        searchTextField.text = "";
    }
    
}

//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    func didWeatherDataReceived(weatherData: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weatherData.temperatureString;
            self.conditionImageView.image = UIImage(systemName: weatherData.conditionName);
            self.cityLabel.text = weatherData.cityName;
        }
    }
    
    func didErrorHappenedWhileWeatherDataReceive (error: Error) {
        print(error.localizedDescription);
    }
    
    func didErrorHappenedWhileWeatherDataDecoding(error: Error) {
        print(error.localizedDescription);
    }
}

//MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    func getGPSLocation () {
        // starts animation
        self.gpsButtonView.animateRotation(duration: 1.0, repeat: true, completion: nil);
        // request location
        locationManager.requestLocation();
    };
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            getGPSLocation();
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // if some animation is taking place - stop it
        gpsButtonView.transform = gpsButtonView.transform.rotated(by: CGFloat(Double.pi*2))
        gpsButtonView.layer.removeAllAnimations();
        
        // get location and display it
        if let location = locations.last {
            locationManager.stopUpdatingLocation();
            let lat = location.coordinate.latitude;
            let lon = location.coordinate.longitude;
            print(lat);
            print(lon);
            weatherManager.getWeather(lat: lat, lon: lon)
        }
    }
};
