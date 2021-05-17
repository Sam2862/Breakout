//
//  Barrier.swift
//  MyGame
//
//  Created by ITPathways on 5/13/21.
//

import Foundation
import SpriteKit

class Barrier: SolidRectangle {
    override init(size: CGSize) {
        super.init(size: size)
        self.rectangle?.strokeColor = .blue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
