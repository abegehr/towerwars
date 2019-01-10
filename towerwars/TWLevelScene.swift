import SpriteKit

class TWLevelScene: SKScene {
    
    var background = SKSpriteNode(imageNamed: "mainBackground")
    var backButton = SKSpriteNode(imageNamed: "zurueck")
    //TODO do this in init?
    //tutorials always show didMove though...
    var levelButtons: [SKSpriteNode?] = []
    
    //margins
    let marginX: CGFloat = 125.0
    let marginY: CGFloat = 200.0
    
    override func didMove(to view: SKView) {
       
        //background
        background.size = frame.size
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        addChild(background)
        
        //back button
        backButton.position = CGPoint(x: 0.0+marginX-25.0, y: frame.size.height-marginY+50.0)
        backButton.size = CGSize(width: 125, height: 125)
        addChild(backButton)

        //not that good yet, 2 and 4 look pretty awkward
        self.creatLevelButtonGrid(levels: 15, buttonsPerRow: 3)
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
            
            print("clicked: ", node)
            
            
            //user clicked on a level button (not on its label but around it)
            if levelButtons.contains((node as? SKSpriteNode)) || levelButtons.contains((node.parent as? SKSpriteNode)) {
                
                var button: SKSpriteNode

                //quickly check if we need to access the button as a parent
                //this is the case when the user clicks on the label on top of the button
                if levelButtons.contains((node.parent as? SKSpriteNode)) {
                    
                    button = node.parent as! SKSpriteNode
                    
                } else {
                    
                    button = node as! SKSpriteNode
                }
                
                let levelToLoad = button.name
                print("Loading Level "+levelToLoad!+"...")
                
                //just load our only level for now
                if view != nil {
                    
                    let transition:SKTransition = SKTransition.fade(withDuration: 1)
                    let scene:SKScene = TWGameScene(size: self.size)
                    self.view?.presentScene(scene, transition: transition)
                }
            }
        }
    }
    
    func creatLevelButtonGrid(levels: Int, buttonsPerRow: Int) {
        
        //paddings
        let paddingX: CGFloat = 25.0*CGFloat(3/buttonsPerRow)
        let paddingY: CGFloat = paddingX
        
        //buttonSize
        let buttonWidth = CGFloat((frame.size.width-marginX)/CGFloat(buttonsPerRow))
        let buttonHeight = buttonWidth
        let buttonSize = CGSize(width: buttonWidth, height: buttonHeight)
        
        //create level buttons
        for i in 0..<levels {
            
            //create the button
            let levelButton = SKSpriteNode(imageNamed: "levelButton")
            levelButton.position = CGPoint(x: CGFloat(i%buttonsPerRow)*(buttonWidth+paddingX)+marginX, y: 800.0-CGFloat(floor(Double(i/buttonsPerRow)))*(buttonHeight+paddingY)+marginY)
            levelButton.size = buttonSize
            levelButton.name = String(i+1)
            
            //create the label (level number)
            let levelLabel = SKLabelNode(fontNamed: "Courier-Bold")
            levelLabel.fontSize = 100
            levelLabel.fontColor = TWPink
            levelLabel.position = CGPoint(x: 0.0, y: 0.0)
            levelLabel.text = String(i+1)
            levelLabel.horizontalAlignmentMode = .center
            levelLabel.verticalAlignmentMode = .center
            
            //add button to the array for future reference
            levelButtons.append(levelButton)
            
            //add button and label to the scene
            self.addChild(levelButton)
            levelButton.addChild(levelLabel)
            
            //modify zPosition to counter irregularity in nodes showing up
            levelButton.zPosition = 2.0
            levelLabel.zPosition = 1.0
            backButton.zPosition = 1.0
        }
        
    }
}
