//
//  WorkoutManager.swift
//  FinalProject
//
//  Created by Rishi Garg on 2/22/24.
//

import Foundation
import CoreData
class WorkoutManager : ObservableObject {
    @Published var exercises: [Exercise] = []
    @Published var searchText = ""
    @Published var selectedForce: Force?
    @Published var selectedLevel: Level?
    @Published var selectedMechanic: Mechanic?
    @Published var selectedEquipment: Equipment?
    @Published var selectedPrimaryMuscle: Muscle?
    @Published var selectedCategory: Category?
    @Published var selectedExercises: [String] = []
    @Published var selectedExerciseSingle : String?
    var filteredExercises: [Exercise] {
        filterExercises()
    }
    var selectedCount: Int {
        if let _ = selectedExerciseSingle {
            return 1
        } else {
            return selectedExercises.count
        }
    }
    var selectedExercisesSubmit : [String] {
        if let exerciseID = selectedExerciseSingle {
            return [exerciseID]
        } else {
            return selectedExercises
        }
    }
    init(){
        loadExercises()
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        print(paths[0])
    }

    func loadExercises() {
            guard let filePath = Bundle.main.path(forResource: "exercises", ofType: "json") else { return }
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
                let decoder = JSONDecoder()
                let exercises = try decoder.decode([Exercise].self, from: data)
                self.exercises = exercises
            } catch {
                print("Error while loading or decoding exercises: \(error)")
            }
        }


    func exerciseName(for exerciseID: String) -> String{
        return exercises.first(where: {$0.id == exerciseID})?.name ?? "No Exercise Found"
    }
    
    func primaryMuscles(for exerciseID: String) -> [Muscle] {
        return exercises.first(where: {$0.id == exerciseID})?.primaryMuscles ?? []
    }
    func secondaryMuscles(for exerciseID: String) -> [Muscle] {
        return exercises.first(where: {$0.id == exerciseID})?.secondaryMuscles ?? []
    }
    func filterExercises() -> [Exercise] {
        return exercises.filter { exercise in
            (!searchText.isEmpty ? exercise.name.lowercased().contains(searchText.lowercased()) : true) &&
            (selectedForce != nil ? exercise.force == selectedForce : true) &&
            (selectedLevel != nil ? exercise.level == selectedLevel : true) &&
            (selectedMechanic != nil ? exercise.mechanic == selectedMechanic : true) &&
            (selectedEquipment != nil ? exercise.equipment == selectedEquipment : true) &&
            (selectedPrimaryMuscle != nil ? exercise.primaryMuscles.contains(selectedPrimaryMuscle!) : true) &&
            (selectedCategory != nil ? exercise.category == selectedCategory : true)
        }
    }
    func toggleSelection(of exercise: Exercise) {
        if selectedExercises.contains(exercise.id) {
            selectedExercises.removeAll(where: {$0 == exercise.id })
        } else {
            selectedExercises.append(exercise.id)
        }
    }
    func toggleSelectionSingle(of exercise: Exercise) {
        if selectedExerciseSingle == exercise.id {
            selectedExerciseSingle = nil
        }else{
            selectedExerciseSingle = exercise.id
        }
    }
    func isSelected(exercise: Exercise) ->  Bool {
        return selectedExercises.contains(exercise.id) || selectedExerciseSingle == exercise.id
    }
    func clearSelection() {
        selectedExercises = []
        selectedExerciseSingle = nil
    }
}

