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
   
    @IBOutlet weak var salesInput: UITextField!
    
    @IBOutlet weak var labourInput: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        restoreState()
        let done = UIToolbar()
      
              done.sizeToFit()
              let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(hideKeyboard))
      
              done.items = [doneButton]
      
      
        salesInput.delegate = self
        labourInput.delegate = self
        
        
    }
    
    
    @objc func hideKeyboard() {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)

            }
    
    
    @IBAction func submitPressed(_ sender: UIButton) {
        if let finalSales = salesInput.text{
            shiftSales.Sales = Float(finalSales)
        }
        if let finalLabour = labourInput.text{
            shiftSales.Labour = Float(finalLabour)
        }

        salesDelegate?.didGetSales(salesToday: shiftSales)
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
    
    func restoreState(){
        if let sales = shiftSales.Sales{
            salesInput.text = String(sales)

        }
        if let labour = shiftSales.Labour{
        labourInput.text = String(labour)
    }
    }

   
    
    
}
extension SalesLaborViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

