//
//  FlickrService.swift
//  FlickrFeed
//
//  Created by Ibrahim Yildirim on 03/07/2017.
//  Copyright © 2017 Ibrahim Yildirim. All rights reserved.
//

import Foundation
import Alamofire

class FlickrService {
    
    static let sharedInstance = FlickrService()
    
    func getFeed(handler: @escaping (_ photos: [FlickrPhoto]?, _ error: NSError?) -> Void) {
        let urlString = "http://api.flickr.com/services/feeds/photos_public.gne"
        
        Alamofire.request(urlString, method: .get, parameters: ["format" : "json", "nojsoncallback" : "1"], encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            switch response.result {
            case .success(let json) :
                if let feedResponse = FeedResponse(JSON: json as! Dictionary) {
                    handler(feedResponse.items, nil)
                } else {
                    handler(nil, nil)
                }
                break;
            case .failure(let error) :
                handler(nil, error as NSError)
                break;
            }
            
        }
    }
}
