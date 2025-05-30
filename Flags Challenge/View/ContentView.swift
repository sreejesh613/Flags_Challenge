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
            ZStack {
                VStack {
                    HStack(alignment: .center) {
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
                        Spacer()
                    }
                    .padding(.top, 20.0)
                    .padding(.horizontal, 10)
                    Divider()
                        .frame(height: 1.0)
                    Spacer()
                    
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.black)
                                .frame(width: 50.0, height: 35.0)
                            Circle()
                                .fill(Color(red: 255/255.0, green: 112/255.0, blue: 67/255.0, opacity: 1.0))
                                .frame(width: 35.0, height: 35.0)
                            Text("1")
                                .foregroundStyle(.white)
                        }
                        Spacer()
                        Text("GUESS THE COUNTRY FROM THE FLAG?")
                        Spacer()
                    }
                    HStack {
                        ZStack {
                            Image("13")
                                .frame(width: 72.0, height: 58.0)
                                .applyBaseViewStyle()
                                .frame(width: 120.0, height: 90.0)
                        }
                        Spacer()
                        customButtons()
                    }
                    .padding()
                    Spacer()
                }
                .applyBaseViewStyle()
            }
            .frame(width: .infinity, height: 270)
            .padding(.horizontal, 5.0)
        }
        Spacer()
    }

    private func customButtons() -> some View {
        HStack {
            VStack {
                Button(action: {
                    //button action
                }) {
                    Text("Button A")
                }
                .buttonStyle(CustomButtonStyle())
                Button(action: {
                    //button action
                }) {
                    Text("Button B")
                }
                .buttonStyle(CustomButtonStyle())
            }
            VStack {
                Button(action: {
                    //button action
                }) {
                    Text("Button C")
                }
                .buttonStyle(CustomButtonStyle())
                Button(action: {
                    //button action
                }) {
                    Text("Button D")
                }
                .buttonStyle(CustomButtonStyle())
            }
        }
    }
}

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        return configuration.label
            .padding()
            .foregroundColor(Color(red: 58/255, green: 58/255, blue: 58/255, opacity: 1))
            .opacity(configuration.isPressed ? 0.7 : 1)
            .scaleEffect(configuration.isPressed ? 0.8 : 1)
            .frame(maxWidth: .infinity, maxHeight: 32.0)
            .overlay {
                RoundedRectangle(cornerRadius: 8.0)
                    .stroke(Color(red: 72/255, green: 72/255, blue: 72/255, opacity: 1))
            }
    }
}

#Preview {
    ContentView()
}
