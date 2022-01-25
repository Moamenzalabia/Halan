//
//  ActivityDataService.swift
//  Halan
//
//  Created by Moamen Abd Elgawad on 24/01/2022.
//

import Foundation
import Foundation
import Moya

class ActivityDataService {
    
    fileprivate let provider = MoyaProvider<ActivityService>(endpointClosure: { (target: ActivityService) -> Endpoint in
        let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
        switch target {
        default:
            let httpHeaderFields = ["Content-Type" : "application/json"]
            return defaultEndpoint.adding(newHTTPHeaderFields: httpHeaderFields)
        }
    })
    
    func requestFetchActivity(completion: @escaping ((ActivityModel?, Error?) -> Void)) {
        provider.request(.fetchActivity) { result in
            switch result {
            case .success(let response):
                do {
                    let decoder = JSONDecoder()
                    let users = try decoder.decode(ActivityModel.self, from: response.data)
                    completion(users, nil)
                } catch (let error) {
                    completion(nil, error)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    }
