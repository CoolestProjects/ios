//
//  HallsDataSources.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 27/05/2017.
//  Copyright © 2017 coderdojo. All rights reserved.
//

import Foundation
import UIKit

//TODO: this could be generic
class PanelsTableViewDataSource: NSObject, UITableViewDataSource {

    var panels = [Panel]()

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return panels.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = panels[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "panel", for: indexPath) as! PanelTableViewCell
        cell.configure(with: item)
        return cell
    }

}

class WorkshopTableViewDataSource: NSObject, UITableViewDataSource {

    var workshops = [Workshop]()

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workshops.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = workshops[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "workshop", for: indexPath) as! WorkshopTableViewCell
        cell.configure(with: item)
        return cell
    }
    
}
