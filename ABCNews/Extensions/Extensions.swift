//
//  Extensions.swift
//  ABCNews
//
//  Created by Mac on 06/06/22.
//

import Foundation
import UIKit
import Kingfisher

//MARK: - Extension UITableViewCell

extension UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}

//MARK: - Extension UIImageView

extension UIImageView {
    func setImage(with urlString: String) {
        guard let url = URL.init(string: urlString) else {
            self.image = UIImage(named: "placeholder") ?? UIImage()
            return
        }
        let resource = ImageResource(downloadURL: url, cacheKey: urlString)
        var kf = self.kf
        kf.indicatorType = .activity
        DispatchQueue.main.async {
            self.kf.setImage(with: resource)
        }
    }
}

//MARK: - UIView

extension UIView {
    func setCornerRadius(radii: CGFloat) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radii
    }
}


extension String {

    func toDate() -> Date? {
        let format: String = "yyyy-MM-dd HH:mm:ss"
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tehran")
        dateFormatter.locale = Locale(identifier: "fa-IR")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        return date
    }
    
    func attributedText(secondString: String) -> NSAttributedString {
        let font = UIFont.systemFont(ofSize: 15)
        let boldFont = UIFont.boldSystemFont(ofSize: 15)
        let attributedString = NSMutableAttributedString(string: self,
                                                         attributes: [NSAttributedString.Key.font: font])
        let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: boldFont, NSAttributedString.Key.foregroundColor: AppColor.PHILIPPINEGRAY]
        let range = (self as NSString).range(of: secondString)
        attributedString.addAttributes(boldFontAttribute, range: range)
        return attributedString
    }
    
    func divideStringInTwoPart() -> String {
        let count = 11
        var returnString: String = ""
        var counter = 0

        for item in self.indices {
            if counter <= count {
                returnString += "\(self[item])"
            }
            counter += 1
        }
        return returnString
    }
    
    func replaceTheOccurances() -> String {
        let newString = self.replacingOccurrences(of: "amp;", with: "", options: .literal, range: nil)
        return newString.replacingOccurrences(of: "//", with: "/", options: .literal, range: nil)
    }
    
    
    
    
}

extension Date {
    
    func toString() -> String {
        let dateFormat = "MMM d, YYYY hh:mm a"
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as! TimeZone
        dateFormatter.dateFormat = dateFormat
        let str = dateFormatter.string(from: self)
        return str
    }
    
}
