//
//  PersistentTypeDrag.swift
//  FinalProject
//
//  Created by Rishi Garg on 4/28/24.
//

import Foundation
import UniformTypeIdentifiers
import SwiftData
import SwiftUI

extension PersistentIdentifier: Transferable {
    public static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .persistentModelID)
    }
}
extension PersistentIdentifier {
    public func persistentModel<Model>(from context: ModelContext) -> Model? where Model : PersistentModel {
        return context.model(for: self) as? Model
    }
}
extension UTType {
    static var persistentModelID: UTType { UTType(exportedAs: "com.rishigarg.persistentModelID") }
}
