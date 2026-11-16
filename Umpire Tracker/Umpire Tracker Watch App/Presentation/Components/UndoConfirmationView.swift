//
//  UndoConfirmationView.swift
//  Umpire Tracker
//
//  Created by Vijith V G on 14/11/26.
//

import SwiftUI

// MARK: - Custom Undo Confirmation Layer
struct UndoConfirmationView: View {
    @Environment(\.dismiss) var dismiss
    var match: MatchManager
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(.yellow)
                .font(.title2)
            
            Text("Undo Last Action?")
                .font(.headline)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            HStack {
                Button(action: { dismiss() }) {
                    Text("Cancel")
                }
                .tint(.gray)
                
                Button(action: {
                    match.undoLastAction()
                    WKInterfaceDevice.current().play(.retry)
                    dismiss()
                }) {
                    Text("Undo")
                        .fontWeight(.bold)
                }
                .tint(.red)
            }
        }
        .padding(.horizontal)
    }
}
