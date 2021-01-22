//
//  FootballScoreboardView.swift
//  Scoreboard 2
//
//  Created by Jake Olsen on 1/13/21.
//

import SwiftUI

struct FootballScoreboardView: View {
    @State var footballStats = Football(down: 0, toGo: 0, ballOn: 0, homeScore: 0, guestScore: 1, homeTimeouts: 0, guestTimeouts: 10, quarter: 0, minutes: 15, seconds: 0, possession: 1, playClock: 25)
    
//    init() {
//        // 1.
//        UINavigationBar.appearance().backgroundColor = .darkGray
//        
//        // 2.
//        UINavigationBar.appearance().largeTitleTextAttributes = [
//            .foregroundColor: UIColor.darkGray,
//            .font : UIFont(name:"Papyrus", size: 40)!]
//        
//        // 3.
//        UINavigationBar.appearance().titleTextAttributes = [
//            .font : UIFont(name: "HelveticaNeue-Thin", size: 20)!]
//    }
    var body: some View {
        HStack {
            FootballHomeScoreView(footballStats: footballStats)
            Spacer()
        }
    }
}
    struct FoootballScoreboardView_Previews: PreviewProvider {
        static var previews: some View {
            return ScoreboardView(sportSelection: .constant(.football), teamSelection: .constant(.guest)).previewLayout(.fixed(width: 2688, height: 1242))
        }
    
}
