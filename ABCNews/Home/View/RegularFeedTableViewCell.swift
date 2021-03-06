//
//  RegularFeedTableViewCell.swift
//  ABCNews
//
//  Created by Mac on 06/06/22.
//

import UIKit
import Kingfisher

class RegularFeedTableViewCell: UITableViewCell {

    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articleDateLbl: UILabel!
    @IBOutlet weak var articleTitleLbl: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    

    var item: Item! {
        didSet {
            
            let imageURLString = item.thumbnail.htmlToString
            articleImageView.setImage(with: imageURLString)
            articleTitleLbl.text = item.title
            
            guard let date = item.pubDate.toDate() else {
                articleDateLbl.text = item.pubDate
                return
            }
            let finalString = date.toString()
            let firstString = finalString.divideStringInTwoPart()
            articleDateLbl.attributedText = finalString.attributedText(secondString: firstString)
        }
        
    }
    
    
}
