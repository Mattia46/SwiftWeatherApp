//
//  WeatherService.swift
//  RespApiCall-weather
//
//  Created by Mattia on 17/12/2015.
//  Copyright © 2015 Mattia. All rights reserved.
//

import Foundation

protocol WeatherServiceDelegate {
    
    func setWeather(weather: Weather)
    
}

class WeatherService {
    
    var delegate: WeatherServiceDelegate?
    
    
    func getWeather(city: String) {
        
        let cityReformat = city.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet()) // in qst modo tolgo gli eventuali spazi nella città
        
        let path = "http://api.openweathermap.org/data/2.5/weather?q=\(cityReformat!)&appid=2de143494c0b295cca9337e1e96b00e0"
        let url = NSURL(string: path)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            print(">>>>>\(data)")
            print(response)
            
            
            
            // After SwiftyJSON
            
            let json = JSON(data: data!)


            let lon = json ["coord"]["lon"].double
            let lat = json["coord"]["lat"].double
            let temp = json["main"]["temp"].int
            let name = json["name"].string
            let description = json["weather"][0]["description"].string
            let icon = json["weather"][0]["icon"].string
            
            let weather = Weather(cityName: name!, temp: temp!, description: description!, icon: icon!)
            
            if self.delegate != nil {
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.delegate?.setWeather(weather)
                })
                
            }
            
            print("Lat: \(lat!) lon: \(lon!) temp \(temp!) city: \(name)")

            // end of SwiftyJSON
        }
        task.resume()
        
        
//        print("Weather Service city: \(city)")
//        
//        let weather = Weather(cityName: city, temp: 237, description: "A nice day")
//        
//        if delegate != nil {
//           delegate?.setWeather(weather)
//        }
        
    }
    
}