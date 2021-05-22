//
//  Barrier.swift
//  Breakout
//
//  Created by Samuel K on 5/13/21.
//
// Imports the necessary modules.
import Foundation
import SpriteKit

// Creates a subclass of the SolidRectangle class for barriers.
class Barrier: SolidRectangle {
    // Sets the size and color of the barrier.
    override init(size: CGSize) {
        super.init(size: size)
        self.rectangle?.strokeColor = .blue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
