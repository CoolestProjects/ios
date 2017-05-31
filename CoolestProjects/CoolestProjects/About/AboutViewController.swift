//
//  AboutViewController.swift
//  CoolestProjects
//
//  Created by Natasha Cole on 06/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import UIKit

class AboutViewController: BaseViewController {
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var statusBarBackgroundView: UIView!
  
    // TODO: Better nib loading
    let tableHeaderView : PageHeaderView = PageHeaderView.pageHeaderView()!
    let tableFooterView = HomeTableFooterView.footerView()!

    let viewModel = AboutViewModel()

    var selectImage : UIImage?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        
        tableView.register(UINib.init(nibName: "AboutViewTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "AboutViewCell")

        tableView.register(UINib.init(nibName: "BlurbTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "blurbCell")
        
        
        tableView.tableFooterView = tableFooterView
        tableView.tableHeaderView = tableHeaderView
        tableView.estimatedRowHeight = 300.0;
        tableView.rowHeight = UITableViewAutomaticDimension;

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        BeaconNotificationsManager.sharedInstance.setupBeaconsIfNeeded()
    }
    
    
    // TODO: better reuse with homeView
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        forceTableViewLayoutPhase()
        updateTableHeaderFrame()
        updateTableFooterFrame()
    }
    
    func forceTableViewLayoutPhase() {
        tableView.setNeedsLayout()
        tableView.layoutIfNeeded()
    }
    
    func updateTableHeaderFrame() {
        let minTableHeaderViewHeight = calculateMinTableHeaderViewHeight()
        tableHeaderView.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: minTableHeaderViewHeight)
        tableView.tableHeaderView = tableHeaderView
    }
    
    func updateTableFooterFrame() {
        tableFooterView.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 100.0)
        tableView.tableFooterView = tableFooterView
    }
    
    func calculateMinTableHeaderViewHeight() -> CGFloat {
        tableHeaderView.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 1600.0)
        tableHeaderView.setNeedsLayout()
        tableHeaderView.layoutIfNeeded()
        return tableHeaderView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
    }

}

extension AboutViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let component = viewModel.tableViewData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: component.componentIdentifier, for: indexPath)
      
        if (component is AboutModel) {

            let content = component as! AboutModel
            let contentCell = cell as! AboutViewTableViewCell
            contentCell.tableView = tableView

            contentCell.configure(with: content);
        }
        
        if (component is BlurbBox) {
            let blurbBox = component as! BlurbBox
            let contentCell = cell as! BlurbTableViewCell
            contentCell.configure(with: blurbBox);
        }
        
        return cell
    }
  
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var adjustedOffset = scrollView.contentOffset.y
        adjustedOffset = max(0, adjustedOffset)
        adjustedOffset = min(adjustedOffset, 140)
        let alpha = adjustedOffset / 140
        statusBarBackgroundView.alpha = alpha
    }
  
}
