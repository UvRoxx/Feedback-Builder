//
//  WeatherManager.swift
//  Feedback Builder
//
//  Created by UTKARSH VARMA on 2020-12-22.
//

import Foundation

protocol WeatherDelegate {
    func getWeatherInfo(weatherTemp:String,weatherCode:String)
}
class WeatherManager{
    var weatherDelegate : WeatherDelegate?
    
    func getWeatherData(){
        let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?appid=31e9e2b1afab0f1e3e9345373814f9e9&units=metric&q=Montreal")
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: weatherURL!) { (data, response, error) in
            if let currentError =  error{
                print(currentError)
            }else{
                if let safeData = data{
                    if let FinalData = WeatherJSON(safeData){
                        self.weatherDelegate?.getWeatherInfo(weatherTemp: String(FinalData.main.temp), weatherCode: getWeatherIconCode(FinalData.weather[0].id))
                    }
                    
                }
            }
        }
        task.resume()
        
    }
}

func WeatherJSON(_ weatherData:Data)->WeatherData?{
   
    do{
        let recievedData = try JSONDecoder().decode(WeatherData.self, from: weatherData)
        print("The weather Temp Is")
      return recievedData
        
    }catch{
        print(error)
        return nil
    }

    
}

func getWeatherIconCode(_ conditionId:Int)->String{
    
    var conditionName:String {
        switch conditionId{
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "clous.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    
    }
    return conditionName
}
