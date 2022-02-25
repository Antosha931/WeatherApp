//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Антон Титов on 08.02.2022.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var nameCityLabel: UILabel!
    @IBOutlet weak var emodjiWeathersImage: UIImageView!
    @IBOutlet weak var weatherTemperatureLabel: UILabel!
    @IBOutlet weak var feelingTemperatureLabel: UILabel!
    
    private let networkManager = NetworkManager()
    private var defaultCity = "Moscow"
    
    private func setupUI(currentWeather: CurrentWeather) {
        DispatchQueue.main.async {
            self.nameCityLabel.text = currentWeather.nameCity
            self.emodjiWeathersImage.image = UIImage(systemName: currentWeather.systemIconNameString)
            self.weatherTemperatureLabel.text = currentWeather.temperatureString
            self.feelingTemperatureLabel.text = currentWeather.feelsLikeTemperatureString
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager.jsonDataProcessing(forCity: defaultCity) { [weak self] result in
            switch result {
            case .success(let currentWeather):
                self?.setupUI(currentWeather: currentWeather)
            case .failure(let errror):
                print(errror)
            }
        }
    }
    
    @IBAction func citySearchButton(_ sender: Any) {
        searchAlertController { city in
            self.networkManager.jsonDataProcessing(forCity: city) { [weak self] result in
                switch result {
                case .success(let currentWeather):
                    self?.setupUI(currentWeather: currentWeather)
                case .failure(let errror):
                    print(errror)
                }
            }
        }
    }
}

