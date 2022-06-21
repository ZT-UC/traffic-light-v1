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
            ForEach(0..<1, id: \.self) { light in
                VStack {
                    circle
                        .foregroundColor(0 < properties.countFrom && properties.countFrom <= 7 ? .red : .gray)
                        //.foregroundColor(.gray)
                    circle
                        .foregroundColor(6 <= properties.countFrom && properties.countFrom <= 7 ? .orange : .gray)
                        //.foregroundColor(properties.countFrom % 2 == 0 ? .gray : .orange)
                    circle
                        .foregroundColor(properties.countFrom >= 8 && properties.countFrom <= properties.endCountOn ? .green : .gray)
                        //.foregroundColor(.gray)
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
                            properties.countFrom = 0
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
                            } else {
                                properties.NightModeButtonTurnedOff.toggle()
                            }
                            
                            if properties.NightModeButtonTurnedOff == false {
                                properties.isTimerRunning = true
                            } else {
                                properties.isTimerRunning = false
                                properties.countFrom = 0
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
                            } else {
                                properties.NormalModeButtonTurnedOff.toggle()
                            }
                            
                            if properties.NormalModeButtonTurnedOff == false {
                                properties.isTimerRunning = true
                            } else {
                                properties.isTimerRunning = false
                                properties.countFrom = 0
                            }
                        }
                    }
                    .scaleEffect(properties.NormalModeButtonTurnedOff ? 1.0 : 0.5)
                }
            .disabled(properties.PowerButtonButtonTurnedOff)
            .onReceive(properties.timer) { _ in
                if properties.isTimerRunning {
                    self.properties.countFrom += 1
                } else {
                    properties.isTimerRunning = false
                }

                if properties.countFrom == 13 {
                    properties.countFrom = 1
                }
            }
        }
        // MARK: Spacer #3
        Spacer()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
