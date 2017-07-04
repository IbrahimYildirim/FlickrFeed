//
//  ViewController.swift
//  FlickrFeed
//
//  Created by Ibrahim Yildirim on 03/07/2017.
//  Copyright © 2017 Ibrahim Yildirim. All rights reserved.
//

import UIKit
import Kingfisher

private let cellIdentifier = "CollectionViewCell"


class FeedViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var refreshControl : UIRefreshControl!
    
    var photos = [FlickrPhoto]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        let mosaicLayout = TRMosaicLayout()
        collectionView.collectionViewLayout = mosaicLayout
        mosaicLayout.delegate = self
        
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        refreshControl.addTarget(self, action: #selector(getFeed), for: .valueChanged)
        collectionView.addSubview(refreshControl)
        
        getFeed()
    }
    
    func getFeed() {
        FlickrService.sharedInstance.getFeed {photos, error in
            
            self.refreshControl.endRefreshing()
            
            if let error = error {
                //Show Error
                self.showAlert("Fejl", message: "Der skete en fejl, prøv igen senere. \(error.localizedDescription)")
                return;
            }
            
            if let photos = photos {
                if photos.count == 0 {
                    //No photos in feed=
                    self.showAlert("Ooups", message: "Ingen billeder i feed. Swipe ned for at prøve igen")
                    return;
                }
                
                //Update CollectionView
                self.photos = photos
                self.collectionView.reloadData()
                
            } else {
                //Error parsing photos
                self.showAlert("Ooups", message: "Der opstod en fejl.. Det er en ommer")
            }
        }
    }
    
    func showAlert(_ title : String, message : String, rightAction : UIAlertAction? = nil) {
        let leftAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(leftAction)
        if let action = rightAction {
            alert.addAction(action)
        }
        self.present(alert, animated: true, completion: nil)
    }
}

extension FeedViewController : TRMosaicLayoutDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        let imageView = UIImageView(frame: cell.frame) //UIView(frame: cell.frame) //UIImageView(image: image)
        imageView.kf.setImage(with: URL(string: photos[indexPath.row].imageUrl), placeholder: nil, options: [.transition(.fade(0.3))], progressBlock: nil, completionHandler: nil)
        cell.backgroundView = imageView
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    //MARK: TRCollectionView
    func collectionView(_ collectionView:UICollectionView, mosaicCellSizeTypeAtIndexPath indexPath:IndexPath) -> TRMosaicCellType {
        return indexPath.item % 3 == 0 ? TRMosaicCellType.big : TRMosaicCellType.small
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout: TRMosaicLayout, insetAtSection:Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
    }
    
    func heightForSmallMosaicCell() -> CGFloat {
        return 150
    }
}


