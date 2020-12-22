//
//  SettingsViewController.swift
//  Feedback Builder
//
//  Created by UTKARSH VARMA on 2020-12-03.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet var buttons: [UIButton]!
    override func viewDidLoad() {
        super.viewDidLoad()

        for button in buttons {
            
            button.layer.cornerRadius = button.frame.size.height/2;
            button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
            
        }
        
    }
    

  
}
