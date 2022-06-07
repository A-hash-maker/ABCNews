//
//  FeedViewModel.swift
//  ABCNews
//
//  Created by Mac on 07/06/22.
//

import Foundation
import SwiftyJSON

struct FeedViewModel {
    
    let feed: Feed
    var items = [Item]()
    
    init(json: JSON) {
        self.feed = Feed(json: ["feed"])
        if let items = json["items"].array {
            self.items = items.map { Item(json: $0) }
        }
    }
    
    
}


struct Feed {
    let author: String
    let image: String
    let link:String
    let description: String
    let title: String
    let url: String
    
    
    init(json: JSON) {
        self.author = json["author"].stringValue
        self.image = json["image"].stringValue
        self.link = json["link"].stringValue
        self.description = json["description"].stringValue
        self.title = json["title"].stringValue
        self.url = json["url"].stringValue
    }
    
}

struct Item {
    let thumbnail: String
    let title: String
    let description: String
    let pubDate: String
    let enclosure: Enclosure
    
    init(json: JSON) {
        self.thumbnail = json["thumbnail"].stringValue
        self.title = json["title"].stringValue
        self.description = json["description"].stringValue
        self.pubDate = json["pubDate"].stringValue
        self.enclosure = Enclosure(json: json["enclosure"])
    }
    
}

struct Enclosure {
    let link: String
    let thumbnail: String
    
    init(json: JSON) {
        self.link = json["link"].stringValue
        self.thumbnail = json["thumbnail"].stringValue
    }
    
    
}
