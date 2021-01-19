//
//  ThroughputViewController.swift
//  Feedback Builder
//
//  Created by UTKARSH VARMA on 2020-11-22.
//

import UIKit


protocol TimerWasSent{
    func getShiftTimer(todaysTimer:Throughput)
}


class ThroughputViewController: UIViewController {
    
    
    
    
    @IBOutlet var timerViews: [UILabel]!
    
    
    //This is all the outlets for the timer view above for the info on location of the scoll
    @IBOutlet weak var dp2TimerView: UILabel!
    @IBOutlet weak var dp3TimerView: UILabel!
    @IBOutlet weak var dp4TimerView: UILabel!
    @IBOutlet weak var dp5TimerView: UILabel!
    @IBOutlet weak var dp6TimerView: UILabel!
    
    var timerDelegate: TimerWasSent!
    
    var throughputBrain = ThroughputBrain()
    var timerdata = [Int](repeating: 0, count:6)
    var shiftInfo = Throughput()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timerViews = throughputBrain.restoreState(shiftInfo, timeData: timerViews)
    }
    
    
 
    
    //MARK: - Timer Sliders
    @IBAction func timerChange(_ sender: UISlider) {
        switch sender.tag{
        case 2:
            
            dp2TimerView.text = throughputBrain.trimmTimer(sender.value)
            dp2TimerView.textColor = throughputBrain.getColor(sender.value, sender.tag)
            shiftInfo.dayPartTimer[0] = Int(sender.value)
            
            break
        case 3:
            dp3TimerView.text = throughputBrain.trimmTimer(sender.value)
            dp3TimerView.textColor = throughputBrain.getColor(sender.value, sender.tag)
            shiftInfo.dayPartTimer[1] = Int(sender.value)
            break
        case 4:
            dp4TimerView.text = throughputBrain.trimmTimer(sender.value)
            dp4TimerView.textColor = throughputBrain.getColor(sender.value, sender.tag)
            shiftInfo.dayPartTimer[2] = Int(sender.value)
            break
        case 5:
            dp5TimerView.text = throughputBrain.trimmTimer(sender.value)
            dp5TimerView.textColor = throughputBrain.getColor(sender.value, sender.tag)
            shiftInfo.dayPartTimer[3] = Int(sender.value)
            break
        case 6:
            dp6TimerView.text = throughputBrain.trimmTimer(sender.value)
            dp6TimerView.textColor = throughputBrain.getColor(sender.value, sender.tag)
            shiftInfo.dayPartTimer[4] = Int(sender.value)
        default:
            exit(0)
        }
    }
    
    
    @IBAction func submitButton(_ sender: UIButton) {
      
        self.timerDelegate.getShiftTimer(todaysTimer: shiftInfo)
        navigationController?.popToRootViewController(animated: true)
        
        
    }
    
    
    
}


