# FlickrFeed
iOS App showing Flickr's Feed. Made as a **#CodingChallenge** for **House Of Code**

### Extra Features
* Pull to refresh
* Mosaic Layout


### 3rd Party Libraries used
3rd party dependencies used in app. Remember to Pod Install before running project.

* Alamofire
 * Used for networking
* ObjectMapper
 * Used to map JSON response to objects
* SwiftyJSON
 * Used together with Alamofire and ObjectMapper, so easily map the response JSON to objects
* Kingfisher
 * Used to download and cache images

 
To create a nice layout i used **TRMosaicLayout**. However i discovered a issue (it was not scrolling till the end, when a big tile is at the bottom), i fetched it and made some edits - Also created a [Pull Request](https://github.com/vinnyoodles/mosaic-layout/pull/18) for the fix.
Because those changes isn't merged yet, this package is included in the project, and not through CocoaPods 
 