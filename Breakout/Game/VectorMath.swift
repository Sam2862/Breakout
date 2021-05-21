//
//  VectorMath.swift
//  Breakout
//
//  Created by Samuel K on 5/13/21.
//
//Imports the necessary modules.
import Foundation
import SpriteKit

//Creates a class for the vector calculations.
class VectorMath {
//    Creates a vector.
    static func make(angleDegrees: CGFloat, speed: CGFloat) -> CGVector {
        let y = sin((angleDegrees/180.0) * .pi) * speed
        let x = cos((angleDegrees/180.0) * .pi) * speed
        
        return CGVector(dx: x, dy: y)
    }
    
//    Converts a vector from radians to degrees.
    static func degrees(vector: CGVector) -> CGFloat {
        return atan2(vector.dy, vector.dx) * 180.0 / .pi
    }
    
//    Returns the length of a vector.
    static func length(vector: CGVector) -> CGFloat {
        return sqrt((vector.dy * vector.dy) + (vector.dx * vector.dx))
    }
}
