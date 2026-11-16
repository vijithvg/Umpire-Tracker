//
//  DashboardView.swift
//  Umpire Tracker
//
//  Created by Vijith V G on 14/11/26.
//


import SwiftUI
import WatchKit

// MARK: - Main Dashboard View
struct DashboardView: View {
    @State private var match = MatchManager()
    
    // Single source of truth for all sheets to prevent SwiftUI conflicts
    @State private var activeSheet: ActiveSheet?
    
    var body: some View {
        VStack(alignment:.leading,spacing: 0) {
            ScoreboardHeaderView(match: match)
                .background(Color.red)
            
            ScrollView {
                VStack(spacing: 8) {
                    RunsGridView(match: match)
                    
                    ActionRowView(activeSheet: $activeSheet)
                    
                    UndoActionView(match: match, activeSheet: $activeSheet)
                }
                .padding(.vertical,8)
            }
            .background(.clear)
        }
        .toolbar(.hidden)
                // 2. Lets the scroll view flow all the way to the bottom edge
                .ignoresSafeArea(edges: .bottom)
        // MARK: - Single Sheet Manager
        .sheet(item: $activeSheet) { sheet in
            switch sheet {
            case .extra(let type):
                ExtraOptionsView(match: match, extraType: type)
            case .wicket:
                WicketOptionsView(match: match)
            case .undo:
                UndoConfirmationView(match: match)
            }
        }
        // MARK: - Haptic Over Alert
        .onChange(of: match.isOverComplete) { _, isComplete in
            if isComplete {
                WKInterfaceDevice.current().play(.success)
            }
        }
    }
}

// MARK: - Subcomponents

struct ScoreboardHeaderView: View {
    var match: MatchManager
    
    var body: some View {
        HStack {
            Text("\(match.totalRuns)/\(match.wickets)")
                .font(.title)
                .fontWeight(.bold)
            
            Spacer()
            
            Text("Ov: \(match.displayOvers)")
                .font(.headline)
                .fontWeight(.bold)
        }
        .padding(.horizontal, 8)
    }
}

struct RunsGridView: View {
    var match: MatchManager
    
    var body: some View {
        Grid(horizontalSpacing: 4, verticalSpacing: 4) {
            GridRow {
                ActionButton(type: .run(.dot)) { match.addDelivery(.dot) }
                ActionButton(type: .run(.single)) { match.addDelivery(.single) }
                ActionButton(type: .run(.double)) { match.addDelivery(.double) }
            }
            GridRow {
                ActionButton(type: .run(.three)) { match.addDelivery(.three) }
                ActionButton(type: .run(.four)) { match.addDelivery(.four) }
                ActionButton(type: .run(.six)) { match.addDelivery(.six) }
            }
        }
        .frame(height: 110)
    }
}

struct ActionRowView: View {
    @Binding var activeSheet: ActiveSheet?
    
    var body: some View {
        HStack(spacing: 4) {
            ActionButton(type: .extra(.wide)) {
                activeSheet = .extra(.wide)
            }
            
            ActionButton(type: .extra(.noBall)) {
                activeSheet = .extra(.noBall)
            }
            
            ActionButton(type: .wicket) {
                activeSheet = .wicket
            }
        }
        .frame(height: 44)
    }
}

struct UndoActionView: View {
    var match: MatchManager
    @Binding var activeSheet: ActiveSheet?
    
    var body: some View {
        Button(action: {
            if match.totalLegalBalls > 0 || match.totalRuns > 0 || match.wickets > 0 {
                activeSheet = .undo
                WKInterfaceDevice.current().play(.click)
            }
        }) {
            HStack {
                Image(systemName: "arrow.uturn.backward")
                Text("Undo")
            }
            .font(.headline)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, minHeight: 44)
        }
        .tint(.gray)
    }
}

#Preview {
    DashboardView()
}
