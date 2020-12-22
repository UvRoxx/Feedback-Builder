//
//  SalesLaborViewController.swift
//  Feedback Builder
//
//  Created by UTKARSH VARMA on 2020-11-23.
//

protocol SalesLaborDelegate{
    func didGetSales(salesToday:SalesLabour)
}
import UIKit

class SalesLaborViewController: UIViewController {
    
    var salesDelegate:SalesLaborDelegate?
    
    var shiftSales = SalesLabour()
    @IBOutlet weak var salesInput: UITextView!
    @IBOutlet weak var labourInput: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        restoreState()
        let done = UIToolbar()
      
              done.sizeToFit()
              let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(hideKeyboard))
      
              done.items = [doneButton]
      
      
              salesInput.inputAccessoryView = done
              labourInput.inputAccessoryView = done
        
        
        
    }
    
    
    @objc func hideKeyboard() {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)

            }
    
    
    @IBAction func submitPressed(_ sender: UIButton) {
        if let finalSales = salesInput.text{
            shiftSales.Sales = Float(finalSales) ?? 0.0
        }
        if let finalLabour = labourInput.text{
            shiftSales.Labour = Float(finalLabour) ?? 0.0
        }

        salesDelegate?.didGetSales(salesToday: shiftSales)
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
    
    func restoreState(){
        salesInput.text = String(shiftSales.Sales)
        labourInput.text = String(shiftSales.Labour)
    }

   
    
    
}

extension SalesLaborViewController:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}


