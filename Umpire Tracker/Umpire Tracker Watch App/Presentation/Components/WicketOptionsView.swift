//
//  WicketOptionsView.swift
//  Umpire Tracker
//
//  Created by Vijith V G on 14/11/26.
//


import SwiftUI
import WatchKit

// MARK: - Custom Wicket Menu Layer
struct WicketOptionsView: View {
    @Environment(\.dismiss) var dismiss
    var match: MatchManager // Pass the manager in so we can call the logic
    
    var body: some View {
        ScrollView {
            VStack(spacing: 6) {
                Text("Select Wicket Type")
                    .font(.headline)
                    .padding(.bottom, 4)
                
                Button(action: {
                    match.addWicket()
                    dismiss()
                }) {
                    Text("Legal Delivery")
                        .fontWeight(.semibold)
                }
                .tint(.red)
                
                Button(action: {
                    match.addWicket(extraType: .wide, runs: 1)
                    dismiss()
                }) {
                    Text("Wide + Wicket")
                        .fontWeight(.semibold)
                }
                .tint(.yellow)
                
                Button(action: {
                    match.addWicket(extraType: .noBall, runs: 1)
                    dismiss()
                }) {
                    Text("No Ball + Wicket")
                        .fontWeight(.semibold)
                }
                .tint(.orange)
            }
        }
    }
}

