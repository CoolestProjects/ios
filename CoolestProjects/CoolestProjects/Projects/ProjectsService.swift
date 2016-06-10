//
//  ProjectsService.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 09/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import Foundation
import Alamofire
import Gloss

let projectsEndpoint: String = "https://register.coolestprojects.org/api/project/summary"

enum ProjectsServiceResult {
    case Success([Project])
    case Failure(ErrorType)
    
    func error() -> ErrorType? {
        if case .Failure(let error) = self {
            return error
        }
        return nil
    }
    
    func data() -> [Project]? {
        if case .Success(let data) = self {
            return data
        }
        return nil
    }
}

typealias ProjectsServiceCompletion = (ProjectsServiceResult) -> Void

class ProjectsService {
    
    func fetchProjects(completion: ProjectsServiceCompletion? = nil) {
        
        Alamofire.request(.GET, projectsEndpoint)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    
                    do {
                        // TODO: pure swift parsing???
                        // TODO: duplicated code with store
                        let json = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions()) as! [JSON]
                        let projects = [Project].fromJSONArray(json)
                        completion?(.Success(projects))
                    } catch let error {
                        completion?(.Failure(error))
                    }
                    
                case .Failure(let error):
                    completion?(.Failure(error))
                }
        }
        
    }
    
}
