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

class FeedbackVC: UIViewController {
   
    let context = ((UIApplication.shared.delegate)as!AppDelegate).persistentContainer.viewContext
    let defaults = UserDefaults.standard
    
    //MARK:-Model Objects
    var emailBuilder = EmailBuilder()
    let salesDelegate = SalesLaborViewController()
    var salesLabour = SalesLabour()
    var emailBrain = EmailBrain()
    var listBuilder = ListBuilder()
    var listContent = String()
    //MARK:-DataModel Objects
    var currentTimerData    = Throughput()
    var currentComment      = Comment()
    var listsAdded          = [Int]()
   
  
    
    var segueDestination = ""
    @IBOutlet var buttonDesign: [UIButton]!
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
   
    
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
        case 1:
            segueDestination = "Throughput"
            performSegue(withIdentifier: "gotoThroughput", sender: self)
            break
        case 2:
            segueDestination = "SalesAndLabour"
            performSegue(withIdentifier: "gotoSalesAndLabour", sender: self)
            break
        case 3:
            segueDestination = "Comments"
            performSegue(withIdentifier: "gotoComment", sender: self)
        case 4:
            let desitnationVC = storyboard?.instantiateViewController(identifier: "AddListTableVC")as!AddListTableVC
            desitnationVC.listToMailDelegate = self
            desitnationVC.categoriesAdded = listsAdded
            present(desitnationVC, animated: true, completion: nil)
            
        break
        case 5:
            listContent = listBuilder.buildListForMail(listsSelected: listsAdded)
            
            let email = emailBuilder.FinalEmailBuilder(TimerData: currentTimerData, salesData: salesLabour, commentData: currentComment.commentText, checkListContent: listContent)
            
            print(email)//Use this to see output in VM
            
            showMailComposer(emailBody: email)//Use this to see output in actual device
        
       
        default:
            break
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (segueDestination){
        case "Throughput":
            let destinationVC = segue.destination as! ThroughputViewController
            destinationVC.timerDelegate = self
            destinationVC.shiftInfo = currentTimerData
            break
            
        case "Comments":
            let destinationVC = segue.destination as! CommentViewController
            destinationVC.commentDelegate = self
            destinationVC.userComment = currentComment
            break
        case "SalesAndLabour":
            let destinationVC = segue.destination as! SalesLaborViewController
            destinationVC.salesDelegate = self
            destinationVC.shiftSales = salesLabour
            break
        
        default:
            present(emailBrain.emailAlert("Unexpxected Error Occoured", "Please retry the action"),animated: true, completion: nil)
        break

        }
        navigationController?.setNavigationBarHidden(false, animated: true)
        tabBarController?.tabBar.isHidden = true

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
extension FeedbackVC:TimerWasSent{
    func getShiftTimer(todaysTimer: Throughput) {
        currentTimerData.dayPartTimer = todaysTimer.dayPartTimer
    }
    
    
}

extension FeedbackVC:commentDataDelegate{
    func thereIsComment(userComment: Comment) {
        currentComment.commentText = userComment.commentText
    }
    
    
}

extension FeedbackVC:SalesLaborDelegate{
    func didGetSales(salesToday: SalesLabour) {
        salesLabour = salesToday
    }
}

extension FeedbackVC:addListToMail{
    func addListData(indexsSelected: [Int]) {
        listsAdded = indexsSelected
        print("Recived")
    }
    
  
    
    
}

//MARK: -Mail Composer

extension FeedbackVC: MFMailComposeViewControllerDelegate {
    
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
        var finalEmail = [String]()
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

