//
//  ExtraType.swift
//  Umpire Tracker
//
//  Created by Vijith V G on 14/11/26.
//


enum ExtraType {
    case wide
    case noBall
    case bye
    case legBye
    
    var countsAsLegalDelivery: Bool {
        switch self {
        case .wide, .noBall: return false
        case .bye, .legBye: return true
        }
    }
}
