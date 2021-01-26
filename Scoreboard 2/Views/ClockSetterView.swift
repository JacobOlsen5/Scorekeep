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
    @Binding var clockSeconds: Int
    @State var showingDetail = false
    @Environment(\.presentationMode) var presentationMode
    @Binding var resetMinutes: Int
    @Binding var resetSeconds: Int
    var availableSecondsMinutes = Array(0...59)
    
    var body: some View {
        VStack {
            Button("Set The Clock") {
                resetMinutes = clockMinutes
                resetSeconds = clockSeconds
                self.presentationMode.wrappedValue.dismiss()
                
            }.sheet (isPresented: $showingDetail){
                ScoreboardView(soccerStats: soccerStats, sportSelection: $sportSelection, teamSelection: $teamSelection)
            }
            HStack {
                ForEach(0 ..< availableSecondsMinutes.count) {
                    Text("\(self.availableSecondsMinutes[$0]) min")
                }
            }
            HStack {
                Picker(selection: $clockMinutes, label: Text("Minutes")) {
                    ForEach(0 ..< availableSecondsMinutes.count) {
                        Text("\(self.availableSecondsMinutes[$0]) min")
                    }
                }
                Text(":")
                Picker(selection: $clockSeconds, label: Text("Seconds")) {
                    ForEach(0 ..< availableSecondsMinutes.count) {
                        Text("\(self.availableSecondsMinutes[$0]) sec")
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
        
        
        ClockSetterView(soccerStats: Soccer(minutes: 0, seconds: 0, homeScore: 0, guestScore: 0, half: 1, homeShots: 0, guestShots: 0), teamSelection: .home, clockMinutes: .constant(0), sportSelection: $sportSelection, clockSeconds: .constant(0), resetMinutes: .constant(0), resetSeconds: .constant(0)
        )
    }
}
