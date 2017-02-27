//
//  WeatherVC.swift
//  WeatherApp
//
//  Created by Nishant Sood on 2/22/17.
//  Copyright © 2017 Nishant Sood. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherType: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts = [Forecast]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //initialize class variables
        currentWeather = CurrentWeather()
        //forecast = Forecast()
        
        tableView.delegate = self
        tableView.dataSource = self
        currentWeather.downloadWeatherDetails {
            self.downloadForecastData{
                //Setup UI to load the data
                self.updateWeatherUI()
            }
            
        }
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete){
    
        let forecastUrl = URL(string: FORECAST_URL)!
        
        Alamofire.request(forecastUrl).responseJSON { response in
            
            let result =  response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject>{
            
                if let list = dict["list"] as? [Dictionary<String, AnyObject>]{
                
                    for obj in list{
                    
                        // Add the data in a dictionary
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                    }
                }
            }
            completed()
            
        }
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    //Returns the cell at the row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath)
        
        
        return cell
    }
    
    func updateWeatherUI(){
    
        dateLabel.text = currentWeather.date
        tempLabel.text = "\(currentWeather.currentTemp)°C"
        locationLabel.text = currentWeather.cityName
        currentWeatherType.text = currentWeather.weatherType
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
    }

}

