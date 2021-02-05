//
//  SoccerClockView.swift
//  Scoreboard 2
//
//  Created by Jake Olsen on 1/12/21.
//

import SwiftUI
import AVKit

struct SoccerClockView: View {
    @ObservedObject var soccerStats: Soccer
    @State var timer: Timer? = nil
    @State var sportPicker: Sport? = nil
    @State var onBase: Bool = false
    @State var onBase2: Bool = false
    @State var onBase3: Bool = false
    @State var ball: Int = 0
    @State var strike: Int = 0
    @State var out: Int = 0
    @State var down: String = ""
    @State var basketballPosession: Int = 1
    @State var footballPosession: Int = 1
    @State var minutes: Int = 0
    @State var showingDetail = false
    @State var sportSelection: Sport
    @State var teamSelection: Team
    @State var clockSeconds: Int
    @State var clockMinutes: Int
    @State var clockTenths: Int
    @State var resetMinutes = 0
    @State var resetSeconds = 0
    @State var periodNumber: Int = 1
    @State var atBat: String = ""
    @State var toGo: String = ""
    @State var ballOn: String = ""
    @State var homeBonus: Int = 0
    @State var guestBonus: Int = 0
    @State var player: AVAudioPlayer?
    
    
    fileprivate func beginTimer() {
        if sportPicker == .soccer {
            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
                clockTenths += 1
                if clockTenths == 10{
                    clockTenths = 0
                    clockSeconds += 1
                }
                if clockSeconds == 60 {
                    clockMinutes += 1
                    clockSeconds = 0
                }
            }
        } else if sportPicker == .football || sportPicker == .basketball {
            
            //            Run every 0.1 second to change the numbers in the timer
            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
                clockTenths -= 1
                if clockTenths < 0 {
                    clockTenths = 9
                    clockSeconds -= 1
                }
                if clockSeconds < 0 {
                    clockSeconds = 59
                    clockMinutes -= 1
                }
                if clockMinutes < 0 {
                    clockMinutes = 0
                }
                
                
                if clockMinutes == 0 && clockSeconds == 0 && clockTenths == 0 {
                    timer.invalidate()
                    DispatchQueue.global(qos: .background).async {
                        let sound = Bundle.main.path(forResource: "buzzer2", ofType: "mp3")
                        do {
                            player = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
                            DispatchQueue.main.async {
                                if let player = player {
                                    player.play()
                                }
                            }
                        } catch  {
                            print("Error")
                        }
                    }
                }
            } // End timer
        }
    }
    var body: some View {
        ZStack {
            
            Color.black
                .ignoresSafeArea()
            VStack() {
                
                
                VStack {
                    
                    if  sportPicker == .soccer || sportPicker == .football || sportPicker == .basketball {
                        Text("\(clockMinutes, specifier: "%02d"):\(clockSeconds, specifier: "%02d"). \(clockTenths)").font(Font.custom("Open24DisplaySt", size: 40))
                            .frame(width: 118, height: 110, alignment: .trailing)
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                        
                        HStack {
                            Button("Set") {
                                self.showingDetail.toggle()
                                timer?.invalidate()
                                
                                
                            }.sheet (isPresented: $showingDetail){
                                ClockSetterView(soccerStats: soccerStats, teamSelection: teamSelection, clockMinutes: $clockMinutes, sportSelection: $sportSelection, clockSeconds: $clockSeconds, resetMinutes: $resetMinutes, resetSeconds: $resetSeconds)
                                
                            }
                            
                            Button("Start") {
                                beginTimer()
                            }
                            
                            Button("Stop") {
                                timer?.invalidate()
                                
                            }
                            
                            Button("Reset") {
                                
                                timer?.invalidate()
                                if sportSelection == .soccer {
                                    clockMinutes = 0
                                    clockSeconds = 0
                                    clockTenths = 0
                                } else if sportSelection == .football || sportSelection == .basketball {
                                    clockMinutes = resetMinutes
                                    clockSeconds = resetSeconds
                                    clockTenths = 0
                                    
                                }
                            }
                        }
                    }
                }
                if  sportPicker == .soccer {
                    VStack {
                        HStack {
                            Text("HALF:")
                                .foregroundColor(.red)
                                .font(.custom("scoreboard", size: 20))
                            Text("\(periodNumber)")
                                .foregroundColor(.yellow)
                                .font(Font.custom("Open24DisplaySt", size: 20))
                        }
                        
                        
                        Button("Half +1") {
                            periodNumber += 1
                        }
                        Button("Half -1") {
                            periodNumber -= 1
                        }
                        
                        Button("Reset Half") {
                            periodNumber = 1
                        }
                    }
                    
                } else  if  sportPicker == .football {
                    Button("Horn") {
                        if let player = player {
                            player.play()
                        }
                    }
                    HStack {
                        Text("QUARTER:")
                            .foregroundColor(.red)
                            .font(.custom("scoreboard", size: 20))
                        Text("\(periodNumber)")
                            .foregroundColor(.yellow)
                            .font(Font.custom("Open24DisplaySt", size: 20))
                    }
                   

                    
                    HStack {
                        Button("+1") {
                            periodNumber += 1
                        }
                        Button("-1") {
                            periodNumber -= 1
                        }
                        
                        Button("Reset") {
                            periodNumber = 1
                        }
                    }
                    HStack {
                        Button("< >") {
                            if footballPosession == 1 {
                                footballPosession  = 2
                            } else if footballPosession == 2 {
                                footballPosession  = 1
                            }
                        }
                        if footballPosession == 1 {
                            HStack {
                                Image(systemName: "circle.fill")
                                    .foregroundColor(.red)
                                Text("Possesion")
                                    .font(.custom("scoreboard", size: 20))
                                    .foregroundColor(.red)
                                Image(systemName: "circle.fill").foregroundColor(.black)
                            }
                        } else if footballPosession == 2 {
                            HStack {
                                Image(systemName: "circle.fill").foregroundColor(.black)
                                Text("Possesion")
                                    .foregroundColor(.red)
                                    .font(.custom("scoreboard", size: 20))
                                Image(systemName: "circle.fill").foregroundColor(.red)
                            }
                        } else {
                            HStack {
                                Image(systemName: "circle.fill").foregroundColor(.black)
                                Text("Possesion")
                                    .foregroundColor(.red)
                                    .font(.custom("scoreboard", size: 20))
                                Image(systemName: "circle.fill").foregroundColor(.black)
                            }
                        }
                    }
                    HStack {
                        TextField("Down", text: $down)
                            .foregroundColor(.red)
                            .font(.custom("scoreboard", size: 20))
                           
                        Text("And")
                           .foregroundColor(.red)
                           .font(.custom("scoreboard", size: 20))
                        TextField("To Go", text: $toGo)
                            .foregroundColor(.red)
                            .font(.custom("scoreboard", size: 20))
                            .frame(width: 150, height: 60, alignment: .trailing)
                    }
                    HStack {
                        Text("Ball On:")
                            .foregroundColor(.red)
                            .font(.custom("scoreboard", size: 20))
                        
                        TextField("Ball On", text: $ballOn)
                            .foregroundColor(.orange)
                            .font(.custom("Open24DisplaySt", size: 20))
                        
                    }
                } else if sportPicker == .baseball {
                    
                    
                    VStack {
                        HStack {
                            Text("Inning:")
                                .font(.custom("scoreboard", size: 20))
                                .foregroundColor(.red)
                            Text("\(periodNumber)")
                                .foregroundColor(.yellow)
                                .font(Font.custom("Open24DisplaySt", size: 20))
                        }
                        
                        Button("Inning +1") {
                            periodNumber += 1
                        }
                        Button("Inning -1") {
                            periodNumber -= 1
                        }
                        
                        Button("Reset Inning") {
                            periodNumber = 1
                        }
                        HStack {
                            Button("1st") {
                                if onBase == false {
                                    onBase = true
                                } else {
                                    onBase = false
                                }
                            }
                            Button("2nd") {
                                if onBase2 == false {
                                    onBase2 = true
                                } else {
                                    onBase2 = false
                                }
                            }
                            Button("3rd") {
                                if onBase3 == false {
                                    onBase3 = true
                                } else {
                                    onBase3 = false
                                }
                            }
                            Button("Reset") {
                                onBase = false
                                onBase2 = false
                                onBase3 = false
                            }
                        }
                        VStack {
                            if onBase2 == true {
                                Image(systemName: "square.fill").foregroundColor(.yellow)
                            } else {
                                Image(systemName: "square.fill").foregroundColor(.black)
                            }
                            HStack {
                                if onBase3 == true {
                                    Image(systemName: "square.fill").foregroundColor(.yellow)
                                } else {
                                    Image(systemName: "square.fill").foregroundColor(.black)
                                }
                                
                                if onBase == true {
                                    Image(systemName: "square.fill").foregroundColor(.yellow)
                                } else {
                                    Image(systemName: "square.fill").foregroundColor(.black)
                                }
                            }
                            VStack {
                                HStack {
                                    Text("Ball: ")
                                        .foregroundColor(.red )
                                        .font(.custom("scoreboard", size: 20))
                                    Text("\(ball)")
                                        .foregroundColor(.yellow)
                                        .font(Font.custom("Open24DisplaySt", size: 20))
                                    Button("Ball +1") {
                                        ball += 1
                                        if ball == 4 {
                                            ball = 0
                                            strike = 0
                                        }
                                        
                                    }
                                    
                                    Button("Reset Balls") {
                                        ball = 0
                                    }
                                }
                                
                                HStack {
                                    Text("Strike: ")
                                        .foregroundColor(.red)
                                        .font(.custom("scoreboard", size: 20))
                                    Text("\(strike)")
                                        .foregroundColor(.orange)
                                        .font(Font.custom("Open24DisplaySt", size: 20))
                                    Button("Strike +1") {
                                        strike += 1
                                        if strike == 3 {
                                            out += 1
                                            ball = 0
                                            strike = 0
                                        }
                                        if out == 3 {
                                            ball = 0
                                            strike = 0
                                            out = 0
                                        }
                                    }
                                }
                                
                                Button("Reset Strikes") {
                                    strike = 0
                                }
                                
                            }
                            
                        }
                        
                        HStack {
                            Text("Out: ")
                                .foregroundColor(.red)
                                .font(.custom("scoreboard", size: 20))
                            Text("\(out)")
                                .foregroundColor(.red)
                                .font(Font.custom("Open24DisplaySt", size: 20))
                            Button("Out +1") {
                                out += 1
                                if out == 3 {
                                    ball = 0
                                    strike = 0
                                    out = 0
                                }
                            }
                        }
                        Button("Reset Outs") {
                            out = 0
                        }
                    }
                    HStack {
                        Text("At Bat:")
                            .foregroundColor(.red)
                            .font(.custom("scoreboard", size: 20))
                        
                        TextField("At Bat", text: $atBat)
                            .foregroundColor(.orange)
                            .font(.custom("Open24DisplaySt", size: 20))
                    }
                    
                } else {
                    // Basketball
                    VStack {
                        Button("Horn") {
                            if let player = player {
                                player.play()
                            }
                        }
                        Button("< >") {
                            if basketballPosession == 1 {
                                basketballPosession  = 2
                            } else if basketballPosession == 2 {
                                basketballPosession  = 1
                            }
                        }
                        if basketballPosession == 1 {
                            HStack {
                                Image(systemName: "circle.fill").foregroundColor(.red)
                                Text("Possesion")
                                    .foregroundColor(.red)
                                    .font(.custom("scoreboard", size: 20))
                                Image(systemName: "circle.fill").foregroundColor(.black)
                            }
                        } else if basketballPosession == 2 {
                            HStack {
                                Image(systemName: "circle.fill").foregroundColor(.black)
                                Text("Possesion")
                                    .foregroundColor(.red)
                                    .font(.custom("scoreboard", size: 20))
                                Image(systemName: "circle.fill").foregroundColor(.red)
                            }
                        } else {
                            HStack {
                                Image(systemName: "circle.fill").foregroundColor(.black)
                                Text("Possesion")
                                    .foregroundColor(.red)
                                    .font(.custom("scoreboard", size: 20))
                                Image(systemName: "circle.fill").foregroundColor(.black)
                            }
                        }
                    }
                    
                    HStack {
                        Text("Period:")
                            .foregroundColor(.red)
                            .font(.custom("scoreboard", size: 20))
                        Text("\(periodNumber)")
                            .foregroundColor(.yellow)
                            .font(Font.custom("Open24DisplaySt", size: 20))
                    }
                    
                    HStack {
                        Button("Period +1") {
                            periodNumber += 1
                        }
                        Button("Period -1") {
                            periodNumber -= 1
                        }
                    }
                    Button("Reset Period") {
                        periodNumber = 1
                    }
                    HStack {
                        Button("<") {
                            homeBonus += 1
                            print(homeBonus)
                            if homeBonus == 3 {
                                homeBonus = 0
                            }
                        }
                        Button(">") {
                            guestBonus += 1
                            print(guestBonus)
                            if guestBonus == 3 {
                                guestBonus = 0
                            }
                        }
                    }
                    HStack {
                        if homeBonus == 1 {
                            HStack {
                                Image(systemName: "circle.fill").foregroundColor(.black)
                                Image(systemName: "circle.fill").foregroundColor(.red)
                            }
                        } else if homeBonus == 2 {
                            HStack {
                                Image(systemName: "circle.fill").foregroundColor(.red)
                                Image(systemName: "circle.fill").foregroundColor(.red)
                            }
                        } else {
                            HStack {
                                Image(systemName: "circle.fill").foregroundColor(.black)
                                Image(systemName: "circle.fill").foregroundColor(.black)
                            }
                        }
                        Text("Bonus")
                            .foregroundColor(.red)
                            .font(.custom("scoreboard", size: 20))
                        if guestBonus == 1 {
                            HStack {
                                Image(systemName: "circle.fill").foregroundColor(.red)
                                Image(systemName: "circle.fill").foregroundColor(.black)
                            }
                        } else if guestBonus == 2 {
                            HStack {
                                Image(systemName: "circle.fill").foregroundColor(.red)
                                Image(systemName: "circle.fill").foregroundColor(.red)
                            }
                        } else {
                            HStack {
                                Image(systemName: "circle.fill").foregroundColor(.black)
                                Image(systemName: "circle.fill").foregroundColor(.black)
                            }
                        }
                    }
                }
            }
        }
        
    }
}
struct SoccerClockView_Previews: PreviewProvider {
    static var previews: some View {
        let soccer = Soccer(minutes: 0, seconds: 0, homeScore: 0, guestScore: 0, half: 0, homeShots: 0, guestShots: 0)
        ScoreView(sportSelect: .constant(. football), teamSelect: .guest)
    }
}

