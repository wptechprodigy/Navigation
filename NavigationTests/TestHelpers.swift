//
//  TestHelpers.swift
//  NavigationTests
//
//  Created by waheedCodes on 07/11/2021.
//

import UIKit

/// Button tap helper
///
/// - Parameter button: button under examnation
func tap(_ button: UIButton) {
    button.sendActions(for: .touchUpInside)
}

/// Handles mouse and keyboard input events
func executeRunLoop() {
    RunLoop.current.run(until: Date())
}

/// Put `ViewController` in window object for testing
/// Suitable for testing Segue based VCs
///
/// - Parameter vc: VC under test
func putInWindow(_ vc: UIViewController) {
    let window = UIWindow()
    window.rootViewController = vc
    window.isHidden = false
}
