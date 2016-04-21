//
//  ScrollViewController.swift
//  UMParallaxView Demo
//
//  Created by Ramon Vicente on 4/7/16.
//  Copyright © 2016 Umobi. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController, UIScrollViewDelegate {
	@IBOutlet var scrollView: UIScrollView!

	var headerView: UMParallaxView?
	var tablevc: TableViewController?
	var hellovc: UIViewController?
    var flip = true

	@IBOutlet weak var containerView: UIView!
	var fixed: Bool = false

	override func viewDidLoad() {
		super.viewDidLoad()
		navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
		navigationController?.navigationBar.shadowImage = UIImage()
		navigationController?.navigationBar.translucent = true

		headerView = UMParallaxView(height: 200, fixed: fixed)
		headerView?.image = UIImage(named: "quiz_8")
      
		headerView?.attachTo(self.scrollView)

		headerView?.minHeight = 120

		scrollView.contentSize = CGSize(width: self.view.frame.width, height: 200 + containerView.frame.height)

        let camera = UIBarButtonItem(barButtonSystemItem: .Camera, target: self, action: #selector(ScrollViewController.doFlip))
        self.navigationItem.rightBarButtonItem = camera
        
	

		tablevc = self.storyboard!.instantiateViewControllerWithIdentifier("tableVC") as? TableViewController
		containerView.addSubview(tablevc!.tableView)
        
        tablevc?.tableView.translatesAutoresizingMaskIntoConstraints = false
        tablevc?.tableView.topAnchor.constraintEqualToAnchor(containerView.topAnchor).active = true
        tablevc?.tableView.widthAnchor.constraintEqualToAnchor(view.widthAnchor).active = true
        tablevc?.tableView.heightAnchor.constraintEqualToAnchor(view.heightAnchor).active = true
        
        tablevc?.tableView.leadingAnchor.constraintEqualToAnchor(containerView.leadingAnchor).active = true
       // tablevc?.tableView.trailingAnchor.constraintEqualToAnchor(containerView.trailingAnchor).active = true
        
        self.addChildViewController(tablevc!)
        tablevc!.didMoveToParentViewController(self)

		hellovc = self.storyboard!.instantiateViewControllerWithIdentifier("hellovc")
		hellovc!.view.frame = tablevc!.tableView.bounds
        
        self.addChildViewController(hellovc!)
        self.hellovc!.didMoveToParentViewController(self)
	}
    
 

	func doFlip() {
		// note: when we call remove, we must call "will" (with nil) beforehand
	
		
        if(flip) {
            transitionFromViewController(tablevc!,
                                         toViewController: hellovc!,
                                         duration: 0.4,
                                         options: .TransitionFlipFromLeft,
                                         animations: nil,
                                         completion: {
                                            _ in
                                            // finally, finish up
                                            // note: when we call add, we must call "did" afterwards
                                            
                                            self.flip = !self.flip
                                            
            })

        }
        else
        {
            transitionFromViewController(hellovc!,
                                         toViewController: tablevc!,
                                         duration: 0.4,
                                         options: .TransitionFlipFromLeft,
                                         animations: nil,
                                         completion: {
                                            _ in
                                            // finally, finish up
                                            // note: when we call add, we must call "did" afterwards
                                            
                                            self.flip = !self.flip
                                            
            })

            
            
        }
        
	}

	func scrollViewDidScroll(scrollView: UIScrollView) {
		headerView?.scrollViewDidScroll(scrollView)
	}
}
