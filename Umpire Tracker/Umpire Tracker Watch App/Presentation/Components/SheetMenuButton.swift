//
//  SheetMenuButton.swift
//  Umpire Tracker
//
//  Created by Vijith V G on 14/11/26.
//


import SwiftUI
import WatchKit

struct SheetMenuButton: View {
    let title: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            WKInterfaceDevice.current().play(.click)
            action()
        }) {
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, minHeight: 44)
        }
        .tint(color)
        .clipShape(RoundedRectangle(cornerRadius: 10)) // Custom shape styling
    }
}