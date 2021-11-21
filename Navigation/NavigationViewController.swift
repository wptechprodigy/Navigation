//
//  NavigationViewController.swift
//  Navigation
//
//  Created by waheedCodes on 07/11/2021.
//

import UIKit

class NavigationViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private(set) var codePushButton: UIButton!
    @IBOutlet private(set) var codeModalButton: UIButton!
    @IBOutlet private(set) var seguePushButton: UIButton!
    @IBOutlet private(set) var segueModalButton: UIButton!
    
    // MARK: - Object Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    
    @IBAction private func pushNextViewController() {
        let nextViewController = CodeNextViewController(labelText: "Pushed from code")
//        self.navigationController?
//            .pushViewController(nextViewController,
//                                animated: true)
        show(nextViewController, sender: self)
    }
    
    @IBAction private func presentModalNextViewController() {
        let nextViewController = CodeNextViewController(labelText: "Modal from code")
        present(nextViewController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "pushNext"?:
            guard let nextViewController = segue.destination
                    as? SegueNextViewController
            else { return }
            nextViewController.labelText = "Pushed from segue"
        case "modalNext"?:
            guard let nextViewController = segue.destination
                    as? SegueNextViewController
            else { return }
            nextViewController.labelText = "Modal from segue"
        default:
            return
        }
    }
    
    deinit {
        print(">> NavigationViewController.deinit")
    }
}
