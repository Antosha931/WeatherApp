//
//  ExtensionWVC.swift
//  WeatherApp
//
//  Created by Антон Титов on 10.02.2022.
//

import UIKit

extension WeatherViewController {
    
    func searchAlertController(completionHandler: @escaping (String) -> Void) {
        let alertController = UIAlertController(title: "Поиск города", message: "Введите название города для отображения погоды", preferredStyle: .alert)
        alertController.addTextField { _ in }
        
        let saveAction = UIAlertAction(title: "Поиск", style: .default) { action in
            let textField = alertController.textFields?.first
            guard let cityName = textField?.text else { return }
            if cityName != "" {
                let city = cityName.split(separator: " ").joined(separator: "%20")
                completionHandler(city)
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { _ in }
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
