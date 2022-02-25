//
//  Singletone.swift
//  WeatherApp
//
//  Created by Антон Титов on 24.02.2022.
//

import Foundation

class SomeSingletone {
    
    let userAPIKey: String = "713140a516dfd070ca8cc709e289114d"
    
    static let shared = SomeSingletone()
    
    private init() {}
}
