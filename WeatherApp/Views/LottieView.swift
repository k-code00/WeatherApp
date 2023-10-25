//
//  LottieView.swift
//  WeatherApp
//
//  Created by Kojo on 25/10/2023.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    // The name of the Lottie animation file (without the .json extension).
    var name: String
    
    // The loop mode for the Lottie animation.
    var loopMode: LottieLoopMode = .loop
    
    // UIView to display the Lottie animation.
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> some UIView {
        let view = UIView()
        return view
    }
    
    // UIView with the Lottie animation.
    func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<LottieView>) {
        uiView.subviews.forEach({ $0.removeFromSuperview()})
        
        // Initialize the Lottie view.
        let animationView = LottieAnimationView()
        
        // Allow for AutoLayout constraints.
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the Lottie view as a subview.
        uiView.addSubview(animationView)
        
        // Set constraints to make the animation view fill its parent.
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: uiView.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: uiView.heightAnchor)
        ])
        
        // Set the animation to the Lottie view.
        animationView.animation = LottieAnimation.named(name)
        
        // Adjust the content mode for the animation.
        animationView.contentMode = .scaleAspectFit
        
        // Set the loop mode for the animation.
        animationView.loopMode = loopMode
        
        // Start playing the animation.
        animationView.play()
    }
}

