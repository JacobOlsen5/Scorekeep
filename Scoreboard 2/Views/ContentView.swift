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
            HStack {
                NavigationLink(destination: ScoreboardView(sportSelection: .constant(.soccer), teamSelection: $teamSelcection)) {
                    VStack {
                        Image("soccer_ball")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100)
                        Text("Soccer")
                           
                        
                    }
                }
                Spacer()
                NavigationLink(destination: ScoreboardView(sportSelection: .constant(.football), teamSelection: $teamSelcection)) {
                    VStack {
                        Image("football")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100)
                        Text("Football")
                    }
                }
                Spacer()
                NavigationLink(destination: ScoreboardView(sportSelection:.constant(.basketball), teamSelection: $teamSelcection)) {
                    VStack {
                        Image("basketball")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100)
                        Text("Basketball")
                    }
                }
                Spacer()
                NavigationLink(destination: ScoreboardView(sportSelection: .constant(.baseball), teamSelection: $teamSelcection)) {
                    VStack {
                        Image("baseball")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100)
                        Text("Baseball")
                    }
                }
                .navigationBarTitle("Welcome to Scorekeep", displayMode: .inline)
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(teamSelcection: .constant(.home))
        
    }
}

