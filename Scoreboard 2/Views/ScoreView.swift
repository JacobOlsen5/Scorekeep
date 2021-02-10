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
    @State var hits: Int = 0
    @State var errors: Int = 0
    @State var bonus: Int = 0
    @State var fouls: Int = 0
    @State private var showingAlert = false
    @State var challenge: Bool = false
    @State var yellowCard: Int = 0
    @State var redCard: Int = 0
    func evaluateScore(_ score: Int) {
        if (score <= 0) {
            self.score = 0
        }
    }
    
    func evaluateShots(_ shots: Int) {
        if (shots <= 0) {
            self.shots = 0
        }
    }
    
    func evaluateTimeouts(_ shots: Int) {
        if (footballTimeouts <= 0) {
            self.footballTimeouts = 0
        }
    }
    func evaluateShotsOnGoal(_ shots: Int) {
        if (shotsOnGoal <= 0) {
            self.shotsOnGoal = 0
        }
    }
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
                    HStack {
                        Button("+1") {
                            score += 1
                            shots += 1
                            shotsOnGoal += 1
                            print("\(score)")
                        }
                        
                        Button("-1") {
                            score -= 1
                            shots -= 1
                            shotsOnGoal -= 1
                            print(" \(score)")
                            if score <= -1 {
                                evaluateScore(0)
                            }
                        }
                        Button("Reset") {
                            score = 0
                        }
                    }
                    HStack {
                        Text("Shots: ")
                            .foregroundColor(.yellow)
                            .font(.custom("scoreboard", size: 20))
                        Text("\(shots)")
                            .foregroundColor(.orange)
                            .font(Font.custom("Open24DisplaySt", size: 20))
                        Button("+1") {
                            shots += 1
                        }
                        Button("-1") {
                            shots -= 1
                            if shots <= 0 {
                                evaluateShots(0)
                            }
                        }
                    }
                    HStack {
                        Text("Shots On Goal: ")
                            .font(.custom("scoreboard", size: 20))
                            .foregroundColor(.yellow)
                        Text("\(shotsOnGoal)")
                            .foregroundColor(.orange)
                            .font(Font.custom("Open24DisplaySt", size: 20))
                        Button(" +1") {
                            shots += 1
                            shotsOnGoal += 1
                        }
                        Button("-1") {
                            shots -= 1
                            shotsOnGoal -= 1
                            evaluateShotsOnGoal(0)
                        }
                    }
                    
                    Button("Reset") {
                        shots = 0
                        shotsOnGoal = 0
                    }
                    HStack {
                        Image(systemName: "rectangle.fill").foregroundColor(.yellow)
                        Text("\(yellowCard)")
                            .font(.custom("Open24DisplaySt", size: 20))
                            .foregroundColor(.yellow)
                        Button("+1") {
                            yellowCard += 1
                        }
                        Button("-1") {
                            yellowCard -= 1
                        }
                        Button("Reset") {
                            yellowCard = 0
                        }
                    }
                    HStack {
                        Image(systemName: "rectangle.fill").foregroundColor(.red)
                        Text("\(redCard)")
                            .font(.custom("Open24DisplaySt", size: 20))
                            .foregroundColor(.red)
                        Button("+1") {
                            redCard += 1
                        }
                        Button("-1") {
                            redCard -= 1
                        }
                        Button("Reset") {
                            redCard = 0
                        }
                    }
                } else if sportSelect == .baseball {
                    HStack {
                    Button("+1") {
                        score += 1
                        print("\(score)")
                    }
                    
                    Button("-1") {
                        score -= 1
                        print(" \(score)")
                        if score <= -1 {
                            evaluateScore(0)
                        }
                        
                    }
                        Button("Reset") {
                            score = 0
                        }
                    }
                    // Hits
                    HStack {
                        Text("Hits")
                            .foregroundColor(.yellow)
                            .font(.custom("scoreboard", size: 20))
                        Text("\(hits)")
                            .foregroundColor(.yellow)
                            .font(.custom("Open24DisplaySt", size: 20))
                        Button("Hits +1") {
                            hits += 1
                        }
                        Button("Hits -1") {
                            hits -= 1
                        }
                    }
                    // Errors
                    HStack {
                        Text("Errors")
                            .foregroundColor(.yellow)
                            .font(.custom("scoreboard", size: 20))
                        Text("\(errors)")
                            .foregroundColor(.yellow)
                            .font(.custom("Open24DisplaySt", size: 20))
                        Button("Errors +1") {
                            errors += 1
                        }
                        Button("Errors -1") {
                            errors -= 1
                        }
                        
                    }
                    Button("Reset") {
                        hits = 0
                        errors = 0
                    }
                } else if sportSelect == .football {
                    HStack {
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
                            if score <= -1 {
                                evaluateScore(0)
                            }
                        }
                    }
                    Button("Reset") {
                        score = 0
                    }
                    HStack {
                        Text("TOL: ")
                            .font(.custom("scoreboard", size: 20))
                            .foregroundColor(.yellow)
                        Text("\( footballTimeouts)")
                            .foregroundColor(.orange)
                            .font(Font.custom("Open24DisplaySt", size: 20))
                        Button("TOL -1") {
                            footballTimeouts -= 1
                            if footballTimeouts <= 0 {
                                evaluateTimeouts(0)
                            }
                        }
                        Button("TOL Reset") {
                            footballTimeouts = 3
                        }
                    }
                    if challenge == true {
                        Text("Challenge")
                            .foregroundColor(.red)
                            .font(Font.custom("scoreboard", size: 20))
                    } else {
                        Text("Challenge")
                            .foregroundColor(.black)
                            .font(Font.custom("scoreboard", size: 20))
                    }
                    Button("Challenge") {
                        if challenge == true {
                            challenge = false
                        } else {
                            challenge = true
                        }
                    }
                } else {
                    // Basketball
                    HStack {
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
                            if score <= -1 {
                                evaluateScore(0)
                            }
                            
                        }
                        Button("Reset") {
                            score = 0
                        }
                    }
                    HStack {
                        Text("TOL: ")
                            .font(.custom("scoreboard", size: 20))
                            .foregroundColor(.yellow)
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
                    HStack {
                        Text("Fouls:")
                            .foregroundColor(.yellow)
                            .font(.custom("scoreboard", size: 20))
                        Text("\(fouls)")
                            .foregroundColor(.orange)
                            .font(Font.custom("Open24DisplaySt", size: 20))
                    }
                    HStack {
                        Button("+1") {
                            fouls += 1
                        }
                        Button("-1") {
                            fouls -= 1
                        }
                        Button("Reset") {
                            fouls = 0
                        }
                        
                        Button("Bonus") {
                            bonus += 1
                            if bonus == 3 {
                                bonus = 0
                            }
                        }
                    }
                    HStack {
                        if bonus == 1 {
                            
                            Text("Bonus")
                                .foregroundColor(.red)
                                .font(.custom("scoreboard", size: 20))
                            
                            Text("+")
                                .foregroundColor(.black)
                                .font(.custom("scoreboard", size: 20))
                        } else if bonus == 2 {
                            
                            Text("Bonus")
                                .foregroundColor(.red)
                                .font(.custom("scoreboard", size: 20))
                            Text("+")
                                .foregroundColor(.red)
                                .font(.custom("scoreboard", size: 20))
                        } else {
                            Text("Bonus")
                                .foregroundColor(.black)
                                .font(.custom("scoreboard", size: 20))
                            Text("+")
                                .foregroundColor(.black)
                                .font(.custom("scoreboard", size: 20))
                        }
                    }
                }
            }
        }
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        let soccer = Soccer(minutes: 0, seconds: 0, homeScore: 0, guestScore: 0, half: 0, homeShots: 0, guestShots: 0)
        ScoreView(sportSelect: .constant(.soccer), teamSelect: .home)
    }
}
