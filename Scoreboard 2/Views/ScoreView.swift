//
//  ScoreView.swift
//  Scoreboard 2
//
//  Created by Jake Olsen on 1/12/21.
//

import SwiftUI

struct ScoreView: View {
    //    @ObservedObject var soccerStats: Soccer
    @State var homeTeamName: String = ""
    @State var score: Int = 0
    @State var baseballStats = Baseball(ball: 0, strike: 0, out: 0, homeScore: 0, guestScore: 0, inning: 1)
    @Binding var sportSelect: Sport
    @State var soccerStats = Soccer(minutes: 0, seconds: 0, homeScore: 0, guestScore: 0, half: 1, homeShots: 0, guestShots: 0)
    @State var footballTimeouts: Int = 3
    @State var basketballTimeouts: Int = 5
    @State var possession: Int = 1
    @State var teamSelect: Team
    @State var toGo: String = ""
    @State var ballOn: String = ""
    @State var shots: Int = 0
    @State var shotsOnGoal: Int = 0
    @State var teamName: String = ""
    @State var guestTeamName: String = ""
    
    var body: some View {
        ZStack {
            Color.black
            VStack {
                if teamSelect == .home {
                    TextField("Team Name", text: $teamName)
                        .foregroundColor(.orange)
                        .font(.custom("scoreboard", size: 20))
                } else if teamSelect == .guest {
                    TextField("Team Name", text: $guestTeamName)
                        .foregroundColor(.orange)
                        .font(.custom("scoreboard", size: 20))
                }
                Spacer().frame(width: 90, height: 13, alignment: .topTrailing)
                
                Text("\(score)")
                    .frame(width: 200, height: 120, alignment: .center)
                    .foregroundColor(.orange)
                    .font(Font.custom("Open24DisplaySt", size: 120))
                
                if sportSelect == .soccer {
                    Button("+1") {
                        score += 1
                        print("\(score)")
                    }
                    
                    Button("-1") {
                        score -= 1
                        print(" \(score)")
                    }
                    Button("Reset") {
                        score = 0
                    }
                    HStack {
                        Text("Shots: ")
                            .foregroundColor(.white)
                        Text("\(shots)")
                            .foregroundColor(.orange)
                            .font(Font.custom("Open24DisplaySt", size: 20))
                        Button("+1") {
                            shots += 1
                        }
                        Button("-1") {
                            shots -= 1
                        }
                    }
                    HStack {
                        Text("Shots On Goal: ")
                            .foregroundColor(.white)
                        Text("\(shotsOnGoal)")
                            .foregroundColor(.orange)
                            .font(Font.custom("Open24DisplaySt", size: 20))
                        Button(" +1") {
                            shotsOnGoal += 1
                        }
                        Button("-1") {
                            shotsOnGoal -= 1
                        }
                    }
                    
                    Button("Reset") {
                        shots = 0
                        shotsOnGoal = 0
                    }
                } else if sportSelect == .baseball {
                    Button("+1") {
                        score += 1
                        print("\(score)")
                    }
                    
                    Button("-1") {
                        score -= 1
                        print(" \(score)")
                    }
                    Button("Reset") {
                        score = 0
                    }
                } else if sportSelect == .football {
                    
                    Button("+1") {
                        score += 1
                        print("\(score)")
                    }
                    Button("+3") {
                        score += 3
                        print("\(score)")
                    }
                    Button("+6") {
                        score += 6
                        print("\(score)")
                    }
                    Button("-1") {
                        score -= 1
                        print("\(score)")
                    }
                    Button("Reset") {
                        score = 0
                    }
                    HStack {
                        Text("TOL: ")
                            .foregroundColor(.white)
                        Text("\( footballTimeouts)")
                            .foregroundColor(.orange)
                            .font(Font.custom("Open24DisplaySt", size: 20))
                        Button("TOL -1") {
                            footballTimeouts -= 1
                        }
                        Button("TOL Reset") {
                            footballTimeouts = 3
                        }
                    }
                    
                } else {
                    // Basketball
                    Button("+1") {
                        score += 1
                    }
                    Button("+2") {
                        score += 2
                    }
                    Button("+3") {
                        score += 3
                    }
                    Button("-1") {
                        score -= 1
                        print("\(score)")
                    }
                    Button("Reset") {
                        score = 0
                    }
                    HStack {
                        Text("TOL: ")
                            .foregroundColor(.white)
                        Text("\(basketballTimeouts)")
                            .foregroundColor(.orange)
                            .font(Font.custom("Open24DisplaySt", size: 20))
                        Button("TOL -1") {
                            basketballTimeouts -= 1
                        }
                        Button("TOL Reset") {
                            basketballTimeouts = 5
                        }
                    }
                }
            }
        }
    }
}



// Make this view generic and reuse it for both home and guest.


struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        let soccer = Soccer(minutes: 0, seconds: 0, homeScore: 0, guestScore: 0, half: 0, homeShots: 0, guestShots: 0)
        ScoreView(sportSelect: .constant(.soccer), teamSelect: .home)
    }
}
