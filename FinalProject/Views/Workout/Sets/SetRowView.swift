//
//  SetRowView.swift
//  FinalProject
//
//  Created by Rishi Garg on 2/29/24.
//

import SwiftUI
import Combine

public struct SelectAllTextOnBeginEditingModifier: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .onReceive(NotificationCenter.default.publisher(
                for: UITextField.textDidBeginEditingNotification)) { _ in
                    DispatchQueue.main.async {
                        UIApplication.shared.sendAction(
                            #selector(UIResponder.selectAll(_:)), to: nil, from: nil, for: nil
                        )
                    }
                }
    }
}

extension View {
    func dismissKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder
            .resignFirstResponder), to: nil, from: nil, for: nil)
    }
    public func selectAllTextOnBeginEditing() -> some View {
        modifier(SelectAllTextOnBeginEditingModifier())
    }
}
struct SetRowView: View {
    @State var done : Bool = false
    var index: Int
    @Bindable var set : ESet
    @FocusState private var isFocused : Bool
    @Environment(\.modelContext) var context
    var body: some View {
        let columns = [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]
        HStack{
            LazyVGrid(columns: columns, content: {
                if index == -1 {
                    Text("+")
                        .multilineTextAlignment(.center)
                    Text("-")
                        .multilineTextAlignment(.center)
                    Text("-")
                        .multilineTextAlignment(.center)
                    Image(systemName: "checkmark.seal")
                        .foregroundStyle(Color.black)
                }else{
                    Text("\(index + 1)")
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .background(Color("DarkBlue"))
                        .foregroundStyle(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                    TextField("Weight", value: $set.weight, format: .number)
                        .multilineTextAlignment(.center)
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                        .selectAllTextOnBeginEditing()
                    TextField("Reps", value: $set.reps, format: .number)
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .focused($isFocused)
                        .selectAllTextOnBeginEditing()
                    Button(action: {
                        set.done.toggle()
                    }) {
                        Image(systemName: set.done ? "checkmark.seal.fill" :
                                "checkmark.seal")
                        .foregroundStyle(set.done ? Color.green : Color.black)
                    }
                    .buttonStyle(.plain)
                }
            })
        }
        .onDelete {
            set.exercise?.sets.removeAll(where: {$0.id == set.id})
            context.delete(set)
        }
        .background(set.done ? Color.green.brightness(-0.4) : index == -1 ? Color.white.brightness(-0.5) : Color.third.brightness(0))
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    SetRowView(done: false, index: 0, set: ESet())
        .modelContainer(previewContainer)
}
