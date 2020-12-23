//
//  WeatherData.swift
//  Feedback Builder
//
//  Created by UTKARSH VARMA on 2020-12-22.
//

import Foundation

struct WeatherData:Decodable{
    let main:Main
    let weather:[Weather]
    let name:String
}

struct Main:Decodable{
    var temp:Double
}
struct Weather:Decodable{
    var id:Int
}
