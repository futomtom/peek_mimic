//
//  UMParallaxView.swift
//
//  Created by Ramon Vicente on 4/7/16.
//  Copyright © 2016 Umobi. All rights reserved.
//

import UIKit

class UMParallaxView: UIView {
    
    private var heightLayoutConstraint: NSLayoutConstraint?
    private var bottomLayoutConstraint: NSLayoutConstraint?
    private var containerLayoutConstraint: NSLayoutConstraint?
    
    private var containerView = UIView()
    
    private var imageView = UIImageView()
     private var describption = UILabel()
    
    private var scrollView: UIScrollView? = nil {
        didSet {
            reloadPosition()
        }
    }
    
    var height: CGFloat = 0 {
        didSet {
            self.frame.size.height = height
            if scrollView != nil {
                scrollView!.contentInset = UIEdgeInsetsMake(height, 0, 0, 0);
            }
            reloadPosition()
        }
    }
    
    var minHeight: CGFloat = 0 {
        didSet {
            reloadPosition()
        }
    }
    
    private var _maxHeight: CGFloat = 0
    
    var maxHeight: CGFloat {
        get {
            return _maxHeight <= height ? height*1.5 : _maxHeight
        }
        set {
            _maxHeight = newValue
        }
    }
    
    var fixed: Bool = true {
        didSet {
            reloadPosition()
        }
    }
    
    var zoomFactor: CGFloat = 2 {
        didSet {
            reloadPosition()
        }
    }
    
    var image:UIImage? {
        didSet{
            imageView.image = image
        }
    }
    
    convenience init?(height: CGFloat, fixed: Bool = true) {
        self.init(frame: CGRectZero)
        self.height = height
        self.fixed = fixed
        
        maxHeight = 999
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    func attachTo(scrollView: UIScrollView!) {
        scrollView.addSubview(self)
        self.scrollView = scrollView
        
        self.frame = CGRect(x: 0, y: 0, width: 375, height: self.height)
        scrollView!.contentInset = UIEdgeInsetsMake(height, 0, 0, 0);
        
        reloadPosition()
    }
    
    private func prepareView() {
        
        self.backgroundColor = UIColor.whiteColor()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor.clearColor()
        containerView.clipsToBounds = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.clearColor()
        imageView.clipsToBounds = true
        imageView.contentMode = .ScaleAspectFill
        describption.text = "Hello Wordl. this is a test"
      //  let y = containerView.frame.height - 30
      //  describption.frame = CGRectMake(0, y, 200, 30)
    
        


        
        
        containerView.addSubview(imageView)
        
        containerView.addSubview(describption)
   
        describption.textColor = .whiteColor()
    
        describption.font = UIFont(name: "HelveticaNeue", size: CGFloat(22))
         describption.translatesAutoresizingMaskIntoConstraints = false
           describption.leadingAnchor.constraintEqualToAnchor(containerView.leadingAnchor).active = true
           describption.bottomAnchor.constraintEqualToAnchor(containerView.bottomAnchor).active = true
 

        
        
        self.addSubview(containerView)
        
        let containerHorizontalLayoutConstraint = NSLayoutConstraint.constraintsWithVisualFormat("H:|[containerView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["containerView" : containerView])
        let containerVerticalLayoutConstraint = NSLayoutConstraint.constraintsWithVisualFormat("V:[containerView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["containerView" : containerView])
        containerLayoutConstraint = NSLayoutConstraint(item: containerView, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 1.0, constant: 0.0)
     //   let containerWLayoutConstraint = NSLayoutConstraint(item: containerView, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 1.0, constant: 0.0)
        
        
        
        let imageViewHorizontalLayoutConstraint = NSLayoutConstraint.constraintsWithVisualFormat("H:|[imageView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["imageView" : imageView])
        bottomLayoutConstraint = NSLayoutConstraint(item: imageView, attribute: .Bottom, relatedBy: .Equal, toItem: containerView, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        heightLayoutConstraint = NSLayoutConstraint(item: imageView, attribute: .Height, relatedBy: .Equal, toItem: containerView, attribute: .Height, multiplier: 1.0, constant: 0.0)
        
       // let TopLayoutConstraint = NSLayoutConstraint(item: imageView, attribute: .Top, relatedBy: .Equal, toItem: containerView, attribute: .Top, multiplier: 1.0, constant: 0.0)
        
      //   let widthLayoutConstraint = NSLayoutConstraint(item: imageView, attribute: .Width, relatedBy: .Equal, toItem: containerView, attribute: .Width, multiplier: 1.0, constant: 0.0)

        
        



        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addConstraints(imageViewHorizontalLayoutConstraint)
        containerView.addConstraint(bottomLayoutConstraint!)
         containerView.addConstraint(heightLayoutConstraint!)
     //  containerView.addConstraint(TopLayoutConstraint)
     
        
        addConstraints(containerHorizontalLayoutConstraint)
        addConstraints(containerVerticalLayoutConstraint)
        addConstraint(containerLayoutConstraint!)
      //  addConstraint(containerWLayoutConstraint)
        
    }
    
    private func reloadPosition() {
        
        if scrollView != nil {
            let offsetY: CGFloat = (scrollView!.contentOffset.y + height);
            let offsetYInverse = -offsetY;
            
            var newheight = height - offsetY
            newheight = newheight > minHeight ? newheight : minHeight;
            if fixed {
                newheight = newheight < maxHeight ? newheight : maxHeight;
            }
            
            var bottomConstant = offsetY >= 0 ? 0 : offsetYInverse
            if fixed {
                bottomConstant = bottomConstant > (maxHeight-height) ? (maxHeight-height) : bottomConstant
            }
            
            var heightConstant = newheight - (newheight * (zoomFactor > 3 ? 3 : zoomFactor) / 3)
            if !fixed {
                heightConstant = heightConstant > offsetYInverse ? heightConstant : offsetYInverse
            }
            
            
            containerLayoutConstraint!.constant = heightConstant
            heightLayoutConstraint!.constant = heightConstant
            bottomLayoutConstraint!.constant = bottomConstant/3
            
            if fixed {
                self.frame.size.height = newheight;
                self.frame.origin.y = offsetY - height
            } else {
                containerView.clipsToBounds = offsetY <= 0
                self.frame.origin.y = -height
            }
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.scrollView = scrollView
        reloadPosition()
    }
}
