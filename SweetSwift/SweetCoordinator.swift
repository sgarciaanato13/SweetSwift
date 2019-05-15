//
//  SweetCoordinator.swift
//  SweetSwift
//
//  Created by Samuel on 4/27/19.
//  Copyright © 2019 SGarciaAnato. All rights reserved.
//

import UIKit

class SweetCoordinator {
    
    var parentCoordinator : SweetCoordinator?
    var childCoordinators = [SweetCoordinator]()
    var currentViewController : SweetViewController!
    var identifier: String!
    
    var viewControllers = [String : SweetViewController]()
    
    init(identifier: String){
        self.identifier = identifier
        self.reloadMainViewController()
    }
    
    func start(){
        
    }
    
    func reloadMainViewController(){
        let sweetViewController = MainViewController("" , coordinator: self)
        currentViewController = sweetViewController
        sweetViewController.view.backgroundColor = UIColor.cyan
        viewControllers[sweetViewController.identifier] = sweetViewController
    }
    
}

enum TransitionType {
    case present
    case push
}

protocol SweetCoordinatorProtocol {
    func childsCoordinatosNames() -> [String]
    func viewControllersNames() -> [String]
    func viewControllerForName(_ name: String, exclude: [String]) -> SweetViewController?
    func coordinatorForName(_ name: String, exclude: [String]) -> SweetCoordinator?
    func transition(transitionType: TransitionType, identifier: String, animated : Bool)
    func setCurrentViewController(_ sweetViewController: SweetViewController)
}

extension SweetCoordinator : SweetCoordinatorProtocol {
    func viewControllerForName(_ name: String, exclude: [String] = []) -> SweetViewController? {
        if let namedViewController = viewControllers[name]{
            return namedViewController
        }
        for coord in childCoordinators{
            var dentro = false
            for exclud in exclude{
                if coord.identifier == exclud {
                    dentro = true
                }
            }
            if !dentro{
                var exclud = exclude
                exclud.append(self.identifier)
                if let namedViewController = coord.viewControllerForName(name, exclude: exclud){
                    return namedViewController
                }
            }
        }
        var exclud = exclude
        exclud.append(self.identifier)
        if let namedViewController = parentCoordinator?.viewControllerForName(name, exclude: exclud){
            return namedViewController
        }
        return nil
    }
    func coordinatorForName(_ name: String, exclude: [String] = []) -> SweetCoordinator? {
        for coordinator in self.childCoordinators{
            if coordinator.identifier == name{
                return coordinator
            }
            var exclud = exclude
            exclud.append(self.identifier)
            if let childCoord = coordinator.coordinatorForName(name, exclude: exclud){
                return childCoord
            }
        }
        return nil
    }
    func viewControllersNames() -> [String]{
        var names = [String]()
        for child in childCoordinators {
            names.append(contentsOf: child.viewControllersNames())
        }
        for item in viewControllers{
            if item.key != ""{
                names.append(item.key)
            }
        }
        
        return names.sorted()
    }
    func childsCoordinatosNames() -> [String]{
        var names = [String]()
        for coordinator in childCoordinators{
            names.append(contentsOf: coordinator.childsCoordinatosNames())
            names.append(coordinator.identifier)
        }
        
        return names.sorted()
    }
    func transition(transitionType: TransitionType, identifier: String, animated : Bool){
        if let coordinator = self.coordinatorForName(identifier){
            if coordinator.currentViewController.identifier == ""{
                coordinator.reloadMainViewController()
            }
            self.currentViewController.navigationController?.pushViewController(
                coordinator.currentViewController, animated: animated)
        }else{
            if let viewController = self.viewControllerForName(identifier){
                self.currentViewController.navigationController?.pushViewController(
                    viewController, animated: animated)
            }
        }
    }
    func setCurrentViewController(_ sweetViewController: SweetViewController){
        for controller in self.viewControllers{
            if controller.key == sweetViewController.identifier, self.currentViewController.identifier != sweetViewController.identifier{
                self.currentViewController = sweetViewController
                return
            }
        }
        self.parentCoordinator?.setCurrentViewController(sweetViewController)
    }
    
}
