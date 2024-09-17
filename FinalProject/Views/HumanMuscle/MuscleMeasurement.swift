//
//  MuscleMeasurement.swift
//  FinalProject
//
//  Created by Rishi Garg on 4/28/24.
//

import Foundation
import SceneKit
enum MuscleMeasurement: String, CaseIterable, Codable {
    case neck, chest, bicepsLeft, thighLeft, calfLeft, shoulders, waist, bicepsRight , thighRight, calfRight, hips
    
    // Shared node creation method
    var node: SCNNode {
        let torus = SCNTorus(ringRadius: outlineRadius, pipeRadius: 0.05)
        torus.firstMaterial?.diffuse.contents = UIColor.red
        let torusNode = SCNNode(geometry: torus)
        torusNode.position = outlinePosition
        torusNode.rotation = SCNVector4(x: 1, y: 0, z: 0, w: Float.pi / 2)  // Rotate to fit around the arm, adjust as necessary
        return torusNode
    }
    var muscleGroup : Muscle {
        switch self {
        case .neck:
                .neck
        case .chest:
                .chest
        case .bicepsLeft:
                .biceps
        case .thighLeft:
                .biceps
        case .calfLeft:
                .calves
        case .shoulders:
                .shoulders
        case .waist:
                .abdominals
        case .bicepsRight:
                .biceps
        case .thighRight:
                .quadriceps
        case .calfRight:
                .calves
        case .hips:
                .glutes
        }
    }
    // Position of the torus for each muscle type
    //+y going into the body
    var outlinePosition: SCNVector3 {
        switch self {
        case .bicepsLeft:
            return SCNVector3(x: -2.2309, y: 0.84216, z: 1.00375)
        case .bicepsRight:
            return SCNVector3(x: 2.2109, y: 0.84216, z: 1.00375)
        case .chest:
            return SCNVector3(x: -0.006313, y: 0.305, z: 1.80906)
        case .neck:
            return SCNVector3(x: -0.021985, y: 0.521306 , z: 3.76408 )
        case .shoulders:
            return SCNVector3(x: -0.006312 , y: 0.545332 , z: 2.6541 )
        case .waist:
            return SCNVector3(x: -0.020387  , y: 0 , z: -0.269037)
        case .hips:
            return SCNVector3(x: -0.020387  , y: 0 , z: -1.369037)
        case .thighLeft:
            return SCNVector3(x: -0.92437  , y: 0.175051 , z: -3.66791)
        case .thighRight:
            return SCNVector3(x: 0.92437  , y: 0.175051 , z: -3.66791)
        case .calfLeft:
            return SCNVector3(x: -1.055951  , y: 0.654599  , z: -6.47022 )
        case .calfRight:
            return SCNVector3(x: 1.03951  , y: 0.654599 , z: -6.47022 )
        }
    }

    // Radius of the torus for each muscle type
    var outlineRadius: CGFloat {
        switch self {
        case .bicepsLeft, .bicepsRight:
            return 0.55
        case .chest:
            return 1.7
        case .neck:
            return 0.72
        case .shoulders:
            return 2.27
        case .waist:
            return 1.6
        case .hips:
            return 1.65
        case .thighLeft, .thighRight:
            return 0.86
        case .calfLeft, .calfRight:
            return 0.8
        }
    }
    
    var displayName : String {
        switch self {
        case .bicepsLeft:
            return "Left Biceps"
        case .bicepsRight:
            return "Right Biceps"
        case .chest:
            return "Chest"
        case .neck:
            return "Neck"
        case .shoulders:
            return "Shoulders"
        case .waist:
            return "Waist"
        case .hips:
            return "Hips"
        case .thighLeft:
            return "Left Thigh"
        case .thighRight:
            return "Right Thigh"
        case .calfLeft:
            return "Left Calf"
        case .calfRight:
            return "Right Calf"
        }
    }
}
