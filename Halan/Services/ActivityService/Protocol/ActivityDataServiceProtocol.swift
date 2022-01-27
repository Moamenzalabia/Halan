//
//  ActivityDataServiceProtocol.swift
//  Halan
//
//  Created by Moamen Abd Elgawad on 26/01/2022.
//

import Foundation
/// Activity DataService Protocol
typealias FetchActivityCompletion = ( (ActivityModel?, Error?) -> Void)
protocol ActivityDataServiceProtocol {
    /// Method to request fetching activity data.
    /// - Parameters:
    ///     - completion: An response *ActivityModel*
    func requestFetchActivity(completion: @escaping (FetchActivityCompletion))
}
