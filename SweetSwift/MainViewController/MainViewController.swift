//
//  MainViewController.swift
//  SweetSwift
//
//  Created by Samuel Garcia Anato on 4/29/19.
//  Copyright © 2019 Samuel Garcia Anato. All rights reserved.
//

import UIKit

class MainViewController: SweetViewController {

    var tableView : UITableView!
    var coordinatorsNames = [String]()
    var viewControllersNames = [String]()
    
    override init(_ identifier : String,coordinator : SweetCoordinator) {
        super.init(identifier, coordinator : coordinator)
        tableView = UITableView(frame: UIScreen.main.bounds)
        tableView.backgroundColor = UIColor.clear
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        coordinatorsNames = coordinator.childsCoordinatosNames()
        viewControllersNames = coordinator.viewControllersNames()
        tableView.reloadData()
    }
    
}

extension MainViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.coordinatorsNames.count + self.viewControllersNames.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < self.coordinatorsNames.count{
            self.coordinator.transition(transitionType: .push, identifier: self.coordinatorsNames[indexPath.row], animated : true)
        }else{
            self.coordinator.transition(transitionType: .push, identifier: self.viewControllersNames[indexPath.row - self.coordinatorsNames.count], animated : true)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.clear
        if indexPath.row < self.coordinatorsNames.count{
            cell.backgroundColor = UIColor.yellow
            cell.textLabel?.text = "\(self.coordinatorsNames[indexPath.row]) ->"
        }else{
            cell.textLabel?.text = self.viewControllersNames[indexPath.row - self.coordinatorsNames.count]
        }
        return cell
    }
    
}
