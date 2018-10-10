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
    
    private var map_nodes = [SKNode]()
    private var characters = [TWCharacter]()
    
    override func sceneDidLoad() {
        
        // init
        self.lastUpdateTime = 0
        
        // create a demo map
        self.createMap()
        
        // add character
        self.addCharacter(position: CGPoint(x: 0, y: -500))
        
        // add goal
        let goal = SKShapeNode(circleOfRadius: 25)
        goal.fillColor = .red
        goal.position = CGPoint(x: 0, y: 500)
        self.addChild(goal)
    }
    
    func createMap() {
        print("creating map!")
        
        // add some boxes
        //self.addBox(position: CGPoint(x:0, y:0))
        //self.addBox(position: CGPoint(x:100, y:100))
        
        // add some walls
        //left 1
        var path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 400, y: 30))
        path.addLine(to: CGPoint(x: 60, y: 150))
        path.addLine(to: CGPoint(x: 0, y: 120))
        path.addLine(to: CGPoint(x: 0, y: 0))
        self.addWall(path: path, position: CGPoint(x: -300, y: -300))
        //left 2
        path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 200, y: 70))
        path.addLine(to: CGPoint(x: 200, y: 200))
        path.addLine(to: CGPoint(x: 60, y: 150))
        path.addLine(to: CGPoint(x: 0, y: 120))
        path.addLine(to: CGPoint(x: 0, y: 0))
        self.addWall(path: path, position: CGPoint(x: -300, y: 0))
        //right 1
        path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: -450, y: 30))
        path.addLine(to: CGPoint(x: -450, y: 100))
        path.addLine(to: CGPoint(x: -60, y: 70))
        path.addLine(to: CGPoint(x: -60, y: 300))
        path.addLine(to: CGPoint(x: -550, y: 500))
        path.addLine(to: CGPoint(x: -550, y: 530))
        path.addLine(to: CGPoint(x: 0, y: 400))
        path.addLine(to: CGPoint(x: 0, y: 0))
        self.addWall(path: path, position: CGPoint(x: 350, y: -100))
        //ellipsis
        path = CGMutablePath()
        path.addEllipse(in: CGRect(x: 0, y: 0, width: 100, height: 60))
        self.addWall(path: path, position: CGPoint(x: 0, y: 0))
    }
    
    // adds box sprite at position
    func addBox(position: CGPoint) {
        let newBox = SKSpriteNode(imageNamed: "Box")
        newBox.position = position
        self.addChild(newBox)
        self.map_nodes.append(newBox)
    }
    
    // adds wall at with path at position
    func addWall(path: CGPath, position: CGPoint) {
        let newWall = TWWall(path: path)
        newWall.position = position
        self.addChild(newWall)
        self.map_nodes.append(newWall)
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
