//
//  SplashScreen.swift
//  SplashScreenAnimation
//
//  Created by Eduardo Martin Lorenzo on 20/6/22.
//

import SwiftUI

struct SplashScreen: View {
    @State var startAnimation = false
    @State var circleAnimation1 = false
    @State var circleAnimation2 = false
    @Binding var endAnimation: Bool
    
    var body: some View {
        ZStack {
            Color("MainColor")
            
            Group {
                SplashShape()
                    .trim(from: 0, to: startAnimation ? 1 : 0 )
                    .stroke(Color.white, style: StrokeStyle(lineWidth: 30, lineCap: .round, lineJoin: .round))
                
                Circle()
                    .fill(.white)
                    .frame(width: 35, height: 35)
                    .scaleEffect(circleAnimation1 ? 1 : 0)
                    .offset(x: -80, y: 22)
                
                Circle()
                    .fill(.white)
                    .frame(width: 35, height: 35)
                    .scaleEffect(circleAnimation2 ? 1 : 0)
                    .offset(x: 80, y: -22)
            }
            .frame(width: 220, height: 130)
            .scaleEffect(endAnimation ? 0.15 : 0.9)
            .rotationEffect(.init(degrees: endAnimation ? 85 : 0))
        }
        // Para mover la pantalla hacia arriba cuando se acabe la animacion
        .offset(y: endAnimation ? (-getRect().height * 1.5) : 0)
        .ignoresSafeArea()
        .onAppear {
            withAnimation(.spring().delay(0.15)) {
                circleAnimation1.toggle()
            }
            
            withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 1.05, blendDuration: 1.05).delay(0.3)) {
                startAnimation.toggle()
            }
            
            withAnimation(.spring().delay(0.7)) {
                circleAnimation2.toggle()
            }
            
            withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 1.05, blendDuration: 1.05).delay(1.2)) {
                endAnimation.toggle()
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
    
    func getSafeArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return .zero
        }
        
        return safeArea
    }
}

struct SplashShape: Shape {
    func path(in rect: CGRect) -> Path {
        return Path { path in
            let mid = rect.width / 2
            let height = rect.height
            
            path.move(to: CGPoint(x: mid - 80, y: height))
            
            path.addArc(center: CGPoint(x: mid - 40, y: height), radius: 40, startAngle: .init(degrees: 180), endAngle: .zero, clockwise: true)
            
            path.move(to: CGPoint(x: mid, y: height))
            path.addLine(to: CGPoint(x: mid, y: 0))
            
            path.addArc(center: CGPoint(x: mid + 40, y: height), radius: 40, startAngle: .init(degrees: -180), endAngle: .zero, clockwise: false)
        }
    }
}
