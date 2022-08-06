//
//  TimeCheck.swift
//  Navigation
//
//  Created by Suharik on 29.07.2022.
//

import UIKit
import Foundation
import SnapKit

struct TimeCheck {
    static func timeToString(sec: Double) -> String {
        let minutes = Int(sec) / 60
        let seconds = sec - Double(minutes) * 60
        let secondsFraction = seconds - Double(Int(seconds))
        return String(format:"%02i:%02i.%02d",minutes,Int(seconds),Int(secondsFraction * 100.0))
    }
    
    static func showElapsedTimeAlert(navCon: UINavigationController, sec: Double)  {
        let alertController = UIAlertController(
            title: "Done!",
            message: "elapsed time: \(timeToString(sec: sec))",
            preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        navCon.present(alertController, animated: true, completion: nil)
    }
}



