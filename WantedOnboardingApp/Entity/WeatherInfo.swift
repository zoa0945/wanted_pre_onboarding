//
//  WeatherInfo.swift
//  WantedOnboardingApp
//
//  Created by Mac on 2022/06/16.
//

import Foundation

struct WeatherInfo: Codable {
    let icon: [IconId]
    let weather: Info
    let cityName: String
    let wind: Wind
    
    enum CodingKeys: String, CodingKey {
        case icon = "weather"
        case weather = "main"
        case cityName = "name"
        case wind
    }
}

struct IconId: Codable {
    let description: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case description
        case id = "icon"
    }
}

struct Info: Codable {
    let currentTemp: Float
    let feelsTemp: Float
    let minTemp: Float
    let maxTemp: Float
    let humidity: Float
    let pressure: Float
    
    enum CodingKeys: String, CodingKey {
        case currentTemp = "temp"
        case feelsTemp = "feels_like"
        case minTemp = "temp_min"
        case maxTemp = "temp_max"
        case humidity, pressure
    }
}

struct Wind: Codable {
    let speed: Float
    
    enum CodingKeys: String, CodingKey {
        case speed
    }
}
