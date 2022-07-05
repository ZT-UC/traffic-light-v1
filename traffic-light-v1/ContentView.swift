//
//  ContentView.swift
//  traffic-light-v1
//
//  Created by Dominik Ď. on 13/06/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            LightsButtonsView()
        }
    }
}

class Properties: ObservableObject {
    // Power button
    @Published var PowerButtonButtonTurnedOff: Bool = true
    
    // Night mode button
    @Published var NightModeButtonTurnedOff: Bool = true
    
    // Normal mode button
    @Published var NormalModeButtonTurnedOff: Bool = true
    
    // Timer related
    @Published var isTimerRunning: Bool = false
    @Published var timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    @Published var countFrom: Int = 0
    @Published var endCountOn: Int = 12
}

struct LightsButtonsView: View {
    // properties setup
    @StateObject var properties: Properties = Properties()
    
    // circle declaration
    let circle = Circle()

    var body: some View {
        // MARK: Spacer #1
        Spacer()
        
        VStack(spacing: 25) {
            // MARK: Logic for Normal / Night Mode
            HStack {
                VStack {
                    circle
                        .foregroundColor(properties.NormalModeButtonTurnedOff == false && 0 <= properties.countFrom && properties.countFrom <= 7 ? .red : .gray)
                    circle
                        .foregroundColor(
                            properties.NormalModeButtonTurnedOff == false && 6 <= properties.countFrom && properties.countFrom <= 7
                            ||
                            properties.NightModeButtonTurnedOff == false && 0 <= properties.countFrom && properties.countFrom % 2 == 0 ? .orange : .gray)
                    circle
                        .foregroundColor(properties.NormalModeButtonTurnedOff == false && properties.countFrom >= 8 && properties.countFrom <= properties.endCountOn ? .green : .gray)
                }
                .frame(height: 300)
            }

            Text("Elapsed second(s): \(properties.countFrom)")
        }
        // MARK: Spacer #2
        Spacer()
        HStack {
            // MARK: Power Button
            Button {
                //
            } label: {
                Image(systemName: "power")
                    .font(.system(size: 50))
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        properties.NightModeButtonTurnedOff = true
                        properties.NormalModeButtonTurnedOff = true
                        properties.PowerButtonButtonTurnedOff.toggle()
                        
                        if properties.isTimerRunning {
                            properties.isTimerRunning = false
                            resetCounter()
                        }
                    }
                }
            }
            .foregroundColor(properties.PowerButtonButtonTurnedOff ? .black : .green)
            .scaleEffect(properties.PowerButtonButtonTurnedOff ? 1 : 0.5)
            
            // MARK: Night Mode Button
            Button {
                //
            } label: {
                Image(systemName: "moon.fill")
                    .font(.system(size: 50))
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            if properties.NormalModeButtonTurnedOff == false {
                                properties.NightModeButtonTurnedOff = false
                                properties.NormalModeButtonTurnedOff = true
                                resetCounter()
                            } else {
                                properties.NightModeButtonTurnedOff.toggle()
                            }
                            
                            if properties.NightModeButtonTurnedOff == false {
                                properties.isTimerRunning = true
                            } else {
                                properties.isTimerRunning = false
                                resetCounter()
                            }
                        }
                    }
                    .scaleEffect(properties.NightModeButtonTurnedOff ? 1.0 : 0.5)
                }
            .disabled(properties.PowerButtonButtonTurnedOff)
            
            // MARK: Normal Mode Button
            Button {
                //
            } label: {
                Image(systemName: "sun.max.fill")
                    .font(.system(size: 50))
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            if properties.NightModeButtonTurnedOff == false {
                                properties.NormalModeButtonTurnedOff = false
                                properties.NightModeButtonTurnedOff = true
                                resetCounter()
                            } else {
                                properties.NormalModeButtonTurnedOff.toggle()
                            }
                            
                            if properties.NormalModeButtonTurnedOff == false {
                                properties.isTimerRunning = true
                            } else {
                                properties.isTimerRunning = false
                                resetCounter()
                            }
                        }
                    }
                    .scaleEffect(properties.NormalModeButtonTurnedOff ? 1.0 : 0.5)
                }
            .disabled(properties.PowerButtonButtonTurnedOff)
            
            // MARK: Timers for modes
            .onReceive(properties.timer, perform: { _ in
                if properties.NormalModeButtonTurnedOff == true {
                    timerForNightMode()
                } else {
                    timerForNormalMode()
                }
            })
        }
        // MARK: Spacer #3
        Spacer()
    }
    
    func timerForNormalMode() {
        if properties.isTimerRunning {
            self.properties.countFrom += 1
        } else {
            properties.isTimerRunning = false
        }

        if properties.countFrom == 13 {
            properties.countFrom = 1
        }
    }
    
    func timerForNightMode() {
        if properties.isTimerRunning {
            self.properties.countFrom += 1
        } else {
            properties.isTimerRunning = false
        }

        if properties.countFrom == 4 {
            resetCounter()
        }
    }
    
    func resetCounter() {
        properties.countFrom = 0
        return
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
