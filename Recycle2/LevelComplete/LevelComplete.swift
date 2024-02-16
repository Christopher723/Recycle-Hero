//
//  LevelSelect.swift
//  Recylce2
//
//  Created by Christopher Woods on 1/22/24.
//

import SpriteKit



class LevelComplete: SKScene{
    
    var youDidIt: SKSpriteNode!
    var playAgain: SKSpriteNode!
    var levelSelectButton: SKSpriteNode!
    var starNode1: SKSpriteNode!
    var starNode2: SKSpriteNode!
    var starNode3: SKSpriteNode!
    static var starAmount: Int = 3
    
    
    
    func addStar(myName: inout SKSpriteNode!, name: String, x: Int, y: Int) {
        myName = SKSpriteNode(imageNamed: "Star")
        myName.position = CGPoint(x: x, y:y)
        myName.setScale(0.05)
        myName.zPosition = 20
        myName.name = name
        addChild(myName)
    }
    
    func starPlacement(amount: Int){
        if amount == 1{
            addStar(myName: &starNode1, name: "starNode2", x: Int(frame.width) / 2 , y: 675)
        }
        if amount == 2{
            addStar(myName: &starNode1, name: "starNode1", x: Int(frame.width) / 2 + 50 , y: 675)
            addStar(myName: &starNode1, name: "starNode3", x: Int(frame.width) / 2 - 50, y: 675)
        }
        if amount == 3{
            addStar(myName: &starNode1, name: "starNode1", x: Int(frame.width) / 2 + 100 , y: 675)
            addStar(myName: &starNode1, name: "starNode2", x: Int(frame.width) / 2 , y: 675)
            addStar(myName: &starNode1, name: "starNode3", x: Int(frame.width) / 2 - 100, y: 675)
        }
        
    }
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor(red: 145/255, green: 217/255, blue: 255/255, alpha: 1.0)
        
    
        starPlacement(amount: LevelComplete.starAmount)
        
        youDidIt = SKSpriteNode(imageNamed: "YouDidIt")
        youDidIt.position = CGPoint(x: frame.width/2, y:frame.height / 1.5)
        youDidIt.zPosition = 20
        youDidIt.name = "youDidIt"
        
        
        
        playAgain = SKSpriteNode(imageNamed: "PlayAgain")
        playAgain.position = CGPoint(x: frame.width / 2, y:frame.height / 4)
        playAgain.zPosition = 20
        playAgain.name = "playAgain"
        
        
        levelSelectButton = SKSpriteNode(imageNamed: "Next")
        levelSelectButton.position = CGPoint(x: frame.width/2, y:frame.height / 9)
        levelSelectButton.zPosition = 20
        levelSelectButton.name = "nextButton"
      
        
        
        
        
        addChild(levelSelectButton)
        addChild(youDidIt)
        addChild(playAgain)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let location = touch?.location(in: self){
            let nodesArray = self.nodes(at: location)
            if nodesArray.first?.name == "nextButton"{
                let worldSelect = WorldSelect(size: self.size)
                self.view?.presentScene(worldSelect)
            }
            
            else if nodesArray.first?.name == "playAgain"{
                let gameScene = GameScene(size: self.size)
                self.view?.presentScene(gameScene)
            }
        }
        
        
        
        
    }
}
