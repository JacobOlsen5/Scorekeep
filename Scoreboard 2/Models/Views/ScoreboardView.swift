//
//  SoccerScoreboardView.swift
//  Scoreboard 2
//
//  Created by Jake Olsen on 12/15/20.
//

import SwiftUI

struct ScoreboardView: View {
    @State var soccerStats = Soccer(minutes: 0, seconds: 0, homeScore: 0, guestScore: 0, half: 1, homeShots: 0, guestShots: 0)
    @Binding var sportSelection: Sport
    @Binding var teamSelection: Team
    @State var sportName: String = ""
    @State var teamName: String = ""
    @State var guestTeamName: String = ""
    
    func setUpScoreboard() {
        setSportName()
        setSportView()
    }
    func setSportName () {
        switch sportSelection {
        case .soccer:
            sportName = "Soccer"
        case .football:
            sportName = "Football"
        case .baseball:
            sportName = "Baseball"
        case .basketball:
            sportName = "Basketball"
//        default:
//            sportName = "Unknown"
        }
    }
    func setSportView() {
        
    }
    var body: some View {
        
        NavigationView {
            HStack {
                VStack {
                    TextField("Team Name", text: $teamName)
                    ScoreView(sportSelect: $sportSelection, teamSelect: teamSelection)
                }
                Spacer()
                SoccerClockView(soccerStats: soccerStats, sportPicker: sportSelection, sportSelection: sportSelection, teamSelection: teamSelection)
                Spacer()
                VStack {
                    TextField("Team Name", text: $guestTeamName)
                    
                    ScoreView(sportSelect: $sportSelection, teamSelect: teamSelection)
                }
                
            } .onAppear(perform: setUpScoreboard)
            .navigationBarTitle(Text("\(sportName)"))
            
        }
        
    }
    
}

struct SoccerScoreboardView_Previews: PreviewProvider {
    static var previews: some View {
        return ScoreboardView(sportSelection: .constant(.baseball), teamSelection: .constant(.home)).previewLayout(.fixed(width: 2688, height: 1242))
    }
}
