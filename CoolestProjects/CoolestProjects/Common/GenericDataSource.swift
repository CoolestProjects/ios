//
//  GenericDataSource.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 05/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import Foundation

protocol DataContaining {
    associatedtype ItemType
    var data: [ItemType] { get }
}

extension DataContaining {
    
    var numberOfItems: Int {
        return data.count
    }
    
    func item(atIndex index: Int) -> ItemType? {
        guard index < numberOfItems else {
            return nil
        }
        
        return data[index]
    }
}

protocol SectionType : DataContaining {
    var headerTitle: String? { get }
    var footerTitle: String? { get }
}

extension SectionType {
    var headerTitle: String? {
        return nil
    }
    
    var footerTitle: String? {
        return nil
    }
}

protocol SectionContaining {
    associatedtype Section: SectionType
    
    var sections: [Section] { get }
}

extension SectionContaining {
    
    var numberOfSections: Int {
        return sections.count
    }
    
    func section(atIndex index: Int) -> Section? {
        guard index < numberOfSections else {
            return nil
        }
        
        return sections[index]
    }

    func item(atIndexPath indexPath: IndexPath) -> Section.ItemType? {
        return section(atIndex: indexPath.section)?.item(atIndex: indexPath.row)
    }
}
