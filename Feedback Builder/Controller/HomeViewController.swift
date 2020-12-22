//
//  HomeViewController.swift
//  Feedback Builder
//
//  Created by UTKARSH VARMA on 2020-12-21.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherTemp: UILabel!
    @IBOutlet weak var quoteOfTheDayContent: UILabel!
    @IBOutlet weak var todaysDate: UILabel!
    let dateAndTime = DateAndTime()
    override func viewDidLoad() {
        super.viewDidLoad()
        todaysDate.text = dateAndTime.getDisplayDate()
    }
    

   

}
