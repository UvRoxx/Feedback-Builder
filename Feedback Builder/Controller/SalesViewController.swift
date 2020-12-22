//
//  SalesViewController.swift
//  Feedback Builder
//
//  Created by UTKARSH VARMA on 2020-11-23.
//

import UIKit

class SalesViewController: UIViewController {
static var shiftInfo = ShiftInfo()
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.hideKeyboard()
        // Do any additional setup after loading the view.
        //Creating Toolbar for done button
     
        let done = UIToolbar()
        
        done.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(hideKeyboard))
        
        done.items = [doneButton]
        
        
        totalSales.inputAccessoryView = done
        totalLabout.inputAccessoryView = done
       
        
        
           // restoreState()
        
    }
  
   
    
    @IBOutlet weak var totalSales: UITextField!
    
   
    @IBOutlet weak var totalLabout: UITextView!
    
    @objc func hideKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
      
        }
    
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func submitPressed(_ sender: Any) {
        
        CommentViewController.shiftInfo.totalSales = totalSales.text ?? "";        CommentViewController.shiftInfo.labourCost = totalLabout.text ?? ""
        
        CommentViewController.shiftInfo.thereIsData = true
        self.dismiss(animated: true, completion: nil)
    }
    func restoreState()
    {
        totalSales.text = String(CommentViewController.shiftInfo.totalSales)
        
        totalLabout.text = String(CommentViewController.shiftInfo.labourCost)
    }
    
    
}
