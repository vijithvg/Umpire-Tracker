//
//  ActionButton.swift
//  Umpire Tracker
//
//  Created by Vijith V G on 14/11/26.
//


// MARK: - Refactored Custom Button
import SwiftUI

struct ActionButton: View {
    let type: CricketButtonType
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Text(type.title)
                // Use a slightly larger font for the run grid
                .font(type.isRun ? .title3 : .headline)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .foregroundStyle(.white)
        }
        .tint(type.color)
    }
}
