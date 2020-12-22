//
//  ViewController.swift
//  Feedback Builder
//
//  Created by UTKARSH VARMA on 2020-11-22.
//

import UIKit
import MessageUI
import AudioToolbox
import CoreData

let appVersion = "2.1"

class NavigationViewController: UIViewController {
    
    
    var emailBuilder = EmailBuilder()
    let salesDelegate = SalesLaborViewController()
    var salesLabour = SalesLabour()
   var emailBrain = EmailBrain()
    
    @IBOutlet var buttonDesign: [UIButton]!
    
    var currentTimerData = Throughput()
    var currentComment  = Comment()
    
    var throughput:Throughput?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for button in buttonDesign {
            
            button.layer.cornerRadius = button.frame.size.height/2;
            button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
            
        }
        
        
    }
    //MARK: -Button Actions
    
    @IBAction func getThroughput(_ sender: UIButton) {
        let throughputVC = storyboard?.instantiateViewController(identifier:"ThroughputViewController") as! ThroughputViewController
        throughputVC.timerDelegate = self
        
        throughputVC.shiftInfo = currentTimerData
        throughputVC.modalPresentationStyle = .fullScreen
        present(throughputVC, animated: true, completion: nil)
    }
    
    
    
    @IBAction func getComment(_ sender: UIButton) {
        
        let commentVC = storyboard?.instantiateViewController(identifier:"CommentViewController") as! CommentViewController
        commentVC.commentDelegate = self
        commentVC.userComment = currentComment
        commentVC.modalPresentationStyle = .fullScreen
        present(commentVC, animated: true, completion: nil)
    }
    
    
    @IBAction func getSalesLabour(_ sender: UIButton) {
        let salesVC = storyboard?.instantiateViewController(identifier: "SalesLaborViewController")as!SalesLaborViewController
        salesVC.salesDelegate = self
        salesVC.shiftSales = salesLabour
        salesVC.modalPresentationStyle = .fullScreen
        present(salesVC, animated: true, completion: nil)
    }
    
    
    @IBAction func sendButton(_ sender: UIButton) {
        

        let email = emailBuilder.FinalEmailBuilder(TimerData: currentTimerData, salesData: salesLabour, commentData: currentComment.commentText)
        print(email)//Use this to see output in VM
        showMailComposer(emailBody: email)//Use this to see output in actual device
    }
    
    
    @IBAction func settings(_ sender: Any) {
        
        let settingsVC = storyboard?.instantiateViewController(identifier: "SettingsViewController")as!SettingsViewController
        present(settingsVC, animated: true, completion: nil)
        
    }
    
    
    
    
    
    //MARK: -Present Mail Composer
    func showMailComposer(emailBody:String){
        guard MFMailComposeViewController.canSendMail() else {
            let alert = emailBrain.emailAlert("Error", "Please setup your email in the mail app to send mails, thank You")
            self.present(alert, animated: true, completion: nil)
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            //Error In Case User Cant send Error
            return
            
        }
        let formatter : DateFormatter = DateFormatter()
        formatter.dateFormat = "d/M/yy"
        let today : String = formatter.string(from:   NSDate.init(timeIntervalSinceNow: 0) as Date)
        
        let mailBody = emailBody
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(emailBrain.getEmailInfo())
        composer.setSubject("Daily Tracking Feedback- \(today)")
        composer.setMessageBody(mailBody, isHTML: false)
        
        present(composer, animated: true)
        
    
    }
    
    
    
}

//MARK: -Local Delegates
extension NavigationViewController:TimerWasSent{
    func getShiftTimer(todaysTimer: Throughput) {
        currentTimerData.dayPartTimer = todaysTimer.dayPartTimer
    }
    
    
}

extension NavigationViewController:commentDataDelegate{
    func thereIsComment(userComment: Comment) {
        currentComment.commentText = userComment.commentText
    }
    
    
}

extension NavigationViewController:SalesLaborDelegate{
    func didGetSales(salesToday: SalesLabour) {
        salesLabour = salesToday
    }
    
    
    
}



//MARK: -Mail Composer

extension NavigationViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        if let _ = error {
            //Show error alert
            controller.dismiss(animated: true)
            return
        }
        var alert:UIAlertController = emailBrain.emailAlert("Error", "Unspecified Error Occoured")
        switch result {
        case .cancelled:
            alert = emailBrain.emailAlert("Cancelled", "Action Cancelled")
        case .failed:
            alert = emailBrain.emailAlert("Email Not Sent", "The email was not sent please check the connection and try again")
        case .saved:
            alert = emailBrain.emailAlert("Saved", "The email has been saved and can be accessed from the draft section of the mail app")
        case .sent:
            alert = emailBrain.emailAlert("Success", "Email Sent Successfully")
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
        @unknown default:
            break
        }
        
          
        controller.dismiss(animated: true)
        present(alert, animated: true, completion: nil)
        
    }
}

