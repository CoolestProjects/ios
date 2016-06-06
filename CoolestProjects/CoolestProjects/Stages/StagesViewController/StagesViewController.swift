//
//  StagesViewController.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 05/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import Foundation
import UIKit

class StagesViewController : BaseViewController {
    
    @IBOutlet weak var speakersTableView: UITableView!
    @IBOutlet weak var summitCategoriesContainerView: UIView!
    
    var summitCategoriesSegmentedControl: UISegmentedControl!
    
    var firebaseService: CPAFirebaseDefaultService?
    
    var allSummits = [CPASummit]()
    
    var selectedSummitIndex = 0
    var selectedSpeakes = [CPASpeaker]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadContent()
    }
    
    func setupUI() {
        setupEdges()
        setupTitle()
        setupTableView()
    }
    
    func loadContent() {
        firebaseService = CPAFirebaseDefaultService()
        firebaseService?.getSummitsWithCompletionBlock { [unowned self] (summitList, error) in
            if let summitList = summitList {
                self.allSummits = summitList
                self.setupTabBarButtons()
                self.selectSummit(atIndex: 0)
                self.updateUI()
            }
        }
    }
    
    func selectSummit(atIndex index: Int) {
        guard index < allSummits.count else { return }
        
        selectedSummitIndex = index
        summitCategoriesSegmentedControl.selectedSegmentIndex = index
        selectedSpeakes = allSummits[index].speakers as! [CPASpeaker]
    }
    
    func setupTabBarButtons() {
        
        let summitCategories = allSummits.map { (summit) -> String in
            summit.name
        }
                
        let style = NSMutableParagraphStyle()
        style.lineBreakMode = .ByWordWrapping
        style.alignment = .Center
        
        let normalStateAttributes = [
            NSFontAttributeName: AppFonts.tabBarFontSelected,
            NSForegroundColorAttributeName: AppColors.darkTextColor,
            NSParagraphStyleAttributeName: style
        ]
        
        let selectedStateAttributes = [
            NSFontAttributeName: AppFonts.tabBarFontSelected,
            NSForegroundColorAttributeName: AppColors.blueColor,
            NSParagraphStyleAttributeName: style
        ]
        
        UILabel.appearanceWhenContainedInInstancesOfClasses([UISegmentedControl.self]).numberOfLines = 0
        
        summitCategoriesSegmentedControl = UISegmentedControl(items: summitCategories)
        summitCategoriesSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        summitCategoriesSegmentedControl.addTarget(self, action: #selector(StagesViewController.changeSummitCategory(_:)), forControlEvents: .ValueChanged);
        
        summitCategoriesSegmentedControl.setTitleTextAttributes(normalStateAttributes, forState: .Normal)
        summitCategoriesSegmentedControl.setTitleTextAttributes(selectedStateAttributes, forState: .Selected)
        
        summitCategoriesSegmentedControl.setDividerImage(UIImage(), forLeftSegmentState: .Normal, rightSegmentState: .Normal, barMetrics: .Default)
        summitCategoriesSegmentedControl.setDividerImage(UIImage(), forLeftSegmentState: .Selected, rightSegmentState: .Normal, barMetrics: .Default)
        summitCategoriesSegmentedControl.setDividerImage(UIImage(), forLeftSegmentState: .Normal, rightSegmentState: .Selected, barMetrics: .Default)
        summitCategoriesSegmentedControl.setBackgroundImage(UIImage(), forState: .Normal, barMetrics: .Default)
        summitCategoriesSegmentedControl.setBackgroundImage(UIImage(), forState: .Selected, barMetrics: .Default)
        
        summitCategoriesContainerView.addSubview(summitCategoriesSegmentedControl)
        summitCategoriesContainerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[control]|",
            options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["control": summitCategoriesSegmentedControl]))
        summitCategoriesContainerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[control]|",
            options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["control": summitCategoriesSegmentedControl]))
    }
    
    func changeSummitCategory(sender: UISegmentedControl) {
        selectSummit(atIndex: summitCategoriesSegmentedControl.selectedSegmentIndex)
        updateUI()
    }
    
    func updateUI() {
        speakersTableView.reloadData()
    }
    
    func setupEdges() {
        edgesForExtendedLayout = .None
    }
    
    func setupTitle() {
        title = NSLocalizedString("title", tableName: "Stages", comment: "")
    }
    
    func setupTableView() {
        speakersTableView.estimatedRowHeight = 180.0;
        speakersTableView.rowHeight = UITableViewAutomaticDimension;
        speakersTableView.registerNib(UINib.init(nibName: "StagesTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "speaker")
    }
}

extension StagesViewController : UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedSpeakes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let item = selectedSpeakes[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("speaker", forIndexPath: indexPath) as! StagesTableViewCell
        cell.configure(withItem: item)
        return cell        
    }
    
}