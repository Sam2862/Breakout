//
//  SolidRectangle.swift
//  MyGame
//
//  Created by ITPathways on 5/13/21.
//

import Foundation
import SpriteKit

class SolidRectangle: SKNode {
    var rectangle: SKShapeNode?
    init(size: CGSize) {
        super.init()
        let rectangle = SKShapeNode(rectOf: size)
        self.rectangle = rectangle
        self.physicsBody = SKPhysicsBody(rectangleOf: size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false
        self.physicsBody?.collisionBitMask = 1
        self.physicsBody?.contactTestBitMask = 1
        self.physicsBody?.friction = 0
        self.physicsBody?.restitution = 1
        self.addChild(rectangle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
