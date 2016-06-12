//
//  ProjectsFilterOptionsViewController.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 06/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import Foundation
import UIKit

class ProjectsFilterOptionsViewController : UITableViewController {
    
    @IBOutlet weak var applyButton: UIBarButtonItem!
    
    var filterOptions = [FilterOption]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttonAttributes = [
            NSFontAttributeName: AppFonts.navigationBarButton,
            NSForegroundColorAttributeName: AppColors.yellowColor
        ]
        
        applyButton.setTitleTextAttributes(buttonAttributes, forState: .Normal)
        
        title = NSLocalizedString("title", tableName: "Projects", comment: "")
        
        navigationController?.navigationBar.titleTextAttributes = [
            NSFontAttributeName: AppFonts.navbarTitleFont,
            NSForegroundColorAttributeName: AppColors.yellowColor
        ]
                
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterOptions.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("filterOptionCell", forIndexPath: indexPath)
        let option = filterOptions[indexPath.row]
        
        cell.textLabel?.text = NSLocalizedString(option.key, tableName: "Projects", comment: "")
        cell.accessoryType = option.selected ? .Checkmark : .None
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // TODO: does it make sense to have the struct immutable? any other more efficient way to handle this??
        filterOptions = filterOptions.enumerate().map({ (index, filterOption) -> FilterOption in
            if (index == indexPath.row) {
                return FilterOption(key: filterOption.key, value: filterOption.value, selected: !filterOption.selected)
            }
            
            return filterOption
        })
        
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return NSLocalizedString("project-categories", tableName: "Projects", comment: "")
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = AppFonts.tableHeaderTitle
    }
    
    @IBAction func apply(sender: AnyObject) {
        performSegueWithIdentifier("dismissFilterOptions", sender: self)
    }
    
}
