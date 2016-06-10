//
//  SponsorsViewController.swift
//  CoolestProjects
//
//  Created by BooRanger on 06/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import UIKit

class SponsorsViewController: BaseViewController {
    var tableViewData : [SponsorTrierViewModel] = [] { didSet {
        self.tableView.reloadData()
        }}
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getSponsors()
        setupTableView()
        setupNavigationBar()
    }

    func getSponsors() {
        let firbaseService = CPAFirebaseDefaultService()
        
        firbaseService.getSponsorsWithCompletionBlock({ (sponsorTiers, error) in
            guard let tiers = sponsorTiers else {
                return
            }
            
            self.tableViewData = SponsorTrierViewModel.buildSponsorTierViewModels(tiers)
        });
        
    }

    func setupTableView() {
        tableView.estimatedRowHeight = 216;
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.registerNib(UINib.init(nibName: "SponsorTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "sponsorCell")
        
        tableView.registerClass(SponsorTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "sponsorHeader")
    }
    
    func setupNavigationBar() {
        //TODO: Viewmodel
        navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        navigationController?.navigationBar.translucent = false
        navigationItem.title = NSLocalizedString("navbar.title",tableName: "Speakers", comment: "")
        navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: AppColors.yellowColor,
            NSFontAttributeName: AppFonts.navigationBarTitle
            
        ]
    }

}

extension SponsorsViewController : UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let sponsors = tableViewData[section].sponsors {
            return sponsors.count
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let component = tableViewData[indexPath.section].sponsors![indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(component.componentIdentifier, forIndexPath: indexPath)
        
        let sponsorCell = cell as! SponsorTableViewCell
        sponsorCell.displayViewModel(component)

        
        return cell
    }

}

extension SponsorsViewController : UITableViewDelegate {

    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = self.tableView.dequeueReusableHeaderFooterViewWithIdentifier("sponsorHeader")
        let header = cell as! SponsorTableViewHeader
        header.displayViewModel(tableViewData[section])
        return cell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44;
    }
}
