//
//  HomeViewController.swift
//  Feedback Builder
//
//  Created by UTKARSH VARMA on 2020-12-21.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherTemp: UILabel!
    @IBOutlet weak var quoteOfTheDayContent: UILabel!
    @IBOutlet weak var todaysDate: UILabel!
    @IBOutlet weak var greetingsText: UILabel!
    @IBOutlet weak var locationName: UILabel!
    let defaults = UserDefaults.standard
    let quoteManager = QuoteManager()
    let dateAndTime = DateAndTime()
    let weatherManager = WeatherManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        todaysDate.text = dateAndTime.getDisplayDate()
        quoteManager.getQuoteDelegate = self
        quoteManager.getDailyQuotes()
        weatherManager.weatherDelegate = self
        weatherManager.getWeatherData()
        greetingsText.text = dateAndTime.getGreeting()
        
        if let temp = defaults.value(forKey: "savedWeatherTemp"), let weatherCode = defaults.value(forKey: "savedWeatherCode"),let quote = defaults.value(forKey: "quoteData"){
            weatherTemp.text = temp as? String
            weatherImage.image = UIImage(systemName: (weatherCode as! String))?.withRenderingMode(.alwaysOriginal)
            quoteOfTheDayContent.text =  quote as? String
            
            
        }
        
    }
    

   

}

extension HomeViewController:GetQuoteDelegate{
    func todaysQuote(quote: String) {
        DispatchQueue.main.async {
            self.quoteOfTheDayContent.text = quote
            self.defaults.set(quote, forKey: "quoteData")
        }
       
    }
    
    
    
    
}

extension HomeViewController:WeatherDelegate{

    
    func getWeatherInfo(weatherTemp: String, weatherCode: String,locationName:String) {
        DispatchQueue.main.async {
            self.weatherTemp.text = "\(weatherTemp)°C"
            self.defaults.set(weatherTemp, forKey: "savedWeatherTemp")
            self.defaults.set(weatherCode, forKey: "savedWeatherCode")
            self.weatherImage.image =  UIImage(systemName:weatherCode)?.withRenderingMode(.alwaysOriginal)
            self.locationName.text = locationName
        }
    }
    

    
    
}
