//
//  Paddle.swift
//  Breakout
//
//  Created by ITPathways on 5/17/21.
//
//Import the necessary modules.
import Foundation
import SpriteKit

//Creates the different cases for the paddle direction.
enum PaddleDirection {
    case still
    case left
    case right
}

//Creates a subclass of the SolidRectangle class for the paddle.
class Paddle: SolidRectangle {
//    Sets the size and color of the paddle.
    override init(size: CGSize) {
        super.init(size: size)
        self.rectangle?.fillColor = .darkGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

