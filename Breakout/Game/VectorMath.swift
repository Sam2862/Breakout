//
//  VectorMath.swift
//  MyGame
//
//  Created by ITPathways on 5/13/21.
//

import Foundation
import SpriteKit

class VectorMath {
    static func make(angleDegrees: CGFloat, speed: CGFloat) -> CGVector {
        let y = sin((angleDegrees/180.0) * .pi) * speed
        let x = cos((angleDegrees/180.0) * .pi) * speed
        
        return CGVector(dx: x, dy: y)
    }
    
    static func degrees(vector: CGVector) -> CGFloat {
        return atan2(vector.dy, vector.dx) * 180.0 / .pi
    }
    
    static func length(vector: CGVector) -> CGFloat {
        return sqrt((vector.dy * vector.dy) + (vector.dx * vector.dx))
    }
}
