import SpriteKit

class TWLevelScene: SKScene {
    
    var background = SKSpriteNode(imageNamed: "mainBackground")
    var backButton = SKSpriteNode(imageNamed: "zurueck")
    //TODO do this in init?
    //tutorials always show didMove though...
    var levelButtons: [SKSpriteNode?] = []
    var levelLabels: [SKLabelNode?] = []
    
    override func didMove(to view: SKView) {
        
        //margins
        let marginX: CGFloat = 125.0
        let marginY: CGFloat = 200.0
        let paddingX: CGFloat = 25.0
        let paddingY: CGFloat = 25.0
        
        //buttonSize
        let buttonWidth = CGFloat((frame.size.width-marginX)/3)
        let buttonHeight = buttonWidth
        let buttonSize = CGSize(width: buttonWidth, height: buttonHeight)
        
        //background
        background.size = frame.size
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        addChild(background)
        
        //back button
        backButton.position = CGPoint(x: 0.0+marginX-25.0, y: frame.size.height-marginY+50.0)
        backButton.size = CGSize(width: 125, height: 125)
        addChild(backButton)

        //create level buttons
        for i in 0..<15 {
            
            //create the button
            let levelButton = SKSpriteNode(imageNamed: "levelButton")
            levelButton.position = CGPoint(x: CGFloat(i%3)*(buttonWidth+paddingX)+marginX, y: 800.0-CGFloat(floor(Double(i/3)))*(buttonHeight+paddingY)+marginY)
            levelButton.size = buttonSize
            
            //create the label (level number)
            let levelLabel = SKLabelNode(fontNamed: "Courier-Bold")
            levelLabel.fontSize = 100
            levelLabel.fontColor = TWPink
            levelLabel.position = levelButton.position
            levelLabel.text = String(i+1)
            //levelLabel.zPosition = 1
            levelLabel.horizontalAlignmentMode = .center
            levelLabel.verticalAlignmentMode = .center
            
            //add button and label to our arrays for future reference
            levelButtons.append(levelButton)
            levelLabels.append(levelLabel)
            
            //add button and label to the scene
            self.addChild(levelButton)
            self.addChild(levelLabel)
            
        }
 
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            
            //find out where the user clicked
            
            //user clicked on the back button
            if node == backButton {
                if view != nil {
                    
                    let transition:SKTransition = SKTransition.fade(withDuration: 1)
                    let scene:SKScene = TWMenuScene(size: self.size)
                    self.view?.presentScene(scene, transition: transition)
                    
                }
            }
            
            //user clicked on a level label on top of a level node
            if levelLabels.contains((node as? SKLabelNode)){
                
                let label = node as! SKLabelNode
                let levelToLoad = label.text
                print("Button Label clicked. Loading Level "+levelToLoad!+".")
                
                //just load our only level for now
                if view != nil {
                    
                    let transition:SKTransition = SKTransition.fade(withDuration: 1)
                    let scene:SKScene = TWGameScene(size: self.size)
                    self.view?.presentScene(scene, transition: transition)
                }
            }
            
            //user clicked on a level button (not on its label but around it)
            if levelButtons.contains((node as? SKSpriteNode)) {
                
                let button = node as! SKSpriteNode
                let levelToLoad = levelButtons.index(of: button)!+1
                print("Button clicked (around Label). Loading Level ",levelToLoad,".")
                
                //just load our only level for now
                if view != nil {
                    
                    let transition:SKTransition = SKTransition.fade(withDuration: 1)
                    let scene:SKScene = TWGameScene(size: self.size)
                    self.view?.presentScene(scene, transition: transition)
                }
            }
        }
    }
}
