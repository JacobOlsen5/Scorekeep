//
//  ClockSetterView.swift
//  Scoreboard 2
//
//  Created by Jake Olsen on 1/12/21.
//

import SwiftUI

struct ClockSetterView: View {
    @State var soccerStats: Soccer
    @State var teamSelection: Team
    @Binding var clockMinutes: Int
    @Binding var sportSelection: Sport
    @State var clockSeconds: Int
    @State var showingDetail = false
    var availableSecondsMinutes = Array(0...59)
    
    var body: some View {
        VStack {
            Button("Set The Clock") {
                self.showingDetail.toggle()
                
            }.sheet (isPresented: $showingDetail){
                ScoreboardView(soccerStats: soccerStats, sportSelection: $sportSelection, teamSelection: $teamSelection)
            }
            Text("Set The Clock")
            
            HStack {
                ForEach(0 ..< availableSecondsMinutes.count) {
                    Text("\(self.availableSecondsMinutes[$0]) min")
                }
            }
            HStack {
                Picker(selection: $clockMinutes, label: Text("")) {
                    ForEach(0 ..< availableSecondsMinutes.count) {
                        Text("\(self.availableSecondsMinutes[$0])")
                    }
                }
                Picker(selection: $clockSeconds, label: Text("")) {
                    ForEach(0 ..< availableSecondsMinutes.count) {
                        Text("\(self.availableSecondsMinutes[$0])")
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
    
    
}
struct ClockSetterView_Previews: PreviewProvider {
    @State static var sportSelection: Sport = .soccer
    @State static var teamSelection: Team = .guest
    @State static var clockMinutes: Int = 0
    @State static var clockSeconds: Int = 0

    
    static var previews: some View {
        
        
        ClockSetterView(soccerStats: Soccer(minutes: 0, seconds: 0, homeScore: 0, guestScore: 0, half: 1, homeShots: 0, guestShots: 0), teamSelection: .home, clockMinutes: .constant(0), sportSelection: $sportSelection, clockSeconds: 0)
    }
}
