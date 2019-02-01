//
//  TWPathComponent.swift
//  towerwars
//
//  Created by Anton Begehr on 27.12.18.
//  Copyright © 2018 Anton Begehr. All rights reserved.
//

import Foundation
import GameplayKit

class TWPathComponent: GKComponent {
    
    var path: GKPath
    
    init(path: GKPath) {
        self.path = path
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
