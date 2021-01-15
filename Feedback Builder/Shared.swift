//
//  Shared.swift
//  Feedback Builder
//
//  Created by UTKARSH VARMA on 2021-01-15.
//

import Foundation

class Shared{
    private init(){}
    static let shared = Shared()
    
    let defaults = UserDefaults.standard
}
