//
//  ExtraOptionsView.swift
//  Umpire Tracker
//
//  Created by Vijith V G on 14/11/26.
//

import SwiftUI

// MARK: - Custom Extras Menu Layer
struct ExtraOptionsView: View {
    @Environment(\.dismiss) var dismiss
    var match: MatchManager
    var extraType: ExtraType
    
    var body: some View {
        ScrollView {
            VStack(spacing: 6) {
                Text(extraType == .wide ? "Wide Extras" : "No Ball Extras")
                    .font(.headline)
                    .padding(.bottom, 4)
                
                // Generates +0 to +6 buttons
                ForEach(0...6, id: \.self) { additionalRuns in
                    SheetMenuButton(
                        title: "+\(additionalRuns)",
                        color: extraType == .wide ? .yellow : .orange
                    ) {
                        // Adds the base penalty of 1 plus whatever was run
                        match.addExtra(type: extraType, runs: additionalRuns + 1)
                        dismiss()
                    }
                }
            }
        }
    }
}
