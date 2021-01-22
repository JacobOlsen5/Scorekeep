//
//  FootballHomeScoreView.swift
//  Scoreboard 2
//
//  Created by Jake Olsen on 1/13/21.
//

import SwiftUI

struct FootballHomeScoreView: View {
    @State var footballStats: Football
    @State var homeTeamName: String = ""
    var body: some View {
        VStack {
            TextField("Home Team Name", text: $homeTeamName)
            Spacer().frame(width: 90, height: 13, alignment: .topTrailing)
            
            Text("\(footballStats.homeScore)").font(.system(size: 150))
                .frame(width: 200, height: 150, alignment: .center)
                .foregroundColor(.blue)
            Button("Home PAT") {
                footballStats.homeScore += 1
                print("Home has scored \(footballStats.homeScore) points")
            }
            Button("Home Safety") {
                footballStats.homeScore += 2
                print("Home has scored \(footballStats.homeScore) points")
            }
            Button("Home Field Goal") {
                footballStats.homeScore += 3
                print("Home has scored \(footballStats.homeScore) points")
            }
            Button("Home Touchdown") {
                footballStats.homeScore += 6
                print("Home has scored \(footballStats.homeScore) points")
            }
            
            Button("Home -1") {
                footballStats.homeScore -= 1
                print("Home has scored \(footballStats.homeScore) points")
            }
            Button("Reset") {
                footballStats.homeScore = 0
            }
            HStack {
                Text("TOL")
                Button("TOL Reset") {
                    footballStats.homeTimeouts = 3
                }

                Text("\(footballStats.homeTimeouts)")
                Button("TOL -1") {
                     footballStats.homeTimeouts -= 1
                     print("Home has scored \(footballStats.homeScore) points")
                 }
            }
        }
    }
    
    
    // Make this view generic and reuse it for both home and guest.
    
}

struct FootballHomeScorecoreView_Previews: PreviewProvider {
    static var previews: some View {
        let football = Football(down: 0, toGo: 0, ballOn: 0, homeScore: 0, guestScore: 1, homeTimeouts: 3, guestTimeouts: 3, quarter: 0, minutes: 15, seconds: 0, possession: 1, playClock: 25)
        FootballHomeScoreView(footballStats: football)
    }
}
