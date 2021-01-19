//
//  ThroughputBrain.swift
//  Feedback Builder
//
//  Created by UTKARSH VARMA on 2020-11-22.
//

import UIKit


struct ThroughputBrain{
    
    
    func getColor(_ speedOfSerive: Float,
                  _ sliderTag: Int)->UIColor{
        let errorColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        var displayColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
        switch sliderTag{
        case 2:
            if(speedOfSerive>130){
                displayColor = errorColor
            }
            break
        case 3:
            if(speedOfSerive>160){
                displayColor = errorColor
            }
            break
        case 4:
            if(speedOfSerive>150){
                displayColor = errorColor
                
            }
            break
        case 5:
            if(speedOfSerive>160){
                displayColor = errorColor
                
            }
            break
        case 6:
            if(speedOfSerive>170){
                displayColor = errorColor
                
            }
            break
            
        default:
            displayColor = errorColor
            
        }
        return displayColor
        
    }
    
    //This Function heps to trim the string to one decimal place for the ease of display
    
    func trimmTimer(_ speedOfService:Float)->String{
        return String(format: "%.1f", speedOfService)
    }
    
    
     func restoreState(_ shiftInfo:Throughput,timeData:[UILabel])->[UILabel]{
        var number = 0
        for _ in shiftInfo.dayPartTimer{
         
            if shiftInfo.dayPartTimer[number] != 0{
                switch (number+2){
                case 2:
                    timeData[number].text = String(shiftInfo.dayPartTimer[number])
                    
                case 3:
                    timeData[number].text = String(shiftInfo.dayPartTimer[number])
                    
                case 4:
                    timeData[number].text = String(shiftInfo.dayPartTimer[number])
                    
                case 5:
                    timeData[number].text = String(shiftInfo.dayPartTimer[number])
                    
                case 6:
                    timeData[number].text = String(shiftInfo.dayPartTimer[number])
                    
                default:
                    timeData[number].text = "0"
                }
            }
      number = number + 1
    }
        return timeData
    }
    
}


