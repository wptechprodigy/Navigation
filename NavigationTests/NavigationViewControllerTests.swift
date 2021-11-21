//
//  NavigationViewControllerTests.swift
//  NavigationTests
//
//  Created by waheedCodes on 07/11/2021.
//

import ViewControllerPresentationSpy
import XCTest
@testable import Navigation

class NavigationViewControllerTests: XCTestCase {
    
    private var sut: NavigationViewController!
    
    override func setUp() {
        super.setUp()
        sut = makeSUT()
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        executeRunLoop()
        sut = nil
        super.tearDown()
    }
    
    func test_codePushButton_shouldBeConnected() {
        XCTAssertNotNil(sut.codePushButton, "button")
    }
    
    func test_codeModalButton_shouldBeConnected() {
        XCTAssertNotNil(sut.codeModalButton, "button")
    }
    
    func test_seguePushButton_shouldBeConnected() {
        XCTAssertNotNil(sut.seguePushButton, "button")
    }
    
    func test_segueModalButton_shouldBeConnected() {
        XCTAssertNotNil(sut.segueModalButton, "button")
    }
    
    func test_tappingCodePushButton_shouldPushCodeNextViewController() {
        let navigation = UINavigationController(rootViewController: sut)
        
        tap(sut.codePushButton)
        
        executeRunLoop()
        XCTAssertEqual(navigation.viewControllers.count, 2, "navigation stack")
        
        let pushedViewController = navigation.viewControllers.last
        guard let codeNextViewController = pushedViewController
                as? CodeNextViewController else {
            XCTFail("Expected CodeNextViewController, "
                        + "but was \(String(describing: pushedViewController))")
            return
        }
        XCTAssertEqual(codeNextViewController.label.text, "Pushed from code")
    }
    
//    func test_INCORRECT_tappingCodeModalButton_shouldPushCodeNextViewController() {
//        UIApplication.shared.windows.first?.rootViewController = sut
//
//        tap(sut.codeModalButton)
//
//        let presentedViewController = sut.presentedViewController
//        guard let codeNextViewController = presentedViewController
//                as? CodeNextViewController else {
//            XCTFail("Expected CodeNextViewController, "
//                        + "but was \(String(describing: presentedViewController))")
//            return
//        }
//        XCTAssertEqual(codeNextViewController.label.text, "Modal from code")
//    }
    
    func test_tappingCodeModalButton_shouldPushCodeNextViewController() {
        let presentationVerifier = PresentationVerifier()
        tap(sut.codeModalButton)

        let codeNextViewController: CodeNextViewController? = presentationVerifier.verify(animated: true, presentingViewController: sut)

        XCTAssertEqual(codeNextViewController?.label.text, "Modal from code")
    }
    
    func test_tappingSeguePushButton_shouldPushSegueNextViewController() {
        let presentationVerifier = PresentationVerifier()
        putInWindow(sut)
        tap(sut.seguePushButton)
        
        let segueNextViewController: SegueNextViewController?
            = presentationVerifier
            .verify(animated: true, presentingViewController: sut)
        
        XCTAssertEqual(segueNextViewController?.label.text, "Pushed from segue")
    }
    
    func test_tappingSegueModalButton_shouldPushSegueNextViewController() {
        let presentationVerifier = PresentationVerifier()
        tap(sut.segueModalButton)

        let segueNextViewController: SegueNextViewController? = presentationVerifier.verify(animated: true, presentingViewController: sut)

        XCTAssertEqual(segueNextViewController?.label.text, "Modal from segue")
    }
    
    // MARK: - Helper Methods
    
    private func makeSUT() -> NavigationViewController {
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: nil)
        let sut: NavigationViewController = storyboard.instantiateViewController(identifier: String(describing: NavigationViewController.self))
        
        return sut
    }
    
    private class SpyNavigationController: UINavigationController {
        private(set) var pushViewControllerArgsAnimated: [Bool] = []
        
        override func show(
            _ vc: UIViewController, sender: Any?) {
            
        }
        
        override func pushViewController(
            _ viewController: UIViewController, animated: Bool) {
            super.pushViewController(viewController, animated: animated)
            pushViewControllerArgsAnimated.append(animated)
        }
    }
    
    /// Test Spy: Captures method arguments without doing actual work
    /// The idea is that tests can instantiate `TestNavigationViewController`
    /// instead of the `NavigationViewController`itself.
    /// This works for `ViewControllers` that are `code-based` or `XIB-based`.
    private class TestNavigationViewController: UIViewController {
        var presentCallCount = 0
        var presentArgsViewController: [UIViewController] = []
        var presentArgsAnimated: [Bool] = []
        var presentArgsClosure: [(() -> Void)?] = []
        
        override func present(
            _ viewControllerToPresent: UIViewController,
            animated flag: Bool,
            completion: (() -> Void)? = nil
        ) {
            presentCallCount += 1
            presentArgsViewController.append(viewControllerToPresent)
            presentArgsAnimated.append(flag)
            presentArgsClosure.append(completion)
        }
    }
}
