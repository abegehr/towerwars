//
//  TWAiComponent.swift
//  towerwars
//
//  Created by Anton Begehr on 28.11.18.
//  Copyright © 2018 Anton Begehr. All rights reserved.
//

import SpriteKit
import GameplayKit

class TWAiComponent: GKComponent {
    
    override init() {
        super.init()
        
        // spawn creeps every 2 seconds
        var counter = 0.0
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: {timer in
            //PROBLEM: this counter keeps running after the fame was restarted. It does not spawn creeps thow. Will new creep spawning techniques solve this?
            
            counter += timer.timeInterval
            
            let counter_stages = ceil(counter / 30.0)
            
            // n: creeps to spawn
            let n = Int(ceil(counter_stages*0.66))
            
            if let castleComponent = self.entity?.component(ofType: TWCastleComponent.self) {
                print("counter: ", counter, " spawning creeps: ", n)
                for _ in 1...n {
                    castleComponent.spawnCreep()
                }
            }
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

