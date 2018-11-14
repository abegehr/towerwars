//
//  TWEntityManager.swift
//  towerwars
//
//  Created by Anton Begehr on 01.11.18.
//  Copyright © 2018 Anton Begehr. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class TWEntityManager {
    
    var entities = Set<GKEntity>()
    let scene: SKScene
    
    lazy var componentSystems: [GKComponentSystem] = {
        let pathMoveSystem = GKComponentSystem(componentClass: TWPathMoveComponent.self)
        let castleSystem = GKComponentSystem(componentClass: TWCastleComponent.self)
        let teamSystem = GKComponentSystem(componentClass: TWTeamComponent.self)
        let spriteSystem = GKComponentSystem(componentClass: TWSpriteComponent.self)
        return [pathMoveSystem, castleSystem, teamSystem, spriteSystem]
    }()
    
    var toRemove = Set<GKEntity>()
    
    init(scene: SKScene) {
        self.scene = scene
    }
    
    func add(_ entity: GKEntity) {
        entities.insert(entity)
        
        if let spriteNode = entity.component(ofType: TWSpriteComponent.self)?.node {
            scene.addChild(spriteNode)
        }
        
        for componentSystem in componentSystems {
            componentSystem.addComponent(foundIn: entity)
        }
    }
    
    func remove(_ entity: GKEntity) {
        if let spriteNode = entity.component(ofType: TWSpriteComponent.self)?.node {
            spriteNode.removeFromParent()
        }
        
        entities.remove(entity)
        toRemove.insert(entity)
    }
    
    func entitiesForTeam(_ team: Team) -> [GKEntity] {
        return entities.compactMap{ entity in
            if let teamComponent = entity.component(ofType: TWTeamComponent.self) {
                if teamComponent.team == team {
                    return entity
                }
            }
            return nil
        }
    }
    
    func creepsForTeam(_ team: Team) -> [GKEntity] {
        return entitiesForTeam(team).compactMap{ entity in
            if (entity is TWCreep) {
                return entity
            }
            return nil
        }
    }
    
    func update(_ dt: CFTimeInterval) {
        for componentSystem in componentSystems {
            componentSystem.update(deltaTime: dt)
        }
        
        for currentRemove in toRemove {
            for componentSystem in componentSystems {
                componentSystem.removeComponent(foundIn: currentRemove)
            }
        }
        toRemove.removeAll()
    }
    
}
