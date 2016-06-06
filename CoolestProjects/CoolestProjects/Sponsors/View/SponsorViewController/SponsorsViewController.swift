//
//  SponsorsViewController.swift
//  CoolestProjects
//
//  Created by BooRanger on 06/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import UIKit

class SponsorsViewController: BaseViewController {
    
    var viewModel : SponsorTierViewModel? { didSet {
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
    

}

extension SponsorsViewController : UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let viewModel = self.viewModel {
            return viewModel.tableViewData!.count
            
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let component = viewModel!.tableViewData![indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(component.componentIdentifier, forIndexPath: indexPath)
        
        
        let speakerCell = cell as! SpeakerTableViewCell
        speakerCell.displayViewModel(component)
        
        
        return cell
    }
    
}