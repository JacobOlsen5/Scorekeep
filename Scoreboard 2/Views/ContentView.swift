//
//  ContentView.swift
//  Scoreboard 2
//
//  Created by Jake Olsen on 12/15/20.
//
import SwiftUI

//struct TodoItem: Identifiable {
//    var id = UUID()
//    var action: String
//}

struct ContentView: View {
    @Binding var teamSelcection: Team
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: ScoreboardView(sportSelection: .constant(.soccer), teamSelection: $teamSelcection)) {
                    Text("Soccer")
                }.buttonStyle(PlainButtonStyle())
                NavigationLink(destination: ScoreboardView(sportSelection: .constant(.football), teamSelection: $teamSelcection)) {
                    Text("Football")
                }.buttonStyle(PlainButtonStyle())
                NavigationLink(destination: ScoreboardView(sportSelection:.constant(.basketball), teamSelection: $teamSelcection)) {
                    Text("Basketball")
                }.buttonStyle(PlainButtonStyle())
                NavigationLink(destination: ScoreboardView(sportSelection: .constant(.baseball), teamSelection: $teamSelcection)) {
                    Text("Baseball")
                }.buttonStyle(PlainButtonStyle())
            }
        }
        
    
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(teamSelcection: .constant(.home))
    }
}

