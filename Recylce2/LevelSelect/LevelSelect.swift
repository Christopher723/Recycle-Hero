//
//  LevelSelect.swift
//  Recylce2
//
//  Created by Christopher Woods on 1/22/24.
//

import SpriteKit

class LevelSelect: SKScene{
    var levelOneNode: SKSpriteNode!
    var levelOneTextNode: SKSpriteNode!
    var levelTwoNode: SKSpriteNode!
    var levelThreeNode: SKSpriteNode!
    var levelFourNode: SKSpriteNode!
    var levelFiveNode: SKSpriteNode!
    
    
    var levelSelect: SKSpriteNode!
    var levelNode: SKSpriteNode!
    
    
    
    override func didMove(to view: SKView) {
       
        
        self.backgroundColor = UIColor(red: 145/255, green: 217/255, blue: 255/255, alpha: 1.0)
        
        
        levelSelect = SKSpriteNode(imageNamed: "LevelSelect")
        levelSelect.position = CGPoint(x: frame.width/2, y:frame.height / 1.15)
        levelSelect.zPosition = 20
        levelSelect.name = "levelSelect"
      
        
        
     
        
        
        func generateNodes(myName: inout SKSpriteNode!, name: String, x: CGFloat, y: CGFloat, levelText: Int = 0){
            myName = SKSpriteNode(imageNamed: "LevelNode")
            myName.position = CGPoint(x: x, y: y)
            myName.zPosition = 20
            myName.name = name
            addChild(myName)
            
            if levelText == 1{
                let myText = SKSpriteNode(imageNamed: "1-1")
                myText.position = CGPoint(x: x, y: y - 72)
                myText.zPosition = 20
                myText.name = name
                addChild(myText)
            }
            else{
                let myNoText = SKSpriteNode(imageNamed: "TBA")
                myNoText.position = CGPoint(x: x, y: y)
                myNoText.zPosition = 21
                myNoText.name = name
                addChild(myNoText)
            }
                
            
        }
        
        generateNodes(myName: &levelOneNode, name: "levelOneNode", x: frame.width / 5, y: frame.height / 1.4, levelText: 1)
        generateNodes(myName: &levelTwoNode, name: "levelTwoNode", x: frame.width / 2, y: frame.height / 1.4)
        generateNodes(myName: &levelThreeNode, name: "levelThreeNode", x: frame.width / 1.25, y: frame.height / 1.4)
        generateNodes(myName: &levelFourNode, name: "levelFourNode", x: frame.width / 2.9, y: frame.height / 1.82)
        generateNodes(myName: &levelFiveNode, name: "levelFiveNode", x: frame.width / 1.52, y: frame.height / 1.82)
    
//        levelOneNode = SKSpriteNode(color: UIColor.blue, size: CGSize(width: 40, height: 40))
//       levelOneNode?.name = "levelOneNode"  // Set a name if needed
//       levelOneNode?.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
//        // Set physics body for collision detection
        
        
        
      
        addChild(levelSelect)
    
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let location = touch?.location(in: self){
            let nodesArray = self.nodes(at: location)
            if nodesArray.first?.name == "levelOneNode"{
                let gameScene = LevelPreview(size: self.size)
                self.view?.presentScene(gameScene)
            }
        }
        
        
        
        
    }
}
