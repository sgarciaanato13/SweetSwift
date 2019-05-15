//
//  AppDelegate.swift
//  SweetSwift
//
//  Created by Samuel Garcia Anato on 4/29/19.
//  Copyright © 2019 Samuel Garcia Anato. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let coordinator = SweetCoordinator(identifier: "Main")
    let firstCoordinator = SweetCoordinator(identifier: "First Coordinator")
    let secondCoordinator = SweetCoordinator(identifier: "Second Coordinator")
    let thirdCoordinator = SweetCoordinator(identifier: "Third Coordinator")
    let fourthCoordinator = SweetCoordinator(identifier: "Fourth Coordinator")
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: coordinator.viewControllers[""] ?? UIViewController())
        self.setDefaultViewControllers()
        window?.makeKeyAndVisible()
        return true
    }
    
    func setDefaultViewControllers(){
        let firstViewController = SweetViewController("First View Controller", coordinator : coordinator)
        coordinator.viewControllers[firstViewController.identifier] = firstViewController
        let secondViewController = SweetViewController("Second View Controller", coordinator : coordinator)
        coordinator.viewControllers[secondViewController.identifier] = secondViewController
        let thirdViewController = SweetViewController("Third View Controller", coordinator : coordinator)
        coordinator.viewControllers[thirdViewController.identifier] = thirdViewController
        self.createFirstCoordinator()
        self.createSecondCoordinator()
        self.createThirdCoordinator()
        self.createFourthCoordinator()
    }
    
    func createFirstCoordinator(){
        let fourthViewController = SweetViewController("Fourth View Controller", coordinator : coordinator)
        firstCoordinator.viewControllers[fourthViewController.identifier] = fourthViewController
        let fifthViewController = SweetViewController("Fifth View Controller", coordinator : coordinator)
        firstCoordinator.viewControllers[fifthViewController.identifier] = fifthViewController
        firstCoordinator.parentCoordinator = coordinator
        coordinator.childCoordinators.append(firstCoordinator)
    }
    
    func createSecondCoordinator(){
        let sixthViewController = SweetViewController("Sixth View Controller", coordinator : coordinator)
        secondCoordinator.viewControllers[sixthViewController.identifier] = sixthViewController
        let seventhViewController = SweetViewController("Seventh View Controller", coordinator : coordinator)
        secondCoordinator.viewControllers[seventhViewController.identifier] = seventhViewController
        secondCoordinator.parentCoordinator = coordinator
        coordinator.childCoordinators.append(secondCoordinator)
    }
    
    func createThirdCoordinator(){
        let eigthViewController = SweetViewController("Eight View Controller", coordinator : coordinator)
        thirdCoordinator.viewControllers[eigthViewController.identifier] = eigthViewController
        let ninethViewController = SweetViewController("Nineth View Controller", coordinator : coordinator)
        thirdCoordinator.viewControllers[ninethViewController.identifier] = ninethViewController
        let tenthViewController = SweetViewController("Tenth View Controller", coordinator : coordinator)
        thirdCoordinator.viewControllers[tenthViewController.identifier] = tenthViewController
        thirdCoordinator.parentCoordinator = coordinator
        coordinator.childCoordinators.append(thirdCoordinator)
        
    }
    
    func createFourthCoordinator(){
        let eleventhViewController = SweetViewController("Eleventh View Controller", coordinator : coordinator)
        fourthCoordinator.viewControllers[eleventhViewController.identifier] = eleventhViewController
        let twelfthViewController = SweetViewController("Twelfth View Controller", coordinator : coordinator)
        fourthCoordinator.viewControllers[twelfthViewController.identifier] = twelfthViewController
        fourthCoordinator.parentCoordinator = thirdCoordinator
        thirdCoordinator.childCoordinators.append(fourthCoordinator)
        
    }
    
    
}
