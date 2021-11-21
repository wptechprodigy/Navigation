//
//  SegueNextViewController.swift
//  Navigation
//
//  Created by waheedCodes on 07/11/2021.
//

import UIKit

class SegueNextViewController: UIViewController {
    
    // MARK: - Properties
    
    var labelText: String?
    
    // MARK: - Outlets
    
    @IBOutlet private(set) var label: UILabel!

    // MARK: - Object Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = labelText
    }
    
    deinit {
        print(">> SegueNextViewController.deinit")
    }
}
