//
//  TWGameScene.swift
//  towerwars
//
//  Created by Anton Begehr on 28.09.18.
//  Copyright © 2018 Anton Begehr. All rights reserved.
//

import SpriteKit
import GameplayKit

class TWGameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    
    private var map_nodes = [SKSpriteNode]()
    private var characters = [TWCharacter]()
    
    override func sceneDidLoad() {
        
        // init
        self.lastUpdateTime = 0
        
        // create a demo map
        self.createMap()
        
        // add character
        self.addCharacter(position: CGPoint(x: 0, y: -300))
    }
    
    func createMap() {
        print("creating map!")
        
        // add some walls
        self.addWallSprite(position: CGPoint(x:0, y:0))
        self.addWallSprite(position: CGPoint(x:100, y:100))
    }
    
    // adds wall sprite at position
    func addWallSprite(position: CGPoint) {
        let newWall = SKSpriteNode(imageNamed: "Wall")
        newWall.position = position
        self.addChild(newWall)
        self.map_nodes.append(newWall)
    }
    
    // adds wall at with path at position
    func addWall(path: CGPath, position: CGPoint) {
        // TODO: use TWWall
    }
    
    // adds character at position
    func addCharacter(position: CGPoint) {
        let newCharacter = TWCharacter.init()
        newCharacter.position = position
        self.addChild(newCharacter)
        self.characters.append(newCharacter)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
}
