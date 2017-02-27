//
//  Forecast.swift
//  WeatherApp
//
//  Created by Nishant Sood on 2/27/17.
//  Copyright © 2017 Nishant Sood. All rights reserved.
//

import UIKit
import Alamofire

class Forecast{

    var _date: String!
    var _weatherType: String!
    var _highTemp: String!
    var _lowTemp: String!
    
    var date: String{
    
        if _date == nil{
        
            _date = ""
        }
        return _date
    }
    
    var weatherType: String{
    
        if _weatherType == nil{
        
            _weatherType = ""
        }
        
        return _weatherType
    }
    
    var highTemp: String {
    
        if _highTemp == nil{
            _highTemp = ""
        }
        return _highTemp
    }
    
    var lowTemp: String{
    
        if _lowTemp == nil{
        
            _lowTemp = ""
        }
        return _lowTemp
    }
    
    init(weatherDict: Dictionary<String, AnyObject>) {
        
        if let temp = weatherDict["temp"] as? Dictionary<String, AnyObject>{
        
            if let min  = temp["min"] as? Double {
             self._lowTemp = "\(self.kelvinToCelcius(temp: min))"
            }
            
            if let max = temp["max"] as? Double{
                self._highTemp = "\(self.kelvinToCelcius(temp: max))"
            }
            
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>]{
        
            if let type = weather[0]["main"] as? String{
            
                self._weatherType = type
            }
        }
        
        if let date = weatherDict["dt"] as? Double{
        
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE" //Full day of the week
            dateFormatter.timeStyle = .none
            self._date = unixConvertedDate.dayOfTheWeek()
        }
        
    }
    
    //Function to convert temperature from kelvin to celcius
    func kelvinToCelcius(temp : Double) -> Double{
        
        let result = temp - 273.15
        
        return result
    }

}

extension Date{


    func dayOfTheWeek() -> String{
    
        let dateFormatter = DateFormatter()
        
        //Code for getting the full name of the week
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter.string(from: self)
        
    }
}



