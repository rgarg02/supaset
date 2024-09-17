//
//  HumanModel+Funcs.swift
//  FinalProject
//
//  Created by Rishi Garg on 4/28/24.
//

import SwiftUI
import SceneKit
extension SCNVector3: Equatable {
    public static func == (lhs: SCNVector3, rhs: SCNVector3) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
    }
}
extension SCNVector4: Equatable {
    public static func == (lhs: SCNVector4, rhs: SCNVector4) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z && lhs.w == rhs.w
    }
}
extension HumanModel{
    internal func resetScene() {
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 0.5
        sceneView.pointOfView?.position = SCNVector3(x: -0.119388437, y: -35.113367, z: -2.030692)
        sceneView.pointOfView?.orientation = SCNVector4(x: 0.70710677, y: 0.0, z: 0.0, w: 0.70710677)
        sceneView.scene?.highlightTargetedMuscles(primaryMuscles: [], secondaryMuscles: [])
        lastOutlineNode?.removeFromParentNode()
        self.showDetails = false
        movetoMuscle = nil
        locationOfNode = nil
        SCNTransaction.commit()
    }
    var isInitialPOV : Bool {
        return sceneView.pointOfView?.position == SCNVector3(x: -0.119388437, y: -35.113367, z: -2.030692) &&
        sceneView.pointOfView?.orientation == SCNVector4(x: 0.70710677, y: 0.0, z: 0.0, w: 0.70710677)
    }
    internal func loadMusclesHighlights() {
        if let workout = workout {
            let exercises : [EInfo] = workout.exercises
            var primaryMuscles : [Muscle] = []
            var secondaryMuscles : [Muscle] = []
            for exercise in exercises {
                primaryMuscles.append(contentsOf: workoutManager.primaryMuscles (for: exercise.exerciseID))
                secondaryMuscles.append(contentsOf: workoutManager.secondaryMuscles(for: exercise.exerciseID))
            }
            sceneView.scene?.highlightTargetedMuscles(primaryMuscles: primaryMuscles, secondaryMuscles: secondaryMuscles)
        }
        if let exercise = exercise {
            let primaryMuscles : [Muscle] = exercise.primaryMuscles
            let secondaryMuscles : [Muscle] = exercise.secondaryMuscles
            sceneView.scene?.highlightTargetedMuscles(primaryMuscles: primaryMuscles, secondaryMuscles: secondaryMuscles)
        }
    }
    internal func addOutline(for muscle : MuscleMeasurement) {
        // Assuming 'bicepsNode' is the node for the biceps that you've found or created
        guard let scene = sceneView.scene else {
            print ("scene not found")
            return
        }
        lastOutlineNode?.removeFromParentNode()
        let torusNode = muscle.node
        scene.rootNode.addChildNode(torusNode)
        lastOutlineNode = torusNode
        let muscleGroup = muscle.muscleGroup
        if let muscleName = MuscleGroups.muscleMappings[muscleGroup]?.first {
                movetoMuscle = muscleName
                locationOfNode = Float(MuscleGroups.getLocation(of: muscleGroup))
        }
    }
}


