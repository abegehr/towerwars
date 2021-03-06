//
//  TWEntityManager.swift
//  towerwars
//
//  Created by Anton Begehr on 01.11.18.
//  Copyright © 2018 Anton Begehr. All rights reserved.
//

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
        if let inRangeComponent = entity.component(ofType: TWInRangesComponent.self) {
            inRangeComponent.removeFromAllRanges()
        }
        
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
    
    func castleComponentForTeam(_ team: Team) -> TWCastleComponent? {
        for entity in entities {
            if let teamComponent = entity.component(ofType: TWTeamComponent.self),
                let castleComponent = entity.component(ofType: TWCastleComponent.self) {
                if teamComponent.team == team {
                    return castleComponent
                }
            }
        }
        return nil
    }
    
    func castleForTeam(_ team: Team) -> TWCastle? {
        for entity in entities {
            if let castle = entity as? TWCastle,
                let teamComponent = entity.component(ofType: TWTeamComponent.self) {
                if teamComponent.team == team {
                    return castle
                }
            }
        }
        return nil
    }
    
    func buildTower(type: TowerType, posX: CGFloat, posY: CGFloat, team: Team) {
        let tower: TWTower?
        
        // tower types
        switch type {
        case .arrow:
            tower = TWTower(range: 3*w, team: team, entityManager: self)
        }
        
        if tower != nil {
            if let spriteComponent = tower!.component(ofType: TWSpriteComponent.self) {
                spriteComponent.node.position = CGPoint(x: posX, y: posY)
                spriteComponent.node.zPosition = 2
            }
            add(tower!)
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
