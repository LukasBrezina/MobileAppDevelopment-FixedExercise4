//
//  Alert.swift
//  FixedExercise4
//
//  Created by Lukas Brezina on 30.09.26.
//
import SwiftUI

struct AlertInfo {
    var title = "Error"
    var message: String
}

extension View {
    func infoAlert(_ info: Binding<AlertInfo?>) -> some View {
        alert(
            info.wrappedValue?.title ?? "",
            isPresented: Binding(
                get: { info.wrappedValue != nil },
                set: { if !$0 { info.wrappedValue = nil } }
            )
        ) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(info.wrappedValue?.message ?? "")
        }
    }
}
