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
            
            self.tableViewData = SponsorTrierViewModel.buildSponsorTierViewModels(tiers as NSArray)
        });
        
    }

    func setupTableView() {
        tableView.estimatedRowHeight = 216;
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.register(UINib.init(nibName: "SponsorTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "sponsorCell")
        
        tableView.register(SponsorTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "sponsorHeader")
    }
    
    override func setupNavigationBar() {
        navigationItem.title = NSLocalizedString("navbar.title",tableName: "Sponsors", comment: "")

        super.setupNavigationBar()
    }

}

extension SponsorsViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let sponsors = tableViewData[section].sponsors {
            return sponsors.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let component = tableViewData[indexPath.section].sponsors![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: component.componentIdentifier, for: indexPath)
        
        let sponsorCell = cell as! SponsorTableViewCell
        sponsorCell.displayViewModel(component)

        
        return cell
    }

}

extension SponsorsViewController : UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: "sponsorHeader")
        let header = cell as! SponsorTableViewHeader
        header.displayViewModel(tableViewData[section])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44;
    }
}
