//
//  AppDelegate.swift
//  justBankey
//
//  Created by  Mr.Ki on 07.03.2022.
//

import UIKit

let appColor: UIColor = .systemTeal

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    
    let loginViewController = LoginViewController()
    let onboardingContainerViewController = OnboardingContainerViewController()
//    let dummyViewController = DummyViewController()
    let mainViewController = MainViewController()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        loginViewController.delegate = self
        onboardingContainerViewController.delegate = self
        
        registerForNotifications()
        
        displayLogin()
        
        
//        let vc = mainViewController
//        vc.setStatusBar()
//
//        UINavigationBar.appearance().isTranslucent = false
//        UINavigationBar.appearance().backgroundColor = appColor
//
//        window?.rootViewController = vc
      //  dummyViewController.logoutDelegate = self
        
      //  window?.rootViewController = mainViewController
        
  //      window?.rootViewController = AccountSummaryViewController()
        
     //   window?.rootViewController = LoginViewController()
    //    window?.rootViewController = onboardingContainerViewController
 //   window?.rootViewController = OnboardingContainerViewController()
//        window?.rootViewController = OnboardingViewController(heroImageName: "delorean", titleText: "JustBankey is faster, easier to use, and has a brand new look and feel that will make you feel like you are back in 1989")
      //  mainViewController.selectedIndex = 1
        
        return true
    }
    
    private func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(didLogout), name: .logout, object: nil)
    }
    
    private func displayLogin() {
        setRootViewController(loginViewController)
    }
    
    private func displayNextScreen() {
        if LocalState.hasOnboarded {
            prepMainView()
            setRootViewController(mainViewController)
        } else {
            setRootViewController(onboardingContainerViewController)
        }
    }
    
    private func prepMainView() {
        mainViewController.setStatusBar()
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backgroundColor = appColor
    }
    
}

extension AppDelegate {
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: 0.4, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}

extension AppDelegate: LoginViewControllerDelegate {
    func didLogin() {
        displayNextScreen()
    //    window?.rootViewController = onboardingContainerViewController
//        if LocalState.hasOnboarded {
//            setRootViewController(mainViewController)
//        } else {
//            setRootViewController(onboardingContainerViewController)
//        }
       
    }
    
    
}
extension AppDelegate: OnboardinContainerViewControllerDelegate {
    func didFinishOnboarding() {
        LocalState.hasOnboarded = true
        prepMainView()
        setRootViewController(mainViewController)
        print("Onboarding done!")
    }
}

extension AppDelegate: LogoutDelegate {
   @objc func didLogout() {
            setRootViewController(loginViewController)
    }
}


