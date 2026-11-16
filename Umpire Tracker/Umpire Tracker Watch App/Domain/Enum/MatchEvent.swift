//
//  MatchEvent.swift
//  Umpire Tracker
//
//  Created by Vijith V G on 14/11/26.
//


enum MatchEvent {
    case legalDelivery(LegalDelivery)
    case extra(type: ExtraType, runs: Int)
    case wicket(isLegalBall: Bool, extraType: ExtraType?, runs: Int)
}
