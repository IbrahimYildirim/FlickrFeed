//
//  FeedResponse.swift
//  FlickrFeed
//
//  Created by Ibrahim Yildirim on 03/07/2017.
//  Copyright © 2017 Ibrahim Yildirim. All rights reserved.
//

import Foundation
import ObjectMapper

final class FeedResponse: Mappable {
    
    var items: [FlickrPhoto]?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        items <- map["items"]
    }
}
