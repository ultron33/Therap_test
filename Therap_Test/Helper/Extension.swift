//
//  Extension.swift
//  Therap_Test
//
//  Created by Iftiquar Ahmed Ove on 5/3/21.
//

import Foundation
import UIKit


extension UIView {
    func anchor (top : NSLayoutYAxisAnchor? , left: NSLayoutXAxisAnchor? , bottom : NSLayoutYAxisAnchor? , right : NSLayoutXAxisAnchor? , paddingTop : CGFloat , paddingLeft : CGFloat , paddingBottom : CGFloat , paddingRight : CGFloat , width : CGFloat , height : CGFloat){
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top , constant: paddingTop).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left , constant: paddingLeft).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom , constant: -paddingBottom).isActive = true
        }
        if let right = right {
            self.rightAnchor.constraint(equalTo: right , constant: -paddingRight).isActive = true
        }
        if  width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
    }
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

extension UIViewController{
    func showToast(message : String, font: UIFont, cardHight: CGFloat, labelHeight: CGFloat, labelWidth: CGFloat, duration: Double = 2.0) {
        let finalFont = font.withSize(UIScreen.main.bounds.width>428 ? font.pointSize*1.5 : font.pointSize)
        let toastLabel = UILabel(frame: CGRect(x: (self.view.frame.size.width/2) - (labelWidth/2), y: self.view.frame.size.height - 100-cardHight-labelHeight-8, width: labelWidth, height: labelHeight))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        toastLabel.textColor = UIColor.white
        toastLabel.font = finalFont
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 0.5, delay: duration, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}


extension UITextField{
    
    func textField(title: String = "", textColor: UIColor = UIColor.clear, fontStyle: UIFont? = nil, placeholderText: String = "" , placeHolderColor: UIColor = .black) -> UITextField{
        let finalFont = fontStyle?.withSize(UIScreen.main.bounds.width>428 ? fontStyle!.pointSize*1.5 : fontStyle!.pointSize)
        let field = UITextField()
        field.font = finalFont
        field.text = title
        field.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: placeHolderColor])
        field.textColor = textColor
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }
}

extension String {
    var isReallyEmpty: Bool {
        return self.trimmingCharacters(in: .whitespaces).isEmpty
    }
}

extension UITableView {
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 17)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}

extension UIViewController {
    func showActivityIndicator() {
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        activityIndicator.backgroundColor = UIColor(red:0.16, green:0.17, blue:0.21, alpha:1)
        activityIndicator.layer.cornerRadius = 6
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .whiteLarge
        activityIndicator.startAnimating()
        //UIApplication.shared.beginIgnoringInteractionEvents()

        activityIndicator.tag = 100 // 100 for example

        // before adding it, you need to check if it is already has been added:
        for subview in view.subviews {
            if subview.tag == 100 {
                print("already added")
                return
            }
        }

        view.addSubview(activityIndicator)
    }

    func hideActivityIndicator() {
        let activityIndicator = view.viewWithTag(100) as? UIActivityIndicatorView
        activityIndicator?.stopAnimating()

        // I think you forgot to remove it?
        activityIndicator?.removeFromSuperview()

        //UIApplication.shared.endIgnoringInteractionEvents()
    }
}

