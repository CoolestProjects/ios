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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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