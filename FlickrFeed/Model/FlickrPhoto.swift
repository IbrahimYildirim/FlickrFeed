//
//  FlickrPhotos.swift
//  FlickrFeed
//
//  Created by Ibrahim Yildirim on 03/07/2017.
//  Copyright © 2017 Ibrahim Yildirim. All rights reserved.
//

import Foundation
import ObjectMapper

final class FlickrPhoto: Mappable {
    
    var author: String!
    var title: String!
    var imageUrl: String!
    var dateTaken: Date!
    
    required init?(map: Map){ }
    
    func mapping(map: Map) {
        author <- map["author"]
        title <- map["title"]
        imageUrl <- map["media.m"]
        dateTaken <- (map["date_taken"], DateTransform())
    }
}
