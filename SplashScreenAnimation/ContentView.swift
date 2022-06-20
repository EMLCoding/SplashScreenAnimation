//
//  ContentView.swift
//  SplashScreenAnimation
//
//  Created by Eduardo Martin Lorenzo on 20/6/22.
//

import SwiftUI

struct ContentView: View {
    @State var endAnimation = false
    var body: some View {
        ZStack {
            HomeView()
            
            SplashScreen(endAnimation: $endAnimation)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
