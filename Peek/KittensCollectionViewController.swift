

import UIKit

class KittensCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var firstTimeShow = 1
    @objc var normalMmode = 0
  
    private struct Constants {
        static let numberOfKittens = 50
        static let sizeOfKittensImages = 600
        static let reuseIdentifier = "Cell"
        static let segueIdentifier = "ShowImage"
    }
    var kittens = [Kitten]()
    var kittensCreation = KittensCreation(count: Constants.numberOfKittens, imageSize: Constants.sizeOfKittensImages)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Start activity indicator.
        activityIndicator.color = UIColor.whiteColor()
        activityIndicator.startAnimating()
       
        kittens = kittensCreation.createArrayOfKittens()
        collectionView?.reloadData()
        self.activityIndicator.stopAnimating()
        
    

    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = collectionView.frame.width
        
        if (indexPath.item == 0) && normalMmode == 0 {
            return CGSize(width: width  , height: width*2/3	)

        }
            return CGSize(width: round(width/2)-2   , height: width/2)
        
        
    }


   

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
               return kittens.count
    }
    override func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        if (firstTimeShow == 1) && normalMmode == 0 {
            let mycell = cell as! KittenImageCell
            let imageView = mycell.imageView
            if (indexPath.item < 6) {
                imageView.transform = CGAffineTransformMakeScale(0.1, 0.1)
                dispatch_async(dispatch_get_main_queue()) {
                    UIView.animateWithDuration(0.6, delay: 0, options: [], animations: {
                        imageView.transform = CGAffineTransformMakeScale(1, 1)
                        }, completion: { _ in self.firstTimeShow = 0 })
                }
            }
            
        }
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
                let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Constants.reuseIdentifier, forIndexPath: indexPath) as! KittenImageCell
    
        // Configure the cell
        cell.kitten = kittens[indexPath.row]
        
        
        return cell
    }
    
   
    
    
 
    
    
}
