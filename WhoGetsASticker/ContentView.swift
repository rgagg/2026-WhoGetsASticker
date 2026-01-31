//
//  ContentView.swift
//  WhoGetsASticker
//
//  Created by Richard Gagg on 31/1/2026.
//

import SwiftUI

struct ContentView: View {
  
  @State private var winningMessage: String = ""
  @State private var name: String = ""
  @State private var studentNames: String = "No Posters This Week"
  @State private var posters: [String] = []
  @FocusState private var isFocused: Bool
  
  var body: some View {
    VStack {
      
      Text("Who Gets a Sticker?")
        .font(.largeTitle)
        .fontWeight(.black)
      
      HStack {
        Button {
          posters.removeAll()
          name = ""
          winningMessage = ""
          isFocused = false
        } label: {
          Text("Clear")
        }
        .tint(.red.opacity(0.8))
        
        Spacer()
        
        Button {
          winningMessage = "This Weeks Winner is:\n\(posters[Int.random(in: 0..<posters.count)])"
          isFocused = false
          name = ""
        } label: {
          Text("Pick a Winner")
        }
        .tint(.green.opacity(0.8))
        
      }
      .font(.title2)
      .fontWeight(.bold)
      .buttonStyle(.glassProminent)
      .disabled(posters.isEmpty)
      
      Image("sticker")
        .resizable()
        .scaledToFit()
      
      Text(winningMessage)
        .font(.largeTitle)
        .multilineTextAlignment(.center)
      
      Spacer()
      
      Text("This Weeks Posters Are:")
        .font(.largeTitle)
        .fontWeight(.black)
        .multilineTextAlignment(.center)
      
      Text(posters.isEmpty ? "No Posters This Week" : posters.joined(separator: ", "))
        .font(.largeTitle)
        .multilineTextAlignment(.center)
      
      HStack {
        TextField("Enter Name.", text: $name)
          .autocorrectionDisabled()
          .font(.title2)
          .padding(.horizontal, 10)
          .textFieldStyle(.roundedBorder)
          .focused($isFocused)
          .overlay {
            RoundedRectangle(cornerRadius: 5)
              .stroke(.gray, lineWidth: 1)
          }
          .onSubmit {
            appendName()
          }
        
        Button {
          appendName()
        } label: {
          Image(systemName: "plus")
            .font(.title)
            .fontWeight(.bold)
        }
        
      }
      
    }
    .padding()
  }
  
  //MARK: Functions
  func appendName() {
    if name != "" {
      posters.append(name)
      name = ""
      isFocused = false
    }
  }
}

#Preview("Light Mode") {
  ContentView()
    .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
  ContentView()
    .preferredColorScheme(.dark)
}
