//
//  AppExtensions.swift
//  SampleNewsArticleApp
//
//  Created by Nishan G. Prathima on 9/23/19.
//  Copyright © 2019 Nishan G. Prathima. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    var sharedDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    public func showAlert(withMessage message: String, withCompletionHandler completionHandler: @escaping() -> Void) {
        let alertController = UIAlertController.init(title: "Alert!", message: message, preferredStyle: .alert)
        let alertActionCancel = UIAlertAction.init(title: "Ok", style: .cancel) { (action) in
            completionHandler()
        }
        alertController.addAction(alertActionCancel)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension UIView {
    
    func width() -> CGFloat {
        return self.frame.width
    }
    
    func height() -> CGFloat {
        return self.frame.height
    }
}

extension UIColor {
    
    class func random() -> UIColor {
        let red:CGFloat = CGFloat(drand48())
        let green:CGFloat = CGFloat(drand48())
        let blue:CGFloat = CGFloat(drand48())
        return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
    }
    
    class func RGB(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor.init(red: r/255, green: g/255, blue: b/255, alpha: 1.0)
    }
    
    class func colorFromRGB(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor.init(red: r/255, green: g/255, blue: b/255, alpha: alpha)
    }
    
    class func darkJungleGreen() -> UIColor {
        return UIColor.RGB(r: 34, g: 34, b: 34)
    }
    
    class func uniOfcaliGold() -> UIColor {
        return UIColor.RGB(r: 186, g: 130, b: 43)
    }
    
    class func msuGreen() -> UIColor {
        return UIColor.RGB(r: 33, g: 63, b: 68)
    }
    
    class func darkSlateGray() -> UIColor {
        return UIColor.RGB(r: 36, g: 67, b: 73)
    }
    
    class func taupeGray() -> UIColor {
        return UIColor.RGB(r: 142, g: 142, b: 147)
    }
    
    class func bostonUniRED() -> UIColor {
        return RGB(r: 200, g: 7, b: 7)
    }
}

extension UIImageView {
    
    func setRounded() {
        let radius = self.frame.height / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.gray.cgColor
        self.clipsToBounds = true
    }
}
