//
//  MenuTableViewController.swift
//  CoolestProjects
//
//  Created by Rich on 06/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import Foundation
import UIKit
import SWRevealViewController

class MenuTableViewController: UITableViewController {
    var itemTitles = [String]()
    var itemIdentifiers = [String]()
    var previousIndexPath = IndexPath.init(row: 0, section: 0)
    
    var cellReuseIdentifier = "menuItemCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       self.itemTitles = ["Home", "Speakers", "Stages", "Sponsors", "Projects", "Maps", "About", "Creators"]
        self.itemIdentifiers = ["homeController", "speakersNavViewController", "stagesNavViewController", "sponsorsNavViewController", "projectsNavViewController", "mapsNavViewController", "aboutNavViewController", "CreatorViewController"]
        
        assert(self.itemIdentifiers.count == self.itemTitles.count, "You need to have the same number of titles as identifiers")
        
        self.setupView()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let title = self.itemTitles[indexPath.row]
        
        var cell =  tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)
        
        if((cell == nil)) {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellReuseIdentifier)
        }
        cell?.backgroundColor = UIColor.clear
        cell?.textLabel?.font = AppFonts.menuItemFont
        
        if self.previousIndexPath.row == indexPath.row {
            cell?.textLabel?.textColor = UIColor.yellow
            cell?.textLabel?.font = AppFonts.menuItemSelectedFont
        }
        else {
            cell?.textLabel?.textColor = UIColor.white
            cell?.textLabel?.font = AppFonts.menuItemFont
        }
        
        cell?.textLabel?.text = title
        cell?.selectionStyle = UITableViewCellSelectionStyle.none
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemTitles.count
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.previousIndexPath.row != indexPath.row {
            let identifier = self.itemIdentifiers[indexPath.row]
            
            self.setTextColorOnCell(AppFonts.menuItemSelectedFont, color: AppColors.yellowColor, indexPath: indexPath, tableView: tableView)
            self.setTextColorOnCell(AppFonts.menuItemFont, color: UIColor.white, indexPath: self.previousIndexPath, tableView: tableView)
            
            self.previousIndexPath = indexPath
            
            self.revealViewController().setFront( self.storyboard?.instantiateViewController(withIdentifier: identifier), animated: true)
        }
        
        self.revealViewController().revealToggle(nil)
        
    }
    
    func setTextColorOnCell(_ font: UIFont, color: UIColor, indexPath: IndexPath, tableView: UITableView) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.textLabel?.font = font
        cell?.textLabel?.textColor = color
    }
    
    func setupView() {
        self.tableView.backgroundColor = UIColor.black
        self.tableView.separatorStyle = .none
    }
}
