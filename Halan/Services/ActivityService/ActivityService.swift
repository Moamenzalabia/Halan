//
//  ActivityService.swift
//  Halan
//
//  Created by Moamen Abd Elgawad on 24/01/2022.
//

import Foundation
import Moya

enum ActivityService {
    case fetchActivity
}

extension ActivityService: TargetType {
    
    var baseURL: URL {
        let baseUrl = URLsConstants.String.BaseURL.baseUrl
        guard let url = URL(string: baseUrl) else {
            fatalError("URL cannot be configured.")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .fetchActivity:
            return "/activity"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchActivity:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}
