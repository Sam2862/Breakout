//
//  Paddle.swift
//  Breakout
//
//  Created by ITPathways on 5/17/21.
//

import Foundation
import SpriteKit

enum PaddleDirection {
    case still
    case left
    case right
}

class Paddle: SolidRectangle {
    override init(size: CGSize) {
        super.init(size: size)
        self.rectangle?.fillColor = .darkGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

