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


    let scheduleService = ScheduleServiceImpl()
    let panelsDataSource = PanelsTableViewDataSource()
    let workshop1DataSource = WorkshopTableViewDataSource()
    let workshop2DataSource = WorkshopTableViewDataSource()

    var hallId: String? = "iot"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadContent()
    }

    func setupUI() {
        setupEdges()
        setupMask()
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
        guard let hallId = hallId else { return }

        scheduleService.hall(with: hallId) { [weak self] (hall) in
            if let hall = hall {
                self?.panelsDataSource.panels = hall.panels
                self?.workshop1DataSource.workshops = hall.workshops1
                self?.workshop2DataSource.workshops = hall.workshops2
                self?.activitiesTableView.reloadData()
            }
        }
    }

    func segmentedControlValueChanged(segment: UISegmentedControl) {
        var dataSource: UITableViewDataSource?

        if segment.selectedSegmentIndex == 0 {
            dataSource = panelsDataSource
        } else if segment.selectedSegmentIndex == 1 {
            dataSource = workshop1DataSource
        }  else {
            dataSource = workshop2DataSource
        }

        activitiesTableView.dataSource = dataSource
        activitiesTableView.reloadData()
    }

}
