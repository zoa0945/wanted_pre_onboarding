//
//  MainViewController.swift
//  WantedOnboardingApp
//
//  Created by Mac on 2022/06/16.
//

import UIKit

class MainViewController: UIViewController {
    let cityName: [String] = ["Gongju", "Gwangju", "Gumi", "Gunsan", "Daegu", "Mokpo", "Busan", "Seosan", "Seoul", "Sokcho", "Suwon", "Suncheon", "Ulsan", "Iksan", "Jeonju", "Jeju", "Cheonan", "Cheongju","Chuncheon"]
    var weatherList: [WeatherInfo] = []
    
    @IBOutlet weak var weatherTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherTableView.dataSource = self
        weatherTableView.delegate = self
        weatherTableView.rowHeight = 124
        
        for i in cityName {
            searchAPI(cityName: i)
        }
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as? WeatherTableViewCell else { return UITableViewCell() }
        
        let weather = weatherList[indexPath.row]
        cell.configureCell(with: weather)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectWeather = weatherList[indexPath.row]
        let detailViewController = DetailViewController()
        
        detailViewController.weather = selectWeather
        
        self.show(detailViewController, sender: nil)
    }
}

extension MainViewController {
    func searchAPI(cityName: String) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=5c756784368aff43ab330c87a2546be1") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard error == nil,
                  let data = data,
                  let self = self,
                  let response = response as? HTTPURLResponse,
                  let weathers = try? JSONDecoder().decode(WeatherInfo.self, from: data) else {
                      print("ERROR: URLSession dataTask \(error?.localizedDescription ?? "")")
                      return
                  }
            
            switch response.statusCode {
            case (200..<300):
                self.weatherList += [weathers]
                
                DispatchQueue.main.async {
                    self.weatherTableView.reloadData()
                }
            case (400..<500):
                print("""
                    ERROR: Client ERROR \(response.statusCode)
                    Response: \(response)
                """)
            case (500..<600):
                print("""
                    ERROR: Server ERROR \(response.statusCode)
                    Response: \(response)
                """)
            default:
                print("""
                    ERROR: ERROR \(response.statusCode)
                    Response: \(response)
                """)
            }
        }
        dataTask.resume()
    }
}
