//
//  RegionInteractionStoreTest.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 23/04/2017.
//  Copyright © 2017 coderdojo. All rights reserved.
//

import XCTest
@testable import Coolest_Projects

class RegionInteractionStoreTest: XCTestCase {

    override func setUp() {
        super.setUp()
        cleanTestData()
    }

    func testInitAndLoadStoredData_NewInstall() {
        let store = RegionInteractionStoreImpl()
        XCTAssertEqual(store.allInteractions().count, 0)
    }

    func testInitAndLoadStoredData_PrevRecordedData() {
        addTestData(fixtureFileName: "RegionInteractions")
        let store = RegionInteractionStoreImpl()
        XCTAssertEqual(store.allInteractions().count, 2)
        XCTAssertEqual(store.allInteractions()[0], RegionInteraction(regionId: "SCRATCH", messageVersionId: "2", timestamp: 1492990200))
        XCTAssertEqual(store.allInteractions()[1], RegionInteraction(regionId: "GAMES", messageVersionId: "1", timestamp: 1492991100))
    }

    func testInitAndLoadStoredData_InvalidData() {
        addTestData(fixtureFileName: "RegionInteractionsInvalidData")
        let store = RegionInteractionStoreImpl()
        XCTAssertEqual(store.allInteractions().count, 0)
    }
    
    func testLastInteractionWithRegionIsNilWhenNoPrevInteraction() {
        let store = RegionInteractionStoreImpl()
        XCTAssertNil(store.lastInteractionWithRegion("SCRATCH"))
    }

    func testLastInteractionWithRegionIsNilWhenNoInteractionMatchesRegionId() {
        addTestData(fixtureFileName: "RegionInteractions")
        let store = RegionInteractionStoreImpl()
        XCTAssertNil(store.lastInteractionWithRegion("WEB"))
    }

    func testCanFindLastInteractionWithRegion() {
        addTestData(fixtureFileName: "RegionInteractions")
        let store = RegionInteractionStoreImpl()
        XCTAssertEqual(store.lastInteractionWithRegion("GAMES"), RegionInteraction(regionId: "GAMES", messageVersionId: "1", timestamp: 1492991100))
    }

    func testAddInteractionWithNewRegion() {
        let store = RegionInteractionStoreImpl()
        XCTAssertEqual(store.allInteractions().count, 0)

        store.setInteractionWithRegion("WEB", messageVersionId: "1")

        XCTAssertEqual(store.allInteractions().count, 1)
        XCTAssertEqual(store.allInteractions()[0].regionId, "WEB")
        XCTAssertEqual(store.allInteractions()[0].messageVersionId, "1")
    }

    func testUpdateInteractionWithNewRegion() {
        addTestData(fixtureFileName: "RegionInteractions")
        let store = RegionInteractionStoreImpl()
        XCTAssertEqual(store.allInteractions().count, 2)
        
        store.setInteractionWithRegion("SCRATCH", messageVersionId: "3")

        XCTAssertEqual(store.allInteractions().count, 2)
        XCTAssertEqual(store.allInteractions()[1].regionId, "SCRATCH")
        XCTAssertEqual(store.allInteractions()[1].messageVersionId, "3")
    }

    func cleanTestData() {
        let url = dataDirUrl()
        if FileManager.default.fileExists(atPath: url.path) {
            try! FileManager.default.removeItem(at: url)
        }
    }

    func addTestData(fixtureFileName: String) {
        let url = dataDirUrl()
        try! FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        let fixtureFileUrl = Bundle(for: type(of: self)).url(forResource: fixtureFileName, withExtension: "json")
        let fixtureFileDestUrl = url.appendingPathComponent("regionInteractions.json")
        try! FileManager.default.copyItem(at: fixtureFileUrl!, to: fixtureFileDestUrl)
    }

    func dataDirUrl() -> URL {
        let appSupportDirs = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)
        let bundleIdentifier = Bundle.main.bundleIdentifier!
        return appSupportDirs.first!.appendingPathComponent(bundleIdentifier)
    }

}
