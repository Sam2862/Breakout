//
//  Brick.swift
//  Breakout
//
//  Created by ITPathways on 5/17/21.
//

import Foundation
import SpriteKit

class Brick: SolidRectangle {
    override init(size: CGSize) {
        super.init(size: size)
        self.rectangle?.fillColor = .gray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

