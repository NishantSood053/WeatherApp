//
//  Constants.swift
//  WeatherApp
//
//  Created by Nishant Sood on 2/22/17.
//  Copyright © 2017 Nishant Sood. All rights reserved.
//

import Foundation



let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "3ef0e3246b0feb1afef324bafafb503d"

//This will help to know if download is complete
typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)45.42\(LONGITUDE)-75.69\(APP_ID)\(API_KEY)"

let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=45.42&lon=-75.69&cnt=10&appid=3ef0e3246b0feb1afef324bafafb503d"
