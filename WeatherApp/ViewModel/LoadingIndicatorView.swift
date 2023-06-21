//
//  LoadingIndicatorView.swift
//  WeatherApp
//
//  Created by Mert ATK on 21.06.2023.
//

import SwiftUI

struct LoadingIndicatorView: View {
    @State private var isAnimating = false
    
    var body: some View {
        Circle()
            .trim(from: 0, to: 0.8) // Dönen dairenin kesitini belirleyin
            .stroke(Color.blue, lineWidth: 4) // Dönen daire için kenarlık ve rengi belirleyin
            .frame(width: 40, height: 40) // Dönen dairenin boyutunu ayarlayın
            .rotationEffect(.degrees(isAnimating ? 360 : 0)) // Animasyonu döndürmek için rotationEffect kullanın
            .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) // Animasyonun süresini ve döngüsünü belirleyin
            .onAppear {
                isAnimating = true // Animasyonun başlaması için onAppear kullanın
            }
            .onDisappear {
                isAnimating = false // Animasyonun durması için onDisappear kullanın
            }
    }
}
struct LoadingIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingIndicatorView()
    }
}
