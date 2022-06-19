//
//  DetailViewController.swift
//  WantedOnboardingApp
//
//  Created by Mac on 2022/06/17.
//

import UIKit

class DetailViewController: UITableViewController {
    var weather: WeatherInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = replaceCityName(weather?.cityName ?? "")
        
        tableView = UITableView(frame: tableView.frame, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DetailCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .systemBackground
        
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 300)
        let headerView = UIImageView(frame: frame)
        
        headerView.contentMode = .scaleAspectFit
        headerView.image = UIImage(named: weather?.icon[0].id ?? "")
        
        tableView.tableHeaderView = headerView
    }
}

extension DetailViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 7
        default:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "날씨 정보"
        case 1:
            return "날씨 설명"
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)
        
        cell.textLabel?.numberOfLines = 0
        cell.selectionStyle = .none
        
        let weatherInfo: [String] = [
            "현재온도 : " + makeTempToString(weather?.weather.currentTemp),
            "체감온도 : " + makeTempToString(weather?.weather.feelsTemp),
            "최고기온 : " + makeTempToString(weather?.weather.maxTemp),
            "최저기온 : " + makeTempToString(weather?.weather.minTemp),
            "기압 : " + String(Int(weather?.weather.pressure ?? 0)) + " hPa",
            "현재습도 : " + makeHumidityToString(weather?.weather.humidity),
            "풍속 : " + String(weather?.wind.speed ?? 0) + " m/s"
        ]
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = weatherInfo[indexPath.row]
            return cell
        case 1:
            cell.textLabel?.text = weather?.icon[0].description ?? ""
            return cell
        default:
            return cell
        }
    }
    
    func makeTempToString(_ number: Float?) -> String {
        return String(Int(round((number ?? 0) - 273.15))) + "℃"
    }
    
    func makeHumidityToString(_ number: Float?) -> String {
        return String(Int(number ?? 0)) + "%"
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
