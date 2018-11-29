//
//  TWGameScene.swift
//  towerwars
//
//  Created by Anton Begehr on 28.09.18.
//  Copyright © 2018 Anton Begehr. All rights reserved.
//

import SpriteKit
import GameplayKit

//colors
var TWPink = UIColor(red: 0.9804, green: 0.0196, blue: 1, alpha: 1.0) /* #fa05ff */
var TWBlue = UIColor(red: 0.0196, green: 0.149, blue: 1, alpha: 1.0) /* #0526ff */

class TWGameScene: SKScene, SKPhysicsContactDelegate {
    
    private var lastUpdateTime : TimeInterval = 0
    
    // Game over detection
    var gameOver = false
    var playTime: Int = 0
    
    // entity manager
    var entityManager: TWEntityManager!
    
    // map
    var map: TWMap!
    
    //coins
    let coin1Label = SKLabelNode(fontNamed: "Courier-Bold")
    let margin = CGFloat(90)
    
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
        // top row
        blocks_at.append(CGPoint(x: 70, y: 200))
        blocks_at.append(CGPoint(x: 0, y: 200))
        blocks_at.append(CGPoint(x: -70, y: 200))
        blocks_at.append(CGPoint(x: -140, y: 200))
        blocks_at.append(CGPoint(x: -210, y: 200))
        blocks_at.append(CGPoint(x: -280, y: 200))
        // middle row
        blocks_at.append(CGPoint(x: -70, y: 0))
        blocks_at.append(CGPoint(x: 0, y: 0))
        blocks_at.append(CGPoint(x: 70, y: 0))
        blocks_at.append(CGPoint(x: 140, y: 0))
        blocks_at.append(CGPoint(x: 210, y: 0))
        blocks_at.append(CGPoint(x: 280, y: 0))
        // bottom row
        blocks_at.append(CGPoint(x: 70, y: -200))
        blocks_at.append(CGPoint(x: -0, y: -200))
        blocks_at.append(CGPoint(x: -70, y: -200))
        blocks_at.append(CGPoint(x: -140, y: -200))
        blocks_at.append(CGPoint(x: -210, y: -200))
        blocks_at.append(CGPoint(x: -280, y: -200))
        //other
        blocks_at.append(CGPoint(x: 60, y: 350))
        
        map = TWMap(scene: self, user_castle_at: CGPoint(x: 0, y: -600), enemy_castles_at: [CGPoint(x: 0, y: 600)], blocks_at: blocks_at, entityManager: entityManager)
        
        self.startTimer()
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
    
    func showRestartMenu(_ won: Bool) {
        
        if gameOver {
            return;
        }
        gameOver = true
        
        let message = won ? "You win" : "Game Over."
        
        //"message" label always exists
        let label = SKLabelNode(fontNamed: "Courier-Bold")
        label.fontSize = 90
        label.fontColor = TWBlue
        label.position = CGPoint(x: 0, y: 0)
        label.zPosition = 1
        label.verticalAlignmentMode = .center
        label.text = message
        label.setScale(0)
        addChild(label)
        
        var timeLabel: SKLabelNode?
        if !won {
            
            //"timeLabel" label only exists in case of loss
            let timeMessage = "You lasted \(self.playTime) seconds!"
            timeLabel = SKLabelNode(fontNamed: "Courier-Bold")
            
            if let timeLabel = timeLabel {
                timeLabel.fontSize = 40
                timeLabel.fontColor = TWPink
                timeLabel.position = CGPoint(x: 0, y: -100)
                timeLabel.zPosition = label.zPosition
                timeLabel.verticalAlignmentMode = label.verticalAlignmentMode
                timeLabel.text = timeMessage
                timeLabel.setScale(0)
                addChild(timeLabel)
            }
        }
        
        let scaleAction = SKAction.scale(to: 1.0, duration: 0.5)
        scaleAction.timingMode = SKActionTimingMode.easeInEaseOut
        label.run(scaleAction)
        timeLabel?.run(scaleAction)
        
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
        
        //coin label: the part that needs to be updated
        if let castle1 = entityManager.castleForTeam(.team1) {
            let humanCastle = castle1.component(ofType: TWCastleComponent.self) 
            coin1Label.text = "\(humanCastle!.coins)"
            
        }

    }
    
    override func didMove(to view: SKView) {
                
        //physics changes
        physicsWorld.contactDelegate = self
        
        //coin label
        let coin1 = SKSpriteNode(imageNamed: "coin")
        //coin1.position = CGPoint(x: margin + coin1.size.width/2, y: size.height - margin - coin1.size.height/2)
        coin1.position = CGPoint(x: -size.width/2 + margin, y: size.height/2 - margin)
        addChild(coin1)
        coin1Label.fontSize = 50
        coin1Label.fontColor = TWPink
        coin1Label.position = CGPoint(x: coin1.position.x + coin1.size.width/2 + 20, y: coin1.position.y)
        //coin1Label.position = CGPoint(x: -100, y: 400)
        coin1Label.zPosition = 1
        coin1Label.horizontalAlignmentMode = .left
        coin1Label.verticalAlignmentMode = .center
        coin1Label.text = "10"
        self.addChild(coin1Label)

    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        // get range nodes
        if let towerRangeNode = contact.bodyA.node, let creepNode = contact.bodyB.node {
            
            // get visual nodes
            if let towerVisualNode = towerRangeNode.parent{

                // get entities
                if let creepEntity = creepNode.userData?["entity"] as? TWCreep {
                    if let towerEntity = towerVisualNode.userData?["entity"] as? TWTower {
                    
                        // get range component
                        if let firingComponent = towerEntity.component(ofType: TWFiringComponent.self) {
                            
                            //add our creep to the array
                            firingComponent.addCreepToRange(creep: creepEntity)
                            
                        }
                    }
                }
            }
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        // get range nodes
        if let towerRangeNode = contact.bodyA.node, let creepNode = contact.bodyB.node {
            
            // get visual nodes
            if let towerVisualNode = towerRangeNode.parent{
                
                // get entities
                if let creepEntity = creepNode.userData?["entity"] as? TWCreep {
                    if let towerEntity = towerVisualNode.userData?["entity"] as? TWTower {
                        
                        // get range component
                        if let firingComponent = towerEntity.component(ofType: TWFiringComponent.self) {
                            firingComponent.removeCreepFromRange(creep: creepEntity)
                        }
                    }
                }
            }
        }
    }
    
    func startTimer(){
        _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.playTime += 1
        }
    }
    
}

