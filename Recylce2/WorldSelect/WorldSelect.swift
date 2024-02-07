//
//  LevelSelect.swift
//  Recylce2
//
//  Created by Christopher Woods on 1/22/24.
//

import SpriteKit

class WorldSelect: SKScene{
    
    var worldSelect: SKSpriteNode!
    var select: SKSpriteNode!
    
    var dumpCityText: SKSpriteNode!
    var worldNode: SKSpriteNode!
    
    var townHomeText: SKSpriteNode!
    var world2Node: SKSpriteNode!
    
    var chevronRight: SKSpriteNode!
    var chevronLeft: SKSpriteNode!
    var worldPosition: [Int] = [1,2,3]
    var worldPointer = 0
    var currentWorldText: SKSpriteNode!
    var currentWorld: SKSpriteNode!
    
    
    
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor(red: 145/255, green: 217/255, blue: 255/255, alpha: 1.0)
       
        worldSelect = SKSpriteNode(imageNamed: "WorldSelect")
        worldSelect.setScale(1)
        worldSelect.position = CGPoint(x: frame.width/2, y:frame.height / 1.15)
        worldSelect.zPosition = 20
        worldSelect.name = "worldSelect"
        
       
        
        makeWorldOne()
        
        
        chevronRight = SKSpriteNode(imageNamed: "ChevronRight")
        chevronRight.position = CGPoint(x: self.size.width / 1.07, y: frame.height / 2.1)
        chevronRight.zPosition = 20
        chevronRight.name = "chevronRight"
        
        chevronLeft = SKSpriteNode(imageNamed: "ChevronLeft")
        chevronLeft.position = CGPoint(x: self.size.width / 13.7, y: frame.height / 2.1)
        chevronLeft.zPosition = 20
        chevronLeft.name = "chevronLeft"
        
        
        select = SKSpriteNode(imageNamed: "LetsGo")
        
        select.position = CGPoint(x: self.size.width / 2, y: frame.height / 9.5)
        select.zPosition = 20
        select.name = "select"
        
      
        addChild(worldSelect)
        
        addChild(chevronLeft)
        addChild(chevronRight)
        addChild(select)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let location = touch?.location(in: self){
            let nodesArray = self.nodes(at: location)
            if nodesArray.first?.name == "select"{
                let levelSelect = LevelSelect(size: self.size)
                self.view?.presentScene(levelSelect)
            }
            if nodesArray.first?.name == "chevronRight"{
                if worldPointer == 0{
                    deLoadWorld()
                    worldPointer += 1
                    pickWorld()
                }
                
                
                
                
                
            }
            if nodesArray.first?.name == "chevronLeft"{
                
                if worldPointer == 1{
                    deLoadWorld()
                    worldPointer -= 1
                    pickWorld()
                }
                
                
                
            }
        }
    }
    func deLoadWorld(){
        currentWorld.removeFromParent()
        currentWorldText.removeFromParent()
    }
    
    func makeWorldOne(){
        dumpCityText = SKSpriteNode(imageNamed: "DumpCityText")
        dumpCityText.position = CGPoint(x: frame.width/2, y:frame.height / 1.25)
        dumpCityText.zPosition = 20
        dumpCityText.name = "dumpCity"
        currentWorldText = dumpCityText
        
        worldNode = SKSpriteNode(imageNamed: "WorldNode")
        worldNode.position = CGPoint(x: self.size.width / 2, y: frame.height / 2.1)
        worldNode.zPosition = 20
        worldNode.name = "worldNode"
        currentWorld = worldNode
        
        addChild(dumpCityText)
        addChild(worldNode)
    }
    func makeWorldTwo(){
        townHomeText = SKSpriteNode(imageNamed: "TownHome")
        townHomeText.position = CGPoint(x: frame.width/2, y:frame.height / 1.25)
        townHomeText.zPosition = 20
        townHomeText.name = "townHome"
        currentWorldText = townHomeText
        
        world2Node = SKSpriteNode(imageNamed: "WorldTwo")
        world2Node.position = CGPoint(x: self.size.width / 2, y: frame.height / 2.1)
        world2Node.zPosition = 20
        world2Node.name = "world2Node"
        currentWorld = world2Node
        
        addChild(townHomeText)
        addChild(world2Node)
    }
    
    func pickWorld(){
        if worldPosition[worldPointer] == 1{
            makeWorldOne()
        }
        if worldPosition[worldPointer] == 2{
            makeWorldTwo()
        }
        if worldPosition[worldPointer] == 3{
            
        }
    }

}
