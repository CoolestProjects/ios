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

let projectsEndpoint: String = "https://dublin.coolestprojects.org/api/project/summary/2"

enum ProjectsServiceResult {
    case success([Project])
    case failure(Error)
    
    func error() -> Error? {
        if case .failure(let error) = self {
            return error
        }
        return nil
    }
    
    func data() -> [Project]? {
        if case .success(let data) = self {
            return data
        }
        return nil
    }
}

typealias ProjectsServiceCompletion = (ProjectsServiceResult) -> Void

class ProjectsService {
    
    func fetchProjects(_ completion: ProjectsServiceCompletion? = nil) {
        
        Alamofire.request(projectsEndpoint)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    
                    do {                        
                        let json = try JSONSerialization.jsonObject(with: response.data!) as! [JSON]
                        let projects = [Project].partialFrom(jsonArray: json)
                        completion?(.success(projects))
                    } catch let error {
                        completion?(.failure(error))
                    }
                    
                case .failure(let error):
                    completion?(.failure(error))
                }
        }
        
    }
    
}
