//
//  LegalDelivery.swift
//  Umpire Tracker
//
//  Created by Vijith V G on 14/11/26.
//


enum LegalDelivery: Int, CaseIterable {
    case dot = 0
    case single = 1
    case double = 2
    case three = 3
    case four = 4
    case six = 6
    
    var runs: Int { rawValue }
}