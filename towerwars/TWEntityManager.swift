//
//  TWEntityManager.swift
//  towerwars
//
//  Created by Anton Begehr on 01.11.18.
//  Copyright © 2018 Anton Begehr. All rights reserved.
//
//  with guidance from: https://www.raywenderlich.com/706-gameplaykit-tutorial-entity-component-system-agents-goals-and-behaviors
//

import Foundation
import SpriteKit
import GameplayKit

class TWEntityManager {

  var entities = Set<GKEntity>()
  let scene: SKScene

  lazy var componentSystems: [GKComponentSystem] = {
    let pathMoveSystem = GKComponentSystem(componentClass: TWPathMoveComponent.self)
    return [pathMoveSystem]
  }()

  var toRemove = Set<GKEntity>()

  init(scene: SKScene) {
    self.scene = scene
  }

  func add(_ entity: GKEntity) {
    entities.insert(entity)

    if let spriteNode = entity.component(ofType: GKSKNodeComponent.self)?.node {
      scene.addChild(spriteNode)
    }

    for componentSystem in componentSystems {
      componentSystem.addComponent(foundIn: entity)
    }
  }

  func remove(_ entity: GKEntity) {
    if let spriteNode = entity.component(ofType: GKSKNodeComponent.self)?.node {
      spriteNode.removeFromParent()
    }

    entities.remove(entity)
    toRemove.insert(entity)
  }

  func update(_ deltaTime: CFTimeInterval) {
    for componentSystem in componentSystems {
      componentSystem.update(deltaTime: deltaTime)
    }

    for currentRemove in toRemove {
      for componentSystem in componentSystems {
        componentSystem.removeComponent(foundIn: currentRemove)
      }
    }
    toRemove.removeAll()
  }

}
