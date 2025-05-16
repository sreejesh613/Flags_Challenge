//
//  ContentView.swift
//  Flags Challenge
//
//  Created by Sreejesh Krishnan on 16/05/25.
//

import SwiftUI

struct ContentView: View {
    @State var timeRemaining = 10
    var body: some View {
        VStack {
            HStack {
                let timer = Timer.publish(
                    every: 1,
                    on: .main,
                    in: .common).autoconnect()
                Text("\(timeRemaining)")
                    .onReceive(timer) { _ in
                        if timeRemaining > 0 {
                            print("timer running")
                            timeRemaining -= 1
                            print("\(timeRemaining)")
                        }
                    }
                Spacer()
                Text("FLAGS CHALLENGE")
            }
            .border(.blue)
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

//class QuestionTimer: ObservableObject {
//    @Published var timeRemaining = 10
//    var timer = Timer.publish(
//        every: 1,
//        on: .main,
//        in: .common).autoconnect()
//    Text("\(timeRemaining)")
//        .onReceive(timer) { _ in
//            if timeRemaining > 0 {
//                print("timer running")
//                timeRemaining = timeRemaining - 1
//                print("\(timeRemaining)")
//            }
//        }
//}

#Preview {
    ContentView()
}
