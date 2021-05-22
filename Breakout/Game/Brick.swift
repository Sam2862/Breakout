//
//  Brick.swift
//  Breakout
//
//  Created by ITPathways on 5/17/21.
//
// Imports the necessary modules.
import Foundation
import SpriteKit

// Creates a subclass of the SolidRectangle class for bricks.
class Brick: SolidRectangle {
    // Sets the size and color of the brick.
    override init(size: CGSize) {
        super.init(size: size)
        self.rectangle?.fillColor = .gray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

