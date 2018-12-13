//
//  TWGameScene.swift
//  towerwars
//
//  Created by Anton Begehr on 28.09.18.
//  Copyright © 2018 Anton Begehr. All rights reserved.
//

import SpriteKit
import GameplayKit

// colors
var TWPink = UIColor(red: 0.9804, green: 0.0196, blue: 1, alpha: 1.0) /* #fa05ff */
var TWBlue = UIColor(red: 0.0196, green: 0.149, blue: 1, alpha: 1.0) /* #0526ff */

// size measure
var w: CGFloat {
    return (UIScreen.main.bounds.width + UIScreen.main.bounds.height) * 0.05
}

class TWGameScene: SKScene, SKPhysicsContactDelegate {
    
    private var lastUpdateTime : TimeInterval = 0
    
    // Game over detection
    var gameOver = false
    var playTime: Int = 0
    
    // entity manager
    var entityManager: TWEntityManager!
    
    // map
    var map: TWMap!
    
    // coins
    let coin1Label = SKLabelNode(fontNamed: "Courier-Bold")
    
    override init(size: CGSize) {
        super.init(size: size)
        
        // init
        self.lastUpdateTime = 0
        
        // settings
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        // entity manager
        entityManager = TWEntityManager(scene: self)
        
        //temporarly disabled a few blocks to
        //make working on the matrix map creation easier
        //also changed all Y-coordinates to be a multiple of 70
        
        // create map
        var blocks_at: [[Int]] = []
        
        blocks_at = [
            [1,1,1,1,1,0,0,0,0],
            [1,0,0,0,0,0,0,0,0],
            [1,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0],
            [0,0,0,0,1,1,1,0,0],
            [0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,1],
            [0,0,0,0,0,0,0,1,1]
        ]
        
        /************
        // top row (right)
        /*blocks_at.append(CGPoint(x: 120, y: 400))
        blocks_at.append(CGPoint(x: 200, y: 330))
        blocks_at.append(CGPoint(x: 280, y: 260))*/
        // top row 2 (left)
        blocks_at.append(CGPoint(x: 70, y: 210))
        blocks_at.append(CGPoint(x: 0, y: 210))
        blocks_at.append(CGPoint(x: -70, y: 210))
        blocks_at.append(CGPoint(x: -140, y: 210))
        blocks_at.append(CGPoint(x: -210, y: 210))
        blocks_at.append(CGPoint(x: -280, y: 210))
        // middle row (right)
        /*blocks_at.append(CGPoint(x: -240, y: 40))
        blocks_at.append(CGPoint(x: -240, y: -40))*/
        blocks_at.append(CGPoint(x: -70, y: 0))
        blocks_at.append(CGPoint(x: 0, y: 0))
        blocks_at.append(CGPoint(x: 70, y: 0))
        blocks_at.append(CGPoint(x: 140, y: 0))
        blocks_at.append(CGPoint(x: 210, y: 0))
        blocks_at.append(CGPoint(x: 280, y: 0))
        // bottom row (left)
        blocks_at.append(CGPoint(x: 70, y: -210))
        blocks_at.append(CGPoint(x: -0, y: -210))
        blocks_at.append(CGPoint(x: -70, y: -210))
        blocks_at.append(CGPoint(x: -140, y: -210))
        blocks_at.append(CGPoint(x: -210, y: -210))
        blocks_at.append(CGPoint(x: -280, y: -210))
        // bottom row 2 (right)
        blocks_at.append(CGPoint(x: -140, y: -420))
        blocks_at.append(CGPoint(x: -70, y: -420))
        blocks_at.append(CGPoint(x: 0, y: -420))
        blocks_at.append(CGPoint(x: 70, y: -420))
        blocks_at.append(CGPoint(x: 140, y: -420))
        blocks_at.append(CGPoint(x: 210, y: -420))
        blocks_at.append(CGPoint(x: 280, y: -420))
        //testing blocks
        blocks_at.append(CGPoint(x: 280, y: -350))
        blocks_at.append(CGPoint(x: 280, y: -280))
        blocks_at.append(CGPoint(x: 280, y: -210))
        blocks_at.append(CGPoint(x: 280, y: -140))
        blocks_at.append(CGPoint(x: 280, y: -70))
        blocks_at.append(CGPoint(x: 280, y: 0))
        blocks_at.append(CGPoint(x: 280, y: 70))
        blocks_at.append(CGPoint(x: 280, y: 140))
        blocks_at.append(CGPoint(x: 280, y: 210))
        blocks_at.append(CGPoint(x: 280, y: 280))
        blocks_at.append(CGPoint(x: 280, y: 350))
        blocks_at.append(CGPoint(x: 280, y: 420))

        **************/


        map = TWMap(scene: self, user_castle_at: CGPoint(x: 0, y: -600), enemy_castles_at: [CGPoint(x: 0, y: 600)], blocks_at: blocks_at, entityManager: entityManager)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        
        //physics changes
        physicsWorld.contactDelegate = self
        
        // score timer
        self.startTimer()
        
        //coin label
        let coin1 = SKSpriteNode(imageNamed: "coin")
        let margin = CGFloat(90)
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
    
    func startTimer(){
        _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.playTime += 1
        }
    }
    
    //MARK: Menu
    
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
    
    //MARK: Touches
    
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
    
    //MARK: physicsBody contact
    
    func didBegin(_ contact: SKPhysicsContact) {
        // get range and inRange nodes
        if let rangeNode = contact.bodyA.node, let inRangeNode = contact.bodyB.node {
            // get range and inRange entities
            if let rangeEntity = rangeNode.userData?["entity"] as? GKEntity, let inRangeEntity = inRangeNode.userData?["entity"] as? GKEntity {
                // get rangeComponent
                if let rangeComponent = rangeEntity.component(ofType: TWRangeComponent.self) {
                    // add entity to range
                    rangeComponent.addToRange(entity: inRangeEntity)
                }
            }
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        // get range and inRange nodes
        if let rangeNode = contact.bodyA.node, let inRangeNode = contact.bodyB.node {
            // get range and inRange entities
            if let rangeEntity = rangeNode.userData?["entity"] as? GKEntity, let inRangeEntity = inRangeNode.userData?["entity"] as? TWTower {
                // get rangeComponent
                if let rangeComponent = rangeEntity.component(ofType: TWRangeComponent.self) {
                    // remove entity from Range
                    rangeComponent.removeFromRange(entity: inRangeEntity)
                }
            }
        }
    }
    
    //MARK: update
    
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
    
}

