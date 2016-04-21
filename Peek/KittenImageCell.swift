

import UIKit

class KittenImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var kitten = Kitten?() {
        didSet {
            updateUI()
         }
    }
    
    convenience init () {
        self.init()
        imageView.contentMode = .ScaleAspectFill
        
    }
    
  
    
    private func updateUI() {
        imageView.image = nil
        guard let kittenURL = kitten?.imageURL else { return }
        let request = NSURLRequest(URL: kittenURL)
        //Launch a request to get the NSData and store it into the Kittens Array when succesfull.
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data: NSData?, _, error:NSError?) -> Void in
            
            if (error != nil) {
                print("Error: \(error!.localizedDescription)", terminator: "")
            } else {
                //Update the UI
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    if let imageData = data where kittenURL == self.kitten?.imageURL {
                        self.imageView?.image = UIImage(data: imageData)
                    }
                })
                
                
               
                    }
        }
        task.resume()
    
    }






}
