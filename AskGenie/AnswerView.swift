//
//  AnswerView.swift
//  AskGenie
//
//  Created by Caio on 28/07/24.
//

import SwiftUI
import GoogleGenerativeAI

struct AnswerView: View {
    var question: String
    let model = GenerativeModel(name: "gemini-1.0-pro", apiKey: "")
    @State var answer: String = ""
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            Rectangle().fill(Color.blue.gradient).ignoresSafeArea()
            
            VStack {
                Image("genie").resizable().scaledToFit()
                
                VStack (alignment: .leading) {
                    Text("Genie says...").foregroundStyle(.white).bold()
                    ZStack {
                        RoundedRectangle(cornerRadius: 20).fill(.ultraThinMaterial)
                        if answer.isEmpty {
                            ProgressView()
                        } else {
                            Text(answer).foregroundStyle(.white).multilineTextAlignment(.center).padding(.horizontal).font(.system(size: 18, design: .rounded))
                        }
                    }.frame(maxHeight: 150).task {
                        do {
                            let response = try await model.generateContent("please give me the ANSWER to this question with no markdown or stuff like that, just plain text, and max 100 characters. the question is: \(question)")
                            if let text = response.text {
                                answer = text
                            }
                        } catch {
                            print("something went wrong")
                        }
                    }
                }.padding()
            }
        }.preferredColorScheme(.light)
        
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        HStack {
                            Text("< Back").bold()
                        }.foregroundStyle(.white)
                    }
                }
            }
    }
}

#Preview {
    AnswerView(question: "Como posso ficar rico?")
}
