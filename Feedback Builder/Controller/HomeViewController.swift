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
        
    }
    

   

}

extension HomeViewController:GetQuoteDelegate{
    func todaysQuote(quote: String) {
        DispatchQueue.main.async {
            self.quoteOfTheDayContent.text = quote
        }
       
    }
    
    
    
    
}

extension HomeViewController:WeatherDelegate{

    
    func getWeatherInfo(weatherTemp: String, weatherCode: String,locationName:String) {
        DispatchQueue.main.async {
            self.weatherTemp.text = "\(weatherTemp)°C"
            self.weatherImage.image =  UIImage(systemName:weatherCode)?.withRenderingMode(.alwaysOriginal)
            self.locationName.text = locationName
        }
    }
    

    
    
}
