//
//  HallActivitiesViewController.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 27/05/2017.
//  Copyright © 2017 coderdojo. All rights reserved.
//

import Foundation
import UIKit

class HallActivitiesViewController: UIViewController {

    @IBOutlet weak var activitiesSegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableMaskView: UIView!
    @IBOutlet weak var activitiesTableView: UITableView!

    let panelsDataSource = PanelsTableViewDataSource()
    let workshop1DataSource = WorkshopTableViewDataSource()
    let workshop2DataSource = WorkshopTableViewDataSource()

    var hall: Hall?
    var preselectedActivity: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadContent()
        preselectActivity()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    func setupUI() {
        setupEdges()
        setupMask()
        setupTitle()
        setupTableView()
        setupActivitiesSegmentedControl()
    }

    func setupEdges() {
        edgesForExtendedLayout = []
    }

    func setupMask() {
        let gradient = CAGradientLayer()
        gradient.frame = tableMaskView.bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.white.cgColor]
        gradient.locations = [0 as NSNumber, 2.5/100.0 as NSNumber, 1 as NSNumber]
        tableMaskView.layer.mask = gradient
    }

    func setupTitle() {
        title = hall?.name
    }

    func setupTableView() {
        activitiesTableView.estimatedRowHeight = 300.0;
        activitiesTableView.rowHeight = UITableViewAutomaticDimension;
        activitiesTableView.register(UINib.init(nibName: "PanelTableViewCell", bundle: Bundle.main),
                                   forCellReuseIdentifier: "panel")
        activitiesTableView.register(UINib.init(nibName: "WorkshopTableViewCell", bundle: Bundle.main),
                                   forCellReuseIdentifier: "workshop")
        activitiesTableView.dataSource = panelsDataSource
    }

    func setupActivitiesSegmentedControl() {
        activitiesSegmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(segment:)), for: .valueChanged)
    }

    func loadContent() {
        guard let hall = hall else { return }

        panelsDataSource.panels = hall.panels
        workshop1DataSource.workshops = hall.workshops1
        workshop2DataSource.workshops = hall.workshops2
        activitiesTableView.reloadData()
    }

    func preselectActivity() {
        if let preselectedActivity = preselectedActivity,
            let idx = ["panels", "workshop1", "workshop2"].index(of: preselectedActivity) {
            activitiesSegmentedControl.selectedSegmentIndex = idx
            updateDataSource()
        }
    }

    func segmentedControlValueChanged(segment: UISegmentedControl) {
        updateDataSource()
    }

    func updateDataSource() {
        var dataSource: UITableViewDataSource?

        if activitiesSegmentedControl.selectedSegmentIndex == 0 {
            dataSource = panelsDataSource
        } else if activitiesSegmentedControl.selectedSegmentIndex == 1 {
            dataSource = workshop1DataSource
        }  else {
            dataSource = workshop2DataSource
        }

        activitiesTableView.dataSource = dataSource
        activitiesTableView.reloadData()
    }

}
