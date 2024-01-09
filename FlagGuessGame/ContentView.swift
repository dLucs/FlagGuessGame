//
//  ContentView.swift
//  FlagGuessGame
//
//  Created by Lucas on 26/12/23.
//

import SwiftUI

struct ContentView: View {
    @State private var numberOfQuestions = 0
    @State private var totalScore = 0
    @State private var showingScore = false
    @State private var endGame = false
    @State private var scoreTitle = ""
    @State private var endTitle = "Game Finished!"
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)],
                           center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            VStack{
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                VStack(spacing: 15){
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3){number in
                        Button{
                            flagSelected(number)
                        }label: {
                            Image(countries[number])
                                .clipShape(.rect(cornerRadius: 20))
                                .shadow(radius: 5)
                        }
                    }
                    
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                Spacer()
                Spacer()
                
                Text("Score: \(totalScore)")
                    .foregroundStyle(.white)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/.bold())
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: continueGame)
        }message: {
            Text("Your score is: \(totalScore)")
        }
        .alert(endTitle, isPresented: $endGame){
            Button("Restart", action: restartGame)
        }message: {
            Text("Your score is: \(totalScore) / 8")
        }
        
    }
    func flagSelected(_ number: Int){
        if number ==  correctAnswer{
            scoreTitle = "Correct!"
            totalScore += 1
        }else{
            scoreTitle = "Wrong! thats the flag of \(countries[number]) "
        }
        numberOfQuestions += 1
        if numberOfQuestions == 8{
            endGame = true
        }else {
            showingScore = true
        }
    }
    
    func continueGame() {
        
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
    }
    func restartGame(){
        numberOfQuestions = 0
        totalScore = 0
        continueGame()
    }
}

#Preview {
    ContentView()
}
