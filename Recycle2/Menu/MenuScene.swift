//
//  MenuScene.swift
//  Recycle2
//
//  Created by Christopher Woods on 1/22/24.
//

import SpriteKit

class MenuScene: SKScene{
    var crane: SKSpriteNode!
    var RecycleHeros: SKSpriteNode!
    var startButton: SKSpriteNode!
    var cloudNode1: SKSpriteNode!
    var cloudNode2: SKSpriteNode!
    var cloudNode3: SKSpriteNode!
    var cloudNode4: SKSpriteNode!
    var spaceShipNode: SKSpriteNode!
    
    func generateCloud(myName: inout SKSpriteNode!, imageName: String,
                       setScale: CGFloat = 1, x: Int, y: Int, x2: CGFloat,
                       duration: CGFloat) {
        let moveLeft = SKAction.moveTo(x: -100, duration: duration)
        let respawn = SKAction.moveTo(x: x2, duration: 0)
        _ = SKAction.wait(forDuration: 1.1)
        let remove = SKAction.removeFromParent()
        let moveSequence = SKAction.sequence([moveLeft, respawn])
        myName = SKSpriteNode(imageNamed: imageName)
        myName.setScale(setScale)
        myName.position = CGPoint(x: x, y:y)
        myName.zPosition = 1
        addChild(myName)
        myName.run(SKAction.repeatForever(moveSequence))
    }
    
    func spawnShip(myName: inout SKSpriteNode!, imageName: String, 
                   setScale: CGFloat = 1, x: Int, y: Int, x2: CGFloat,
                   duration: CGFloat) {
        let moveLeft = SKAction.moveTo(x: -100, duration: duration)
        let respawn = SKAction.moveTo(x: x2, duration: 0)
        _ = SKAction.wait(forDuration: 10.0)
        let wait = SKAction.wait(forDuration: 10.0)
        let remove = SKAction.removeFromParent()
        let moveSequence = SKAction.sequence([wait, moveLeft, respawn])
        myName = SKSpriteNode(imageNamed: imageName)
        myName.setScale(setScale)
        myName.position = CGPoint(x: x, y:y)
        myName.zPosition = 1
        addChild(myName)
        myName.run(SKAction.repeatForever(moveSequence))
    }
    
    
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor(red: 145/255, green: 217/255, blue: 255/255, alpha: 1.0)
        generateCloud(myName: &cloudNode1, imageName: "Cloud1", x: 50, y: 500, x2: 500, duration: 50)
        generateCloud(myName: &cloudNode2, imageName: "Cloud2", x: 100, y: 700, x2: 600, duration: 60)
        generateCloud(myName: &cloudNode3, imageName: "Cloud3", x: 300, y: 750, x2: 650, duration: 70)
        generateCloud(myName: &cloudNode4, imageName: "Cloud4", x: 300, y: 600, x2: 700, duration: 90)
        generateCloud(myName: &cloudNode1, imageName: "Cloud1", x: 500, y: 500, x2: 500, duration: 50)
        generateCloud(myName: &cloudNode2, imageName: "Cloud2", x: 600, y: 700, x2: 600, duration: 60)
        generateCloud(myName: &cloudNode3, imageName: "Cloud3", x: 600, y: 750, x2: 650, duration: 70)
        generateCloud(myName: &cloudNode4, imageName: "Cloud4", x: 700, y: 600, x2: 700, duration: 90)
        spawnShip(myName: &spaceShipNode, imageName: "AlienShip", setScale: 0.2, x: 570 , y: 670, x2: 500, duration: 20)
        RecycleHeros = SKSpriteNode(imageNamed: "RecycleHeroText")
        RecycleHeros.position = CGPoint(x: frame.width/2, y:frame.height/1.3)
        RecycleHeros.zPosition = 20
        RecycleHeros.name = "recycleHeroText"
        startButton = SKSpriteNode(imageNamed: "Start")
        startButton.position = CGPoint(x: self.size.width / 2, y: frame.height / 9.5)
        startButton.zPosition = 20
        startButton.name = "startButton"
        crane = SKSpriteNode(imageNamed: "Crane")
        crane.setScale(1)
        crane.position = CGPoint(x: self.size.width / 3.7, y: self.size.height / 5)
        crane.zPosition = 21
        crane.name = "crane"
        addChild(startButton)
        addChild(RecycleHeros)
        addChild(crane)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let location = touch?.location(in: self){
            let nodesArray = self.nodes(at: location)
            if nodesArray.first?.name == "startButton"{
                let worldSelect = WorldSelect(size: self.size)
                self.view?.presentScene(worldSelect)
            }
        }
    }
    
}
