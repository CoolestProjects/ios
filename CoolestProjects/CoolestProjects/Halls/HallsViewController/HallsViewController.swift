//
//  HallsViewController.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 28/05/2017.
//  Copyright © 2017 coderdojo. All rights reserved.
//

import Foundation
import UIKit

class HallsViewController: UIViewController {

    @IBOutlet weak var statusBarBackgroundView: UIView!
    @IBOutlet weak var hallsTableView: UITableView!

    let tableHeaderView = PageHeaderView.pageHeaderView()!
    let tableFooterView = HomeTableFooterView.footerView()!

    var scheduleService: ScheduleService?

    var halls = [Hall]()
    var selectedHall: Hall?

    var tableViewData = [Component]() {
        didSet {
            hallsTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        scheduleService = ScheduleServiceImpl()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadHallsData()
    }

    // TODO: this boilerplate code needs to be moved in a common place
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        forceTableViewLayoutPhase()
        updateTableHeaderFrame()
        updateTableFooterFrame()
    }

    func setupUI() {
        setupStatusBarBackgroudColor()
        setupTable()
    }

    func setupStatusBarBackgroudColor() {
        statusBarBackgroundView.backgroundColor = UIColor.sapphire
    }

    func setupTable() {
        hallsTableView.backgroundColor = UIColor.paleGrey
        hallsTableView.tableHeaderView = tableHeaderView
        hallsTableView.tableFooterView = tableFooterView
        hallsTableView.estimatedRowHeight = 300.0;
        hallsTableView.rowHeight = UITableViewAutomaticDimension;
        hallsTableView.register(PageHeaderTableViewCell.self, forCellReuseIdentifier: "pageHeader")
        hallsTableView.register(UINib.init(nibName: "BlurbTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "blurbCell")
        hallsTableView.register(UINib.init(nibName: "ContentTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "contentCell")
    }

    func forceTableViewLayoutPhase() {
        hallsTableView.setNeedsLayout()
        hallsTableView.layoutIfNeeded()
    }

    func updateTableHeaderFrame() {
        let minTableHeaderViewHeight = calculateMinTableHeaderViewHeight()
        tableHeaderView.frame = CGRect(x: 0, y: 0, width: hallsTableView.bounds.width, height: minTableHeaderViewHeight)
        hallsTableView.tableHeaderView = tableHeaderView
    }

    func updateTableFooterFrame() {
        tableFooterView.frame = CGRect(x: 0, y: 0, width: hallsTableView.bounds.width, height: 100.0)
        hallsTableView.tableFooterView = tableFooterView
    }

    func calculateMinTableHeaderViewHeight() -> CGFloat {
        tableHeaderView.frame = CGRect(x: 0, y: 0, width: hallsTableView.bounds.width, height: 1600.0)
        tableHeaderView.setNeedsLayout()
        tableHeaderView.layoutIfNeeded()
        return tableHeaderView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
    }

    func loadHallsData() {
        let bb = blurbBox
        tableViewData = [bb]

        scheduleService?.halls() { [weak self] (halls) in
            if let halls = halls {
                self?.halls = halls
                self?.tableViewData = [bb] + halls.map() { ContentViewModel(hall: $0) }
            }
        }
    }

    var blurbBox: BlurbBox {
        get { return BlurbBox(title: NSLocalizedString("date.title", tableName: "Home", comment: "")) }
    }

}

extension HallsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let component = tableViewData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: component.componentIdentifier, for: indexPath)
        cell.selectionStyle = .none

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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let hallActivitiesViewController = segue.destination as? HallActivitiesViewController else { return }
        hallActivitiesViewController.hall = selectedHall
    }

}

extension HallsViewController: UITableViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var adjustedOffset = scrollView.contentOffset.y
        adjustedOffset = max(0, adjustedOffset)
        adjustedOffset = min(adjustedOffset, 140)
        let alpha = adjustedOffset / 140
        statusBarBackgroundView.alpha = alpha
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != 0 {
            let adjustedIndex  = indexPath.row - 1
            selectedHall = halls[adjustedIndex]
            performSegue(withIdentifier: "hallActivities", sender: self)
        }

        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}
