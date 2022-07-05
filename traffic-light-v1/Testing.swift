//
//  Testing.swift
//  traffic-light-v1
//
//  Created by Dominik Ď. on 03/07/2022.
//

import SwiftUI

import Combine

struct Testing: View {
    @State var secondsElapsed = 0
    @State var timer: Timer.TimerPublisher = Timer.publish(every: 1, on: .main, in: .common)
    @State var connectedTimer: Cancellable? = nil
    
    var body: some View {
        VStack {
            Text("\(self.secondsElapsed) seconds elapsed")
            Button("Stop Timer", action: {
                self.cancelTimer()
            })
            Button("Continue Timer", action: {
                self.instantiateTimer()
            })
            Button("Restart Timer", action: {
                self.restartTimer()
            })
        }.onAppear {
            self.instantiateTimer()
        }.onDisappear {
            self.cancelTimer()
        }.onReceive(timer) { _ in
            self.secondsElapsed += 1
        }
    }
    
    func instantiateTimer() {
        self.timer = Timer.publish(every: 1, on: .main, in: .common)
        self.connectedTimer = self.timer.connect()
        return
    }
    
    func cancelTimer() {
        self.connectedTimer?.cancel()
        return
    }
    
    func resetCounter() {
        self.secondsElapsed = 0
        return
    }
    
    func restartTimer() {
        self.secondsElapsed = 0
        self.cancelTimer()
        self.instantiateTimer()
        return
    }
}

struct Testing_Previews: PreviewProvider {
    static var previews: some View {
        Testing()
    }
}
