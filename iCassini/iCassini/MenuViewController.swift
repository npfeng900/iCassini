//
//  ViewController.swift
//  iCassini
//
//  Created by Niu Panfeng on 24/12/2016.
//  Copyright © 2016 NaPaFeng. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UISplitViewControllerDelegate {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.splitViewController!.delegate = self
    }
    // 控制splitView的collapsed
    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController, ontoPrimaryViewController primaryViewController: UIViewController) -> Bool {
        return false
    }
    
    // prepareForSegue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var destinantion = segue.destinationViewController as UIViewController
        
        if let nav = destinantion as? UINavigationController {
            destinantion = nav.visibleViewController!
        }
        
        if let ivc = destinantion as? ImageViewController {
            if let identifier = segue.identifier {
                switch identifier {
                case "showEarth":
                    ivc.imageURL = DemoURL.CASC.Earth
                    ivc.title = "Earth"
                case "showCassini":
                    ivc.imageURL = DemoURL.CASC.Cassini
                    ivc.title = "Cassini"
                case "showSaturn":
                    ivc.imageURL = DemoURL.CASC.Saturn
                    ivc.title = "Saturn"
                default:
                    break
                }
            }
        }
    }
    
    

}

