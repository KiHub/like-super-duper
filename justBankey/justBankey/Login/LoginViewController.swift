//
//  ViewController.swift
//  justBankey
//
//  Created by  Mr.Ki on 07.03.2022.
//

import UIKit

protocol LogoutDelegate: AnyObject {
    func didLogout()
}

protocol LoginViewControllerDelegate: AnyObject {
  //   func didLogin(_ sender: LoginViewController) // pass data
    func didLogin()
}

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    let signButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    
    
    weak var delegate: LoginViewControllerDelegate?
    
    var username: String? {
        return loginView.userNameTextField.text
    }
    var password: String? {
        return loginView.passwordTextField.text
    }
    
    //MARK: - Animation section
    var leadingEdgeOnScreen: CGFloat = 16
    var leadingEdgeOffScreen: CGFloat = -1000
    
    var titleLeadingAnchor: NSLayoutConstraint?
    var subtitleLeadingAnchor: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        signButton.configuration?.showsActivityIndicator = false
        loginView.userNameTextField.text = ""
        loginView.passwordTextField.text = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animate()
    }


}

extension LoginViewController {
    
    private func style() {
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        signButton.translatesAutoresizingMaskIntoConstraints = false
        signButton.configuration = .filled()
        signButton.configuration?.imagePadding = 8
        signButton.setTitle("Sign In", for: [])
        signButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.numberOfLines = 0
     //   errorMessageLabel.text = "Error failure"
        errorMessageLabel.isHidden = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "justBankey"
        titleLabel.font = .boldSystemFont(ofSize: 30)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.alpha = 0
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.text = "Your premium bankey"
        subtitleLabel.font = .systemFont(ofSize: 15, weight: .light)
        subtitleLabel.textColor = .black
        subtitleLabel.textAlignment = .center
        subtitleLabel.alpha = 0
        
        
    }
    
    private  func layout() {
       
        view.addSubview(loginView)
        view.addSubview(signButton)
        view.addSubview(errorMessageLabel)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([

            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 2),
            
            signButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            signButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: signButton.trailingAnchor, multiplier: 2),
            
            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signButton.bottomAnchor, multiplier:  2),
            errorMessageLabel.leadingAnchor.constraint(equalTo: signButton.leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: signButton.trailingAnchor),
            
          //  titleLabel.topAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: view.topAnchor, multiplier: 30),

    //       titleLabel.bottomAnchor.constraint(equalToSystemSpacingBelow: loginView.topAnchor, multiplier: -7),
        //    logoLabel.bottomAnchor.constraint(equalToSystemSpacingBelow: <#T##NSLayoutYAxisAnchor#>, multiplier: <#T##CGFloat#>)
           // logoLabel.bottomAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: loginView.topAnchor, multiplier: -80),
         //   titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            subtitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 3),
        //    titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
            
            loginView.topAnchor.constraint(equalToSystemSpacingBelow: subtitleLabel.bottomAnchor, multiplier: 3),
          //  subtitleLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
            
        ])
        titleLeadingAnchor = titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
        subtitleLeadingAnchor = subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
        titleLeadingAnchor?.isActive = true
        subtitleLeadingAnchor?.isActive = true
    }
}

extension LoginViewController {
    @objc func signInTapped(sender: UIButton) {
        errorMessageLabel.isHidden = true
        login()
        
    }
    
    private func login() {
        guard let username = username, let password = password else {
            assertionFailure("Username / password should never be nil")
            return
        }
        
        if username.isEmpty || password.isEmpty {
            configureView(withMessage: "Username / password can't be blank")
            return
        }
        
        if username == " " && password == " " {
            signButton.configuration?.showsActivityIndicator = true
            delegate?.didLogin()
        } else {
            configureView(withMessage: "Incorrect username or password")
        }
    }
    
    private func configureView(withMessage message: String) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
    }
}

extension LoginViewController {
    private func animate() {
        let duration = 1.0
        
        let animator1 = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            self.titleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        animator1.startAnimation()
        
        let animator2 = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            self.subtitleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        animator2.startAnimation(afterDelay: 0.3)
        
        let animator3 = UIViewPropertyAnimator(duration: duration*3, curve: .easeInOut) {
            self.subtitleLabel.alpha = 1
            self.titleLabel.alpha = 1
            self.view.layoutIfNeeded()
        }
        animator3.startAnimation(afterDelay: 0.3)
    }
}
