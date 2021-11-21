//
//  CodeNextViewController.swift
//  Navigation
//
//  Created by waheedCodes on 07/11/2021.
//

import UIKit

class CodeNextViewController: UIViewController {
    
    let label = UILabel()
    
    init(labelText: String) {
        label.text = labelText
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        activateEqualContraints(.centerX, fromItem: label, toItem: view)
        activateEqualContraints(.centerY, fromItem: label, toItem: view)
    }
    
    private func activateEqualContraints(_ attribute: NSLayoutConstraint.Attribute,
                                         fromItem: UIView,
                                         toItem: UIView) {
        NSLayoutConstraint(
            item: fromItem,
            attribute: attribute,
            relatedBy: .equal,
            toItem: toItem,
            attribute: attribute,
            multiplier: 1,
            constant: 0
        ).isActive = true
    }
    
    deinit {
        print(">> CodeNextViewController.deinit")
    }
}
