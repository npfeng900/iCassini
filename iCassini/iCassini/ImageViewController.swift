//
//  ImageViewController.swift
//  iCassini
//
//  Created by Niu Panfeng on 25/12/2016.
//  Copyright © 2016 NaPaFeng. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate, UIPopoverControllerDelegate {
    
    //imageURL -> update image
    var imageURL: NSURL? {
        didSet{
            image = nil
            //view在界面window中显示时update image
            if view.window != nil {
                fetchImage()
            }
        }
    }
    //update image
    private func fetchImage() {
        if let url = imageURL
        {
            spinner?.startAnimating()
            // 同步操作
            /*
            let imageData = NSData(contentsOfURL: url)
            if url == self.imageURL { //验证url是否是实时请求的imageURL，多线程问题
                if imageData != nil {
                    self.image = UIImage(data: imageData!)
                } else {
                    self.image = nil
                }
                
            }
            */
            // 异步操作
            let qos = Int(QOS_CLASS_USER_INITIATED.rawValue)
            dispatch_async(dispatch_get_global_queue(qos, 0)) { () -> Void in
                let imageData = NSData(contentsOfURL: url)
                dispatch_async(dispatch_get_main_queue()) {
                    if url == self.imageURL { //验证url是否是实时请求的imageURL，多线程问题
                        if imageData != nil {
                            self.image = UIImage(data: imageData!)
                        } else {
                            self.image = nil
                        }
                    }
                }
            }
        }
    }
    
    //image -> update imageView && scrollView
    private var image: UIImage? {
        get { return imageView.image }
        set {
            imageView.image = newValue
            imageView.sizeToFit() //imageView自适应Subview的尺寸
            scrollView?.contentSize = imageView.frame.size //scrollView的@IBOutlet可能为空
            
            spinner?.stopAnimating()
        }
    }
    //imageView
    private var imageView = UIImageView()
    
    //scrollView
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.contentSize = imageView.frame.size
            //缩放
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.2
            scrollView.maximumZoomScale = 3.0
        }
    }
    
    //spinner
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    //缩放
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    /** View Controll life cycle*/
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.addSubview(imageView)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Redeploy", style: .Plain, target: self, action: "redeployFun")
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if image == nil {
            fetchImage()
        }
    }
    
    func redeployFun(){
        let alert = UIAlertController(
            title: "ReDeploy Cassini",
            message: "Issue commands to Cassini's guidance system",
            preferredStyle: UIAlertControllerStyle.ActionSheet
        )
        
        alert.addAction(UIAlertAction(
            title: "Orbit Saturn",
            style: UIAlertActionStyle.Default,
            handler: { (action: UIAlertAction) -> Void in
                self.login()
            }
            ))
        alert.addAction(UIAlertAction(
            title: "Explore Titan",
            style: UIAlertActionStyle.Default,
            handler: { (action: UIAlertAction) -> Void in
               self.login()
            }
            ))
        alert.addAction(UIAlertAction(
            title: "Closeup of Sun",
            style: UIAlertActionStyle.Destructive,
            handler: { (action: UIAlertAction) -> Void in
                self.login()
            }
            ))
       
        //ipad的特殊情况
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            alert.modalPresentationStyle = .Popover
            let ppc = alert.popoverPresentationController
            ppc?.barButtonItem = self.navigationItem.rightBarButtonItem
        }
        else {
            alert.addAction(UIAlertAction(
                title: "Cancel",
                style: UIAlertActionStyle.Cancel,
                handler: nil
                ))
        }
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func login() {
        let loginAlert = UIAlertController(
            title: "Login Required",
            message: "Please enter your Cassini guidance sysetem password",
            preferredStyle: UIAlertControllerStyle.Alert
        )
        loginAlert.addAction(UIAlertAction(
            title: "Cancel",
            style: .Cancel,
            handler: nil
            ))
        loginAlert.addAction(UIAlertAction(
            title: "Login",
            style: .Default,
            handler: { (UIAlertAction) -> Void in
                if let tf = loginAlert.textFields?.first {
                    print(tf.text!)
                }
            }
            ))
        loginAlert.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Guidance System Password"
        }
        presentViewController(loginAlert, animated: true, completion: nil)
    }
 }
