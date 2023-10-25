//
//  LottieViewTests.swift
//  WeatherAppTests
//
//  Created by Consultant on 25/10/2023.
//

import XCTest
@testable import WeatherApp
import Lottie
import SwiftUI

class LottieViewTests: XCTestCase {
    
    // The LottieView instance that will be tested
    var lottieView: WeatherApp.LottieView!
    
    override func setUp() {
        super.setUp()
        // Initialize the LottieView with a sample animation name
        lottieView = LottieView(name: "sampleAnimation")
    }

    // Teardown method called after each test completes
    override func tearDown() {
        // Deallocate the LottieView to free up resources
        lottieView = nil
        super.tearDown()
    }

    // Test to ensure the LottieView is properly instantiated
    func testLottieViewInstantiation() {
        XCTAssertNotNil(lottieView)
    }
    
    // Test to verify if the animation is successfully loaded into the LottieView
    func testAnimationLoading() {
        let hostingController = UIHostingController(rootView: lottieView)
        // Find the LottieAnimationView from the subviews
        let lottieAnimationView = hostingController.view.subviews.first { $0 is LottieAnimationView } as? LottieAnimationView
        
        // Assert that the animation is not nil (i.e., it's loaded)
        XCTAssertNotNil(lottieAnimationView?.animation)
        // Uncommented as the filename property does not exist
        // XCTAssertEqual(lottieAnimationView?.animation?.filename, "sampleAnimation")
    }
    
    // Test to check the default and custom loop modes of the LottieView
    func testLoopMode() {
        // Assert that the default loop mode is .loop
        XCTAssertEqual(lottieView.loopMode, .loop)
        
        // Change the loop mode and re-instantiate the LottieView
        lottieView.loopMode = .playOnce
        let hostingController = UIHostingController(rootView: lottieView)
        let lottieAnimationView = hostingController.view.subviews.first { $0 is LottieAnimationView } as? LottieAnimationView
        
        // Assert that the changed loop mode is .playOnce
        XCTAssertEqual(lottieAnimationView?.loopMode, .playOnce)
    }
    
    // Test to check that the LottieAnimationView has width and height constraints
    func testConstraints() {
        let hostingController = UIHostingController(rootView: lottieView)
        let lottieAnimationView = hostingController.view.subviews.first { $0 is LottieAnimationView } as? LottieAnimationView
        
        // Get all constraints of the LottieAnimationView
        let constraints = lottieAnimationView?.constraints
        // Check that there's a width constraint
        XCTAssertTrue(constraints?.contains(where: { $0.firstAttribute == .width }) ?? false)
        // Check that there's a height constraint
        XCTAssertTrue(constraints?.contains(where: { $0.firstAttribute == .height }) ?? false)
    }
}
