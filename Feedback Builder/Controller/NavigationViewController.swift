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

let appVersion = "2.5"

class NavigationViewController: UIViewController {
   
    let context = ((UIApplication.shared.delegate)as!AppDelegate).persistentContainer.viewContext
    let defaults = UserDefaults.standard
    
    var emailBuilder = EmailBuilder()
    let salesDelegate = SalesLaborViewController()
    var salesLabour = SalesLabour()
    var emailBrain = EmailBrain()
    
    var currentTimerData = Throughput()
    var currentComment  = Comment()
    var throughput:Throughput?
    
    @IBOutlet var buttonDesign: [UIButton]!
    
    
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        for button in buttonDesign {
           
            button.layer.cornerRadius = button.frame.size.height/2;
            button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
            
        }
        
        
    }
    //MARK: -Button Actions
    
    
    @IBAction func buttonClicked(_ sender:UIButton){
        switch sender.tag{
        case 1:let throughputVC = storyboard?.instantiateViewController(identifier:VC.throughput.rawValue) as! ThroughputViewController
            
            throughputVC.timerDelegate = self
            
            throughputVC.shiftInfo = currentTimerData
            throughputVC.modalPresentationStyle = .fullScreen
            present(throughputVC, animated: true, completion: nil)
            break
       
        case 2: let salesVC = storyboard?.instantiateViewController(identifier: VC.salesLabour.rawValue)as!SalesLaborViewController
            
            salesVC.salesDelegate = self
            
            salesVC.shiftSales = salesLabour
            salesVC.modalPresentationStyle = .fullScreen
            present(salesVC, animated: true, completion: nil)
       
        case 3: let commentVC = storyboard?.instantiateViewController(identifier:VC.comment.rawValue) as! CommentViewController
            
            commentVC.commentDelegate = self
            
            commentVC.userComment = currentComment
            commentVC.modalPresentationStyle = .fullScreen
            present(commentVC, animated: true, completion: nil)
            
        case 4: let email = emailBuilder.FinalEmailBuilder(TimerData: currentTimerData, salesData: salesLabour, commentData: currentComment.commentText)
            print(email)//Use this to see output in VM
            showMailComposer(emailBody: email)//Use this to see output in actual device
        
        default:
            break
        }
        
    }
    
    
    

    //MARK: -Present Mail Composer
    func showMailComposer(emailBody:String){
        guard MFMailComposeViewController.canSendMail() else {
            let alert = emailBrain.emailAlert("Error", EM.mailNotSet.rawValue)
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
        composer.setToRecipients(getEmails())
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
        var alert:UIAlertController = emailBrain.emailAlert("Error", EM.unspecifiedError.rawValue)
        switch result {
        case .cancelled:
            alert = emailBrain.emailAlert("Cancelled", EM.actionCancelled.rawValue)
        case .failed:
            alert = emailBrain.emailAlert("Email Not Sent",EM.emailNotSent.rawValue)
        case .saved:
            alert = emailBrain.emailAlert("Saved", EM.movedToDraft.rawValue)
        case .sent:
            alert = emailBrain.emailAlert("Success", EM.emailSentSuccessfully.rawValue)
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
        @unknown default:
            break
        }
        
          
        controller.dismiss(animated: true)
        present(alert, animated: true, completion: nil)
        
    }
    func getEmails()->[String]{
        var finalEmail = [""]
        var emails = [Contacts]()
        let request: NSFetchRequest<Contacts> = Contacts.fetchRequest()
        do{
            emails = try context.fetch(request)
        }catch{
            print("Error Fetching data")
        }
        
        for email in emails{
            finalEmail.append(email.recipentMail ?? "")
        }
        return finalEmail
    }
}

