//
//  MockActivityDataService.swift
//  HalanTests
//
//  Created by Moamen Abd Elgawad on 26/01/2022.
//
import Foundation
@testable import Halan

class MockActivityDataService: ActivityDataServiceProtocol {
    var isTestSuccess = true
    
    func requestFetchActivity(completion: @escaping (FetchActivityCompletion)) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            guard let self = self else {
                return
            }
            if self.isTestSuccess{
                let mockActivity = ActivityModel(activity: "Visit your past teachers", type: "social", participants: 1, price: 0.2, link: "https://www.boredapi.com", key: "8238918", accessibility: 0.7)
                completion(mockActivity, nil)
            } else {
                completion(nil, MockError.failedToLoadData)
            }
        }
    }
}

extension MockActivityDataService {
    enum MockError: Error {
        case failedToLoadData
    }
}
