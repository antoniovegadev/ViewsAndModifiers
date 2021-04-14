//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Antonio Vega on 4/13/21.
//

import SwiftUI

struct largeBlueTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func largeBlueTitleStyle() -> some View {
        self.modifier(largeBlueTitle())
    }
}

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .largeBlueTitleStyle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
