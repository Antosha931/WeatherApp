//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Антон Титов on 08.02.2022.
//

import UIKit

final class WeatherViewController: UIViewController {
    
    // MARK: - Private properties
    
    private var backView: UIImageView = {
        let view = UIImageView()
        view.isUserInteractionEnabled = true
        view.image = UIImage(named: "Afternoon")
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var nameCityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Marker Felt", size: 50)
        label.textColor = .white
        label.layer.shadowColor = UIColor.darkGray.cgColor
        label.layer.shadowOffset = CGSize(width: 5, height: 5)
        label.layer.shadowRadius = 5
        label.layer.shadowOpacity = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var emodjiWeathersImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private var weatherTemperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Marker Felt", size: 30)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var feelingTemperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Marker Felt", size: 30)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var searchCityButton: UIButton = {
        let button = UIButton()
        button.setTitle("Искать город", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = UIFont(name: "Marker Felt", size: 20)
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.red.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let networkManager = NetworkManager()
    private var defaultCity = "Moscow"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraints()
        setupUI()
        searchCityWeather(city: defaultCity)
    }
    
    //MARK: - Private methods
    
    private func setupConstraints() {
        view.addSubview(backView)
        
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: view.topAnchor),
            backView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        backView.addSubview(nameCityLabel)
        
        NSLayoutConstraint.activate([
            nameCityLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: 100),
            nameCityLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -50),
            nameCityLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 50)
        ])
        
        backView.addSubview(emodjiWeathersImage)
        
        NSLayoutConstraint.activate([
            emodjiWeathersImage.topAnchor.constraint(equalTo: nameCityLabel.bottomAnchor, constant: 50),
            emodjiWeathersImage.centerXAnchor.constraint(equalTo: nameCityLabel.centerXAnchor),
            emodjiWeathersImage.widthAnchor.constraint(equalToConstant: 100),
            emodjiWeathersImage.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        backView.addSubview(weatherTemperatureLabel)
        
        NSLayoutConstraint.activate([
            weatherTemperatureLabel.topAnchor.constraint(equalTo: emodjiWeathersImage.bottomAnchor, constant: 50),
            weatherTemperatureLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -50),
            weatherTemperatureLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 50)
        ])
        
        backView.addSubview(feelingTemperatureLabel)
        
        NSLayoutConstraint.activate([
            feelingTemperatureLabel.topAnchor.constraint(equalTo: weatherTemperatureLabel.topAnchor, constant: 50),
            feelingTemperatureLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -50),
            feelingTemperatureLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 50)
        ])
        
        backView.addSubview(searchCityButton)
        
        NSLayoutConstraint.activate([
            searchCityButton.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -100),
            searchCityButton.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -50),
            searchCityButton.widthAnchor.constraint(equalToConstant: 200),
            searchCityButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupUI() {
        searchCityButton.addTarget(self, action: #selector(citySearchButtonActivity), for: .touchUpInside)
    }
    
    private func setupCityWeather(currentWeather: CurrentWeather) {
        DispatchQueue.main.async {
            switch currentWeather.id {
            case 200...531: self.emodjiWeathersImage.tintColor = .systemBlue
            case 600...622: self.emodjiWeathersImage.tintColor = .lightGray
            case 701...781: self.emodjiWeathersImage.tintColor = .darkGray
            case 800: self.emodjiWeathersImage.tintColor = .yellow
            case 801...804: self.emodjiWeathersImage.tintColor = .gray
            default: self.emodjiWeathersImage.tintColor = .red
            }
        }
        
        DispatchQueue.main.async {
            self.nameCityLabel.text = currentWeather.nameCity
            self.emodjiWeathersImage.image = UIImage(systemName: currentWeather.systemIconNameString)
            self.weatherTemperatureLabel.text = currentWeather.temperatureString
            self.feelingTemperatureLabel.text = currentWeather.feelsLikeTemperatureString
        }
    }
    
    private func searchCityWeather(city: String) {
        networkManager.jsonDataProcessing(forCity: city) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let currentWeather):
                self.setupCityWeather(currentWeather: currentWeather)
            case .failure(let errror):
                print(errror)
            }
        }
    }
    
    @objc private func citySearchButtonActivity() {
        searchAlertController { city in
            self.networkManager.jsonDataProcessing(forCity: city) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let currentWeather):
                    self.setupCityWeather(currentWeather: currentWeather)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

