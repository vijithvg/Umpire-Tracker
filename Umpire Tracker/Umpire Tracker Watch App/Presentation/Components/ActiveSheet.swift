//
//  ActiveSheet.swift
//  Umpire Tracker
//
//  Created by Vijith V G on 14/11/26.
//


// MARK: - Active Sheet State
enum ActiveSheet: Identifiable {
    case extra(ExtraType)
    case wicket
    case undo
    
    var id: String {
        switch self {
        case .extra(let type): return "extra-\(type)"
        case .wicket: return "wicket"
        case .undo: return "undo"
        }
    }
}