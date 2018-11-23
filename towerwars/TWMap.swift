//
//  TWEntityManager.swift
//  towerwars
//
//  Created by Anton Begehr on 20.11.18.
//  Copyright © 2018 Anton Begehr. All rights reserved.
//

import SpriteKit
import GameplayKit

func CGPoint_to_vector2(point: CGPoint) -> vector_float2 {
    return vector_float2(Float(point.x), Float(point.y))
}

class TWMap {
    
    static let user_castle_color: UIColor = .yellow
    static let enemy_castle_color: UIColor = .red
    
    let entityManager: TWEntityManager
    
    var user_castle: TWCastle
    var enemy_castles = [TWCastle]()
    private var border_nodes = [SKNode]()
    private var blocks = [GKEntity]()
    private var obstacle_graph: GKObstacleGraph<GKGraphNode2D>
    
    init(scene: SKScene, user_castle_at: CGPoint, enemy_castles_at: [CGPoint], blocks_at: [CGPoint], entityManager: TWEntityManager) {
        
        self.entityManager = entityManager
        
        // border
        let minX = scene.frame.minX
        let minY = scene.frame.minY
        let maxX = scene.frame.maxX
        let maxY = scene.frame.maxY
        // right border
        let right_border = SKNode()
        right_border.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: maxX, y: minY), to: CGPoint(x: maxX, y: maxY))
        scene.addChild(right_border)
        // top border
        let top_border = SKNode()
        top_border.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: minX, y: maxY), to: CGPoint(x: minX, y: maxY))
        scene.addChild(top_border)
        // left border
        let left_border = SKNode()
        left_border.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: minX, y: minY), to: CGPoint(x: minX, y: maxY))
        scene.addChild(left_border)
        // bottom border
        let bottom_border = SKNode()
        bottom_border.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: minX, y: minY), to: CGPoint(x: minX, y: minY))
        scene.addChild(bottom_border)
        // borders
        border_nodes = [right_border, top_border, left_border, bottom_border]
        
        // user_castle
        user_castle = TWCastle(color: TWMap.user_castle_color, position: user_castle_at, team: .team1, entityManager: entityManager)
        entityManager.add(user_castle)
        
        // blocks
        for block_at in blocks_at {
            let block = TWBlock(position: block_at)
            blocks.append(block)
            entityManager.add(block)
        }
        
        // obstacle graphs
        let block_nodes = blocks.map { $0.component(ofType: TWSpriteComponent.self)!.node }
        let map_nodes = block_nodes + border_nodes
        let obstacles = SKNode.obstacles(fromNodePhysicsBodies: map_nodes)
        obstacle_graph = GKObstacleGraph(obstacles: obstacles, bufferRadius: 30)
        // user castle graphnode
        let user_castle_graphnode = GKGraphNode2D(point: CGPoint_to_vector2(point: user_castle_at))
        obstacle_graph.connectUsingObstacles(node: user_castle_graphnode)
        
        // enemy castles
        for enemy_castle_at in enemy_castles_at {
            let enemy_castle = TWCastle(color: TWMap.enemy_castle_color, position: enemy_castle_at, team: .team2, entityManager: entityManager)
            
            // find creep path
            // enemy castle graphnode
            let enemy_castle_graphnode = GKGraphNode2D(point: CGPoint_to_vector2(point: enemy_castle_at))
            obstacle_graph.connectUsingObstacles(node: enemy_castle_graphnode)
            // find path nodes
            let path_nodes = obstacle_graph.findPath(from: enemy_castle_graphnode, to: user_castle_graphnode) as! [GKGraphNode2D]
            print("path_nodes: ", path_nodes)
            // path found?
            if (path_nodes.count < 2) {
                print("TWMap – Error: No path found.")
            } else {
                // convert path nodes to path
                let path = GKPath(graphNodes: path_nodes, radius: 20)
                // add TWPathComponent
                let pathComponent = TWPathComponent(path: path)
                enemy_castle.addComponent(pathComponent)
            }
            
            // add
            enemy_castles.append(enemy_castle)
            entityManager.add(enemy_castle)
        }
        
    }
    
}