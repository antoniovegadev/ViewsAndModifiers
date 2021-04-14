//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Antonio Vega on 4/13/21.
//

import SwiftUI

struct Tile: View {
    var body: some View {
        Color.red
            .frame(width: 90, height: 90)
            .font(.title)
            .border(Color.white, width: 2)
    }
}

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<rows) { row in
                HStack(spacing: 0) {
                    ForEach(0..<columns) { col in
                        self.content(row, col)
                    }
                }
            }
        }
    }
}

enum GameStatus {
    case active
    case winner
    case tie
}

struct ContentView: View {
    @State private var buttonMarks = Array(repeating: "", count: 9)
    @State private var isXTurn = true
    @State private var invalidMove = false
    @State private var gameOverAlert = false
    @State private var alertMessage = ""

    var body: some View {
        ZStack {
            Color.red.edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Tic-Tac-Toe")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
                    .padding()
                    .background(Color.red.clipShape(Capsule()))
                    .overlay(Capsule().stroke(Color.white, lineWidth: 5))
                    .padding()
                
               
                
                Spacer()
                Text("\(isXTurn ? "X's" : "O's") turn")
                    .font(.title2)
                    .foregroundColor(.white)
                    .bold()
                GridStack(rows: 3, columns: 3) { row, col in
                    Button(action: {
                        tapped(button: row*3 + col)
                    }) {
                        ZStack {
                            Tile()
                            
                            Image(systemName: buttonMarks[row*3 + col])
//                                .renderingMode(.original)
                                .resizable()
                                .foregroundColor(.white)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30)
                        }
                    }
                }
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.white, lineWidth: 3.5))
                
                Spacer()
            }
           
        }
        
        
        .alert(isPresented: $gameOverAlert, content: {
            Alert(title: Text("Game Over"), message: Text(alertMessage), dismissButton: .default(Text("New Game"), action: {
                resetGame()
            }))
        })
    }
    
    func tapped(button: Int) {
        if buttonMarks[button] != "" {
            return
        }
        
        buttonMarks[button] = isXTurn ? "xmark" : "circlebadge"
        
        let status = gameStatus()
        
        if status == .winner {
            alertMessage = "\(isXTurn ? "X" : "O") won!"
            gameOverAlert = true
        } else if status == .tie {
            alertMessage = "Tied Game!"
            gameOverAlert = true
        }
        
        isXTurn.toggle()
    }
    
    func gameStatus() -> GameStatus {
        if buttonMarks[0] != "" && buttonMarks[0] == buttonMarks[1] && buttonMarks[1] == buttonMarks[2] {
            return .winner
        } else if buttonMarks[3] != "" && buttonMarks[3] == buttonMarks[4] && buttonMarks[4] == buttonMarks[5] {
            return .winner
        } else if buttonMarks[6] != "" && buttonMarks[6] == buttonMarks[7] && buttonMarks[7] == buttonMarks[8] {
            return .winner
        } else if buttonMarks[0] != "" && buttonMarks[0] == buttonMarks[3] && buttonMarks[3] == buttonMarks[6] {
            return .winner
        } else if buttonMarks[1] != "" && buttonMarks[1] == buttonMarks[4] && buttonMarks[4] == buttonMarks[7] {
            return .winner
        } else if buttonMarks[2] != "" && buttonMarks[2] == buttonMarks[5] && buttonMarks[5] == buttonMarks[8] {
            return .winner
        } else if buttonMarks[0] != "" && buttonMarks[0] == buttonMarks[4] && buttonMarks[4] == buttonMarks[8] {
            return .winner
        } else if buttonMarks[2] != "" && buttonMarks[2] == buttonMarks[4] && buttonMarks[4] == buttonMarks[6] {
            return .winner
        }
        
        for mark in buttonMarks {
            if mark == "" {
                return .active
            }
        }
        
        return .tie
    }
    
    func resetGame() {
        buttonMarks = Array(repeating: "", count: 9)
        isXTurn = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
