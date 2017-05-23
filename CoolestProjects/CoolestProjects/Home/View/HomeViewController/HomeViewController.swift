//
//  HomeViewController.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 02/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

let SponsorBoxHeight: CGFloat = 300.0

class HomeViewController : BaseViewController {

    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    // TODO: better nib loading
    let tableHeaderView = PageHeaderView.pageHeaderView()!
    let tableFooterView = HomeTableFooterView.footerView()!
    let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupMask()
        forceTableViewLayoutPhase()
        updateTableHeaderFrame()
        updateTableFooterFrame()
    
    }
    
    func setupUI() {
        setupBackgroundImage()
        setupNavigationBar()
        setupTable()
    }
    
    func setupBackgroundImage() {
        overlayView.backgroundColor = UIColor.red
    }
    
    func setupMask() {
        wrapperView.backgroundColor = UIColor.blue
    }
    
    override func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.titleView = UIImageView(image: UIImage(named: "coolest-project-logo"))
    }
    
    func setupTable() {
        tableView.tableHeaderView = tableHeaderView
        tableView.tableFooterView = tableFooterView
        tableView.estimatedRowHeight = 300.0;
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.register(UINib.init(nibName: "SponsorBoxTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "sponsorBox")
        tableView.register(PageHeaderTableViewCell.self, forCellReuseIdentifier: "pageHeader")
        tableView.register(UINib.init(nibName: "ContentTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "contentCell")
        tableView.register(UINib.init(nibName: "BlurbTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "blurbBox")

    }
    
    func forceTableViewLayoutPhase() {
        tableView.setNeedsLayout()
        tableView.layoutIfNeeded()
    }
    
    func updateTableHeaderFrame() {
        let minTableHeaderViewHeight = calculateMinTableHeaderViewHeight()
        let availableSpace = tableView.bounds.height - SponsorBoxHeight
        tableHeaderView.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: max(minTableHeaderViewHeight, availableSpace))
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

extension HomeViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let component = viewModel.tableViewData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: component.componentIdentifier, for: indexPath)
        
        // TODO: try to improve using better generics or protocol oriented data sources
        
        if (component is SponsorBox) {
            let sponsorBox = component as! SponsorBox
            let sponsorBoxCell = cell as! SponsorBoxTableViewCell
            sponsorBoxCell.configure(with: sponsorBox)
        }
        
        if (component is ContentViewModel) {
            let content = component as! ContentViewModel
            let contentCell = cell as! ContentTableViewCell
            contentCell.configure(with: content);
        }
        
        if (component is BlurbBox) {
            let blurbBox = component as! BlurbBox
            let contentCell = cell as! BlurbTableViewCell
            contentCell.configure(with: blurbBox);
        }

        return cell
    }
    
}

