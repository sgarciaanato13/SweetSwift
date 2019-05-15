//
//  SweetViewController.swift
//  SweetSwift
//
//  Created by Samuel on 4/28/19.
//  Copyright © 2019 SGarciaAnato. All rights reserved.
//

import UIKit

class SweetViewController: UIViewController {
    
    var coordinator : SweetCoordinatorProtocol!
    var identifier: String!
    
    init(_ identifier: String,coordinator: SweetCoordinator) {
        super.init(nibName: nil, bundle: nil)
        self.identifier = identifier
        self.coordinator = coordinator
        self.view.backgroundColor = UIColor.green
        let label = UILabel(frame: UIScreen.main.bounds)
        label.text = identifier
        self.view.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if self.isMovingFromParent{
            coordinator.setCurrentViewController(self.parent?.children.last as! SweetViewController)
        }
    }
    
}
