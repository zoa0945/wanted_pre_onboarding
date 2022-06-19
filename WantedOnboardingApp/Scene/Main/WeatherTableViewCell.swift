//
//  WeatherTableViewCell.swift
//  WantedOnboardingApp
//
//  Created by Mac on 2022/06/16.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var currentHumidityLabel: UILabel!
    
    func configureCell(with weather: WeatherInfo) {
        weatherImage.image = UIImage(named: weather.icon[0].id)
        cityNameLabel.text = replaceCityName(weather.cityName)
        currentTempLabel.text = makeTempToString(weather.weather.currentTemp)
        currentHumidityLabel.text = makeHumidityToString(weather.weather.humidity)
    }
    
    func makeTempToString(_ number: Float) -> String {
        return "현재온도 : " + String(Int(round(number - 273.15))) + "℃"
    }
    
    func makeHumidityToString(_ number: Float) -> String {
        return "현재습도 : " + String(Int(number)) + "%"
    }
    
    func replaceCityName(_ name: String) -> String {
        switch name {
        case "Gongju":
            return "공주"
        case "Gwangju":
            return "광주"
        case "Gumi":
            return "구미"
        case "Gunsan":
            return "군산"
        case "Daegu":
            return "대구"
        case "Mokpo":
            return "목포"
        case "Busan":
            return "부산"
        case "Seosan City":
            return "서산"
        case "Seoul":
            return "서울"
        case "Sokcho":
            return "속초"
        case "Suwon-si":
            return "수원"
        case "Suncheon":
            return "순천"
        case "Ulsan":
            return "울산"
        case "Iksan":
            return "익산"
        case "Jeonju":
            return "전주"
        case "Jeju City":
            return "제주도"
        case "Cheonan":
            return "천안"
        case "Cheongju-si":
            return "청주"
        case "Chuncheon":
            return "춘천"
        default:
            return "부산"
        }
    }
}
