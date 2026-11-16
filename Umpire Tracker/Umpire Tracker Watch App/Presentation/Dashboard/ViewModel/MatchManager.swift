//
//  MatchManager.swift
//  Umpire Tracker
//
//  Created by Vijith V G on 14/11/26.
//

import Foundation
import Observation

@Observable
class MatchManager {
    var totalRuns: Int = 0
    var wickets: Int = 0
    var totalLegalBalls: Int = 0
    private var eventHistory: [MatchEvent] = []
    
    var completedOvers: Int { totalLegalBalls / 6 }
    var ballsInCurrentOver: Int { totalLegalBalls % 6 }
    var displayOvers: String { "\(completedOvers).\(ballsInCurrentOver)" }
    var isOverComplete: Bool { ballsInCurrentOver == 0 && totalLegalBalls > 0 }
    
    // Logic shifted entirely to use the enum
    func addDelivery(_ delivery: LegalDelivery) {
        guard wickets < 10 else { return }
        totalRuns += delivery.runs
        totalLegalBalls += 1
        eventHistory.append(.legalDelivery(delivery))
    }
    
    func addExtra(type: ExtraType, runs: Int) {
        guard wickets < 10 else { return }
        totalRuns += runs
        if type.countsAsLegalDelivery {
            totalLegalBalls += 1
        }
        eventHistory.append(.extra(type: type, runs: runs))
    }
    
    func addWicket(extraType: ExtraType? = nil, runs: Int = 0) {
        guard wickets < 10 else { return }
        wickets += 1
        totalRuns += runs
        
        let isLegalBall = extraType?.countsAsLegalDelivery ?? true
        if isLegalBall {
            totalLegalBalls += 1
        }
        
        eventHistory.append(.wicket(isLegalBall: isLegalBall, extraType: extraType, runs: runs))
    }
    
    func undoLastAction() {
        guard let lastEvent = eventHistory.popLast() else { return }
        
        switch lastEvent {
        case .legalDelivery(let delivery):
            totalRuns -= delivery.runs
            totalLegalBalls -= 1
            
        case .extra(let type, let runs):
            totalRuns -= runs
            if type.countsAsLegalDelivery {
                totalLegalBalls -= 1
            }
            
        case .wicket(let isLegalBall, _, let runs):
            wickets -= 1
            totalRuns -= runs
            if isLegalBall {
                totalLegalBalls -= 1
            }
        }
    }
}
