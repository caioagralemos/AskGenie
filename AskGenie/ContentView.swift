//
//  ContentView.swift
//  AskGenie
//
//  Created by Caio on 28/07/24.
//

import SwiftUI
import GoogleGenerativeAI

struct ContentView: View {
    @State var question = ""
    @FocusState var isFocused: Bool
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle().fill(Color.blue.gradient).ignoresSafeArea().onTapGesture {
                    isFocused = false
                }
                
                VStack {
                    Image("lamp").resizable().scaledToFit().onTapGesture {
                        isFocused = false
                    }
                    TextField("how can I get rich?", text: $question, axis: .vertical).focused($isFocused).textFieldStyle(.roundedBorder)

                    NavigationLink {
                        AnswerView(question: question)
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10).fill(.ultraThinMaterial).frame(width: 200, height: 50)
                            Text("Ask Genie").foregroundStyle(.white).font(.system(size: 18, design: .rounded)).padding(.horizontal)
                        }.padding(.top).opacity(question.isEmpty ? 0.6 : 1)
                    }.disabled(question.isEmpty)
                }.padding().preferredColorScheme(.light)
            }.onDisappear {
                self.question = ""
            }
        }
    }
}

#Preview {
    ContentView()
}
