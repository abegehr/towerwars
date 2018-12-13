//
//  TWMiniCreep.swift
//  towerwars
//
//  Created by Anton Begehr on 13.12.18.
//  Copyright © 2018 Anton Begehr. All rights reserved.
//

import SpriteKit
import GameplayKit

class TWMiniCreep: TWCreep {
    
    init(position: CGPoint, team: Team, entityManager: TWEntityManager) {
        
        super.init(radius: 11, fillColor: TWPink, strokeColor: .blue, position:position, team: team, entityManager: entityManager)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func kill() {
        // remove entity
        entityManager.remove(self)
    }
    
}
