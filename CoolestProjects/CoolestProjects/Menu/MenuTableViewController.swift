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
    var previousIndexPath = NSIndexPath.init(forRow: 0, inSection: 0)
    
    var cellReuseIdentifier = "menuItemCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.itemTitles = ["Home", "Speakers", "Stages", "Sponsors", "Projects", "Maps", "About"]
        self.itemIdentifiers = ["homeController", "speakersNavViewController", "stagesNavViewController", "sponsorsNavViewController", "projectsNavViewController", "mapsNavViewController", "aboutNavViewController"]
        
        assert(self.itemIdentifiers.count == self.itemTitles.count, "You need to have the same number of titles as identifiers")
        
        self.setupView()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let title = self.itemTitles[indexPath.row]
        
        var cell =  tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier)
        
        if((cell == nil)) {
            cell = UITableViewCell(style: .Default, reuseIdentifier: cellReuseIdentifier)
        }
        cell?.backgroundColor = UIColor.clearColor()
        cell?.textLabel?.font = AppFonts.menuItemFont
        
        if self.previousIndexPath.row == indexPath.row {
            cell?.textLabel?.textColor = UIColor.yellowColor()
            cell?.textLabel?.font = AppFonts.menuItemSelectedFont
        }
        else {
            cell?.textLabel?.textColor = UIColor.whiteColor()
            cell?.textLabel?.font = AppFonts.menuItemFont
        }
        
        cell?.textLabel?.text = title
        cell?.selectionStyle = UITableViewCellSelectionStyle.None
        return cell!
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemTitles.count
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if self.previousIndexPath.row != indexPath.row {
            let identifier = self.itemIdentifiers[indexPath.row]
            
            self.setTextColorOnCell(AppFonts.menuItemSelectedFont, color: AppColors.yellowColor, indexPath: indexPath, tableView: tableView)
            self.setTextColorOnCell(AppFonts.menuItemFont, color: UIColor.whiteColor(), indexPath: self.previousIndexPath, tableView: tableView)
            
            self.previousIndexPath = indexPath
            
            self.revealViewController().setFrontViewController( self.storyboard?.instantiateViewControllerWithIdentifier(identifier), animated: true)
        }
        
        self.revealViewController().revealToggle(nil)
        
    }
    
    func setTextColorOnCell(font: UIFont, color: UIColor, indexPath: NSIndexPath, tableView: UITableView) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.textLabel?.font = font
        cell?.textLabel?.textColor = color
    }
    
    func setupView() {
        self.tableView.backgroundColor = UIColor.blackColor()
        self.tableView.separatorStyle = .None
    }
}