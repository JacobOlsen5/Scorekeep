//
//  Soccer.swift
//  Scoreboard 2
//
//  Created by Jake Olsen on 12/15/20.
//

import Foundation
class Soccer: ObservableObject {
    @Published var minutes: Int
    @Published var seconds: Int
    @Published var homeScore: Int
    @Published var guestScore: Int
    @Published var half: Int
    @Published var homeShots: Int
    @Published var guestShots: Int
    
    init(minutes: Int, seconds: Int, homeScore: Int, guestScore: Int, half: Int, homeShots: Int, guestShots: Int) {
        self.minutes = minutes
        self.seconds = seconds
        self.homeScore = homeScore
        self.guestScore = guestScore
        self.half = half
        self.homeShots = homeShots
        self.guestShots = guestShots
    }
}

