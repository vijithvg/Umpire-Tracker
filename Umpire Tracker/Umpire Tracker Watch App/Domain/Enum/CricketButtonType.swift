//
//  CricketButtonType.swift
//  Umpire Tracker
//
//  Created by Vijith V G on 14/11/26.
//

import SwiftUI
import WatchKit

// MARK: - Button Configuration Enum
enum CricketButtonType {
    case run(LegalDelivery)
    case extra(ExtraType)
    case wicket
    
    var title: String {
        switch self {
        case .run(let delivery): return "\(delivery.runs)"
        case .extra(.wide): return "WD"
        case .extra(.noBall): return "NB"
        case .extra(.bye): return "B"
        case .extra(.legBye): return "LB"
        case .wicket: return "W"
        }
    }
    
    var color: Color {
        switch self {
        case .run: return .white
        case .extra(.wide): return .yellow
        case .extra(.noBall): return .orange
        case .extra(.bye), .extra(.legBye): return .purple
        case .wicket: return .red
        }
    }
    
    var isRun: Bool {
        if case .run = self { return true }
        return false
    }
}
