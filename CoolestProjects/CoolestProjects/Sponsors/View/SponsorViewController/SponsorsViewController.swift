//
//  SponsorsViewController.swift
//  CoolestProjects
//
//  Created by BooRanger on 06/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import UIKit

class SponsorsViewController: BaseViewController {
    var tableViewData : [SponsorBox] = [] { didSet {
        self.tableView.reloadData()
        }}
    
    @IBOutlet weak var tableView: UITableView!
    
    let tableHeaderView = PageHeaderView.pageHeaderView()!
    let tableFooterView = HomeTableFooterView.footerView()!
    
    let viewModel : SponsorViewModel = SponsorViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        
        super.viewWillAppear(animated)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        forceTableViewLayoutPhase()
        updateTableHeaderFrame()
        updateTableFooterFrame()
    }
    
    
    override func setupNavigationBar() {
        navigationItem.title = NSLocalizedString("navbar.title",tableName: "Sponsors", comment: "")

        super.setupNavigationBar()
    }

    func setupTableView() {
        tableView.tableHeaderView = tableHeaderView
        tableView.tableFooterView = tableFooterView
        tableView.estimatedRowHeight = 216;
        tableView.rowHeight = UITableViewAutomaticDimension
        registerTableViewCellNamed(nibName: "SponsorBoxTableViewCell", reuseIdentifier: "sponsorBox")
    }
    
    func registerTableViewCellNamed(nibName: String, reuseIdentifier: String) {
        tableView.register(UINib.init(nibName: nibName, bundle: Bundle.main), forCellReuseIdentifier: reuseIdentifier)
    }
    
    func forceTableViewLayoutPhase() {
        tableView.setNeedsLayout()
        tableView.layoutIfNeeded()
    }
    
    func updateTableHeaderFrame() {
        let minTableHeaderViewHeight = calculateMinTableHeaderViewHeight()
        tableHeaderView.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height:minTableHeaderViewHeight)
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

extension SponsorsViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableViewData.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let component = viewModel.tableViewData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: component.componentIdentifier, for: indexPath)
        cell.selectionStyle = .none
        
        if (component is SponsorBox) {
            let sponsorBox = component as! SponsorBox
            let sponsorBoxCell = cell as! SponsorBoxTableViewCell
            sponsorBoxCell.configure(with: sponsorBox)
        }
        
        return cell
    }

}
