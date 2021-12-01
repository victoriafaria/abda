//
//  Persistence.swift
//  abda
//
//  Created by Victoria Faria on 30/11/21.
//

import UIKit

class Persistence {

       static let defaults = UserDefaults.standard

       static var highScore: Double {

           get {
               return defaults.double(forKey: "highScore")
           }

           set {
               defaults.set(newValue, forKey: "highScore")
               defaults.synchronize()
           }
       }

}
