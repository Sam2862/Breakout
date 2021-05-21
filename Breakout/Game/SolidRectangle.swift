//
//  SolidRectangle.swift
//  Breakout
//
//  Created by Samuel K on 5/13/21.
//
//Imports the necessary modules.
import Foundation
import SpriteKit

//Creates a class for solid rectangles.
class SolidRectangle: SKNode {
//    Creates variables for the rectangle and the width.
    var rectangle: SKShapeNode?
    var width: CGFloat {
        return rectangle?.frame.size.width ?? self.frame.width
    }
//    Sets the size and physics properties of the rectangle.
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
