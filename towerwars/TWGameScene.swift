//
//  TWGameScene.swift
//  towerwars
//
//  Created by Anton Begehr on 28.09.18.
//  Copyright © 2018 Anton Begehr. All rights reserved.
//

import SpriteKit
import GameplayKit

/*func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

func pointFromGKGraphNode2D(graphnode: GKGraphNode2D) -> CGPoint {
    return CGPoint(x: CGFloat(graphnode.position.x), y: CGFloat(graphnode.position.y))
}

func pathFromArrayOfGKGraphNode2D(array: [GKGraphNode2D]) -> CGPath {
    let path = CGMutablePath()
    
    if (array.count > 0) {
        // go to start
        let start = pointFromGKGraphNode2D(graphnode: array[0])
        path.move(to: CGPoint(x: 0, y: 0))
        // build path
        array.dropFirst().forEach { graphnode in
            path.addLine(to: pointFromGKGraphNode2D(graphnode: graphnode)-start)
        }
    }
    
    return path
}*/

class TWGameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    
    private var map_nodes = [SKNode]()
    private var creeps = [TWCreep]()
    
    override func sceneDidLoad() {
        
        // init
        self.lastUpdateTime = 0
        
        // physics settings
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        // create a demo map
        self.createMap()
        
        // create obstacle graph
        let obstacles = SKNode.obstacles(fromNodePhysicsBodies: self.map_nodes)
        let obstacle_graph = GKObstacleGraph(obstacles: obstacles, bufferRadius: 30)
        // add spawn and goal
        let spawn_graphnode = GKGraphNode2D(point: vector_float2(0, -500))
        let goal_graphnode = GKGraphNode2D(point: vector_float2(0, 500))
        obstacle_graph.connectUsingObstacles(node: spawn_graphnode)
        obstacle_graph.connectUsingObstacles(node: goal_graphnode)
        
        // find path
        let traversal_nodes = obstacle_graph.findPath(from: spawn_graphnode, to: goal_graphnode) as! [GKGraphNode2D]
        print("traversal_nodes: ", traversal_nodes)
        
        // visulalize traversal_nodes
        for traversal_node in traversal_nodes {
            let node = SKShapeNode(circleOfRadius: 5)
            node.position = CGPoint(x: CGFloat(traversal_node.position.x), y: CGFloat(traversal_node.position.y))
            node.fillColor = .red
            self.addChild(node)
        }
        
        // 1. send creeps through path using SKAction
        /*let traversal_cgpath = pathFromArrayOfGKGraphNode2D(array: traversal_nodes)
        print("traversal_cgpath: ", traversal_path)
         
        let action = SKAction.follow(traversal_cgpath, speed: 100)
        let moveTo_spawn = SKAction.move(to: CGPoint(x: 0, y: -500), duration: 1)
        let moveTo_goal = SKAction.move(to: CGPoint(x: 0, y: 500), duration: 1)
        let action_repeated = SKAction.repeatForever(SKAction.sequence([moveTo_spawn, action, moveTo_goal, action.reversed()]))
        print("action_repeated: ", action_repeated)
         
        self.creeps.forEach { creep in
            creep.run(action_repeated)
        }*/
        
        // 2. send creeps through path using GameplayKit Agents, Behaviors, and Goals
        //let traversal_path = GKPath(graphNodes: traversal_nodes, radius: 10)
        let traversal_path = GKPath(points: [float2(0, 0), float2(000, 300)], radius: 10, cyclical: true)
        print("traversal_path: ", traversal_path)
        
        // use a different path for testing
        
        
        // add creep
        self.addCreep(position: CGPoint(x: 0, y: -500), path: traversal_path)
    }
    
    func createMap() {
        print("creating map!")
        
        // add some boxes
        //self.addBox(position: CGPoint(x:0, y:0))
        //self.addBox(position: CGPoint(x:100, y:100))
        
        // walls
        //var path = CGMutablePath()
        
        // add border walls
        /*
        //left
        path = CGMutablePath()
        path.move(to: CGPoint(x: -300, y: -700))
        path.addLine(to: CGPoint(x: -300, y: 700))
        path.addLine(to: CGPoint(x: -600, y: 700))
        path.addLine(to: CGPoint(x: -600, y: -700))
        path.addLine(to: CGPoint(x: -300, y: -700))
        self.addWall(path: path)
        //right
        path = CGMutablePath()
        path.move(to: CGPoint(x: 300, y: -700))
        path.addLine(to: CGPoint(x: 300, y: 700))
        path.addLine(to: CGPoint(x: 600, y: 700))
        path.addLine(to: CGPoint(x: 600, y: -700))
        path.addLine(to: CGPoint(x: 300, y: -700))
        self.addWall(path: path)
        //top
        path = CGMutablePath()
        path.move(to: CGPoint(x: 400, y: 700))
        path.addLine(to: CGPoint(x: 400, y: 1000))
        path.addLine(to: CGPoint(x: -400, y: 1000))
        path.addLine(to: CGPoint(x: -400, y: 700))
        path.addLine(to: CGPoint(x: 400, y: 700))
        self.addWall(path: path)
        //bottom
        path = CGMutablePath()
        path.move(to: CGPoint(x: 400, y: -700))
        path.addLine(to: CGPoint(x: 400, y: -1000))
        path.addLine(to: CGPoint(x: -400, y: -1000))
        path.addLine(to: CGPoint(x: -400, y: -700))
        path.addLine(to: CGPoint(x: 400, y: -700))
        self.addWall(path: path)
        */
        
        // add some game wall polygons
        /*
        //left 1
        path = CGMutablePath()
        path.move(to: CGPoint(x: -300, y: -300))
        path.addLine(to: CGPoint(x: 100, y: -270))
        path.addLine(to: CGPoint(x: 100, y: -200))
        path.addLine(to: CGPoint(x: -240, y: -150))
        path.addLine(to: CGPoint(x: -300, y: -180))
        path.addLine(to: CGPoint(x: -300, y: -300))
        self.addWall(path: path)
        //left 2
        path = CGMutablePath()
        path.move(to: CGPoint(x: -300, y: 100))
        path.addLine(to: CGPoint(x: 100, y: 170))
        path.addLine(to: CGPoint(x: 100, y: 200))
        //path.addLine(to: CGPoint(x: -240, y: 150)) //concave
        path.addLine(to: CGPoint(x: -240, y: 230)) //convex
        path.addLine(to: CGPoint(x: -300, y: 220))
        path.addLine(to: CGPoint(x: -300, y: 100))
        self.addWall(path: path) // notice: pathfinding does not seem to work correctly with concave shapes
        //right 1
        path = CGMutablePath()
        path.move(to: CGPoint(x: 300, y: -100))
        path.addLine(to: CGPoint(x: -100, y: -70))
        path.addLine(to: CGPoint(x: -100, y: 0))
        path.addLine(to: CGPoint(x: 300, y: -30))
        /*path.addLine(to: CGPoint(x: 290, y: 200))
        path.addLine(to: CGPoint(x: 200, y: 400))
        path.addLine(to: CGPoint(x: 200, y: 430))
        path.addLine(to: CGPoint(x: 350, y: 300))*/
        path.addLine(to: CGPoint(x: 300, y: -100))
        self.addWall(path: path)
        */
        
        // add some game walls
        // left 1
        self.addWall(position: CGPoint(x: 0, y: -200))
        self.addWall(position: CGPoint(x: -50, y: -200))
        self.addWall(position: CGPoint(x: -100, y: -200))
        self.addWall(position: CGPoint(x: -150, y: -200))
        self.addWall(position: CGPoint(x: -200, y: -200))
        self.addWall(position: CGPoint(x: -250, y: -200))
        // left 2
        self.addWall(position: CGPoint(x: 0, y: 200))
        self.addWall(position: CGPoint(x: -50, y: 200))
        self.addWall(position: CGPoint(x: -100, y: 200))
        self.addWall(position: CGPoint(x: -150, y: 200))
        self.addWall(position: CGPoint(x: -200, y: 200))
        self.addWall(position: CGPoint(x: -250, y: 200))
        // right 1
        self.addWall(position: CGPoint(x: 0, y: 0))
        self.addWall(position: CGPoint(x: 50, y: 0))
        self.addWall(position: CGPoint(x: 100, y: 0))
        self.addWall(position: CGPoint(x: 150, y: 0))
        self.addWall(position: CGPoint(x: 200, y: 0))
        self.addWall(position: CGPoint(x: 250, y: 0))
        // top 1
        self.addWall(position: CGPoint(x: 50, y: 350))
    }
    
    // adds wall at position
    func addWall(position: CGPoint) {
        let newWall = TWWall(position: position)
        self.addChild(newWall)
        self.map_nodes.append(newWall)
    }
    
    // adds wall polygon at with path at position
    func addWallPolygon(path: CGPath) {
        let newWallPolygon = TWWallPolygon(path: path)
        self.addChild(newWallPolygon)
        self.map_nodes.append(newWallPolygon)
    }
    
    // adds creep at position
    func addCreep(position: CGPoint, path: GKPath) {
        let newCreep = TWCreep(position: position, path: path)
        self.addEntity(newCreep)
        //TODO: how to add entities to scene?
        self.creeps.append(newCreep)
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
