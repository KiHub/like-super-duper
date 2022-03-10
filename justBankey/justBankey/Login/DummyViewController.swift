//
//  DummyViewController.swift
//  justBankey
//
//  Created by  Mr.Ki on 10.03.2022.
//

import UIKit

class DummyViewController: UIViewController {
    
    let stackView = UIStackView()
    let label = UILabel()
    let logoButton = UIButton(type: .system)
    
    weak var logoutDelegate: LogoutDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension DummyViewController {
    func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        
        logoButton.translatesAutoresizingMaskIntoConstraints = false
        logoButton.configuration = .filled()
        logoButton.setTitle("Logout", for: [])
        logoButton.addTarget(self, action: #selector(logoutButtonTapped), for: .primaryActionTriggered)
    }
    func layout() {
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(logoButton)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func logoutButtonTapped(sender: UIButton) {
        logoutDelegate?.didLogout()
    }
    
}
