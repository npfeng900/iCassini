//
//  DemoURL.swift
//  iCassini
//
//  Created by Niu Panfeng on 25/12/2016.
//  Copyright © 2016 NaPaFeng. All rights reserved.
//

import Foundation

struct DemoURL {
    
    static let Naikai = NSBundle.mainBundle().URLForResource("Nankai", withExtension: "jpg")
    
    struct CASC {
        static let Cassini = NSURL(string: "https://upload.wikimedia.org/wikipedia/commons/b/b2/Cassini_Saturn_Orbit_Insertion.jpg")
        static let Earth = NSURL(string:"http://images.forwallpaper.com/files/thumbs/preview/107/1073887__earth_p.jpg")
        static let Saturn = NSURL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c7/Saturn_during_Equinox.jpg/1280px-Saturn_during_Equinox.jpg")
    }
}