//
//  TimeEntryView.swift
//  Flags Challenge
//
//  Created by Sreejesh Krishnan on 20/05/25.
//

import SwiftUI
import AEOTPTextField

struct TimeEntryView: View {
    @State private var time: String = ""
    @State private var navPath = NavigationPath()

    var body: some View {
        VStack {
            NavigationStack(path: $navPath) {
                VStack(alignment: .center) {
                    Text("FLAGS CHALLENGE")
                        .foregroundStyle(.red)
                        .fontWeight(.heavy)
                        .bold()
                }
                .padding(.horizontal, 10)
                Divider()
                    .frame(height: 1.0)
                Text("SCHEDULE")
                    .fontWeight(.heavy)
                    .bold()
                    .border(.black)
                    .padding(.top, 10)
                VStack {
                    AEOTPView(text: $time, otpFilledBorderColor: .clear)
                        .padding(.bottom, 40)
                    NavigationLink {
                        ContentView()
                    } label: {
                        Text("Save")
                    }
                }
            }
        }
        .frame(maxHeight: 270.0)
        .background(RoundedRectangle(cornerRadius: 16, style: .continuous).fill(Color(red: 217/255.0, green: 217/255.0, blue: 217/255.0, opacity: 0.3)))
        .padding(.leading, 5)
        .padding(.trailing, 5)
        Spacer()
    }
}

#Preview {
    TimeEntryView()
}
