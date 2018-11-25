//
//  TWGameScene.swift
//  towerwars
//
//  Created by Anton Begehr on 28.09.18.
//  Copyright © 2018 Anton Begehr. All rights reserved.
//

import SpriteKit
import GameplayKit

class TWGameScene: SKScene, SKPhysicsContactDelegate {
    
    private var lastUpdateTime : TimeInterval = 0
    
    // Game over detection
    var gameOver = false
    
    // entity manager
    var entityManager: TWEntityManager!
    
    // map
    var map: TWMap!
    
    override init(size: CGSize) {
        super.init(size: size)
        
        // init
        self.lastUpdateTime = 0
        
        // settings
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        // entity manager
        entityManager = TWEntityManager(scene: self)
        
        // create map
        var blocks_at: [CGPoint] = []
        blocks_at.append(CGPoint(x: 0, y: -200))
        blocks_at.append(CGPoint(x: -50, y: -200))
        blocks_at.append(CGPoint(x: -100, y: -200))
        blocks_at.append(CGPoint(x: -150, y: -200))
        blocks_at.append(CGPoint(x: -200, y: -200))
        blocks_at.append(CGPoint(x: -250, y: -200))
        blocks_at.append(CGPoint(x: 0, y: 200))
        blocks_at.append(CGPoint(x: -50, y: 200))
        blocks_at.append(CGPoint(x: -100, y: 200))
        blocks_at.append(CGPoint(x: -150, y: 200))
        blocks_at.append(CGPoint(x: -200, y: 200))
        blocks_at.append(CGPoint(x: -250, y: 200))
        blocks_at.append(CGPoint(x: 0, y: 0))
        blocks_at.append(CGPoint(x: 50, y: 0))
        blocks_at.append(CGPoint(x: 100, y: 0))
        blocks_at.append(CGPoint(x: 150, y: 0))
        blocks_at.append(CGPoint(x: 200, y: 0))
        blocks_at.append(CGPoint(x: 250, y: 0))
        blocks_at.append(CGPoint(x: 50, y: 350))
        
        map = TWMap(scene: self, user_castle_at: CGPoint(x: 0, y: -600), enemy_castles_at: [CGPoint(x: 0, y: 600)], blocks_at: blocks_at, entityManager: entityManager)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sceneDidLoad() {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (touches.first == nil) {
            return
        }
        
        if gameOver {
            let newScene = TWGameScene(size: size)
            newScene.scaleMode = scaleMode
            view?.presentScene(newScene, transition: SKTransition.flipHorizontal(withDuration: 0.5))
            return
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for _ in touches {
            map.enemy_castles.forEach { enemy_caste in
                if let enemy_castle_component = enemy_caste.component(ofType: TWCastleComponent.self) {
                    enemy_castle_component.spawnCreep()
                }
            }
        }
    }
    
    func showRestartMenu(_ won: Bool) {
        
        if gameOver {
            return;
        }
        gameOver = true
        
        let message = won ? "You win" : "You lose"
        
        let label = SKLabelNode(fontNamed: "Courier-Bold")
        label.fontSize = 100
        label.fontColor = SKColor.black
        label.position = CGPoint(x: 0, y: 0)
        label.zPosition = 1
        label.verticalAlignmentMode = .center
        label.text = message
        label.setScale(0)
        addChild(label)
        
        let scaleAction = SKAction.scale(to: 1.0, duration: 0.5)
        scaleAction.timingMode = SKActionTimingMode.easeInEaseOut
        label.run(scaleAction)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        self.lastUpdateTime = currentTime
        
        // update entity manager
        entityManager.update(dt)
        
        // Check for game over
        if let castle1 = entityManager.castleForTeam(.team1),
            let castle1HealthComponent = castle1.component(ofType: TWHealthComponent.self) {
            if (castle1HealthComponent.health <= 0) {
                showRestartMenu(false)
            }
        }
        if let castle2 = entityManager.castleForTeam(.team2),
            let castle2HealthComponent = castle2.component(ofType: TWHealthComponent.self) {
            if (castle2HealthComponent.health <= 0) {
                showRestartMenu(true)
            }
        }
    }
    
    override func didMove(to view: SKView) {
                
        //physics changes
        physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        entityManager = TWEntityManager(scene: self)
        //building tower
        entityManager.buildTower(type: "arrow", posX: 0.0, posY: 0.0, team: Team(rawValue: 1)!)

    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        // get range nodes
        if let towerNode2 = contact.bodyA.node, let creepNode2 = contact.bodyB.node {
            print("creep entered range")
            
            // get visual nodes
            if let towerNode1 = towerNode2.parent, let creepNode1 = creepNode2.parent {

                print("creepNode2: ",creepNode2)
                print("creepNode1: ",creepNode1)
                print("towerNode2: ", towerNode2)
                print("towerNode1: ",towerNode1)
                
                // get entities
                if let creepEntity = creepNode1.userData!["entity"] as? TWCreep {
                    if let towerEntity = towerNode1.userData!["entity"] as? TWTower {
                    
                        // get range component
                        if let rangeComponent = towerEntity.component(ofType: TWRangeComponent.self) {
                            
                            rangeComponent.addCreepToRange(creep: creepEntity)
                            
                        }
                    }
                    
                }
                
            }
            
        }
    }
    
}

