//
//  TWCastleComponent.swift
//  towerwars
//
//  Created by Anton Begehr on 13.11.18.
//  Copyright © 2018 Anton Begehr. All rights reserved.
//

import SpriteKit
import GameplayKit

class TWAiComponent: GKComponent {
    
    override init() {
        super.init()
        
        // spawn creeps every 1 second
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {_ in
            if let castleComponent = self.entity?.component(ofType: TWCastleComponent.self) {
                castleComponent.spawnCreep()
            }
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

