//
//  ActivityViewModelProtocol.swift
//  Halan
//
//  Created by Moamen Abd Elgawad on 26/01/2022.
//

import Foundation

/// Activity ViewModel Protocol
protocol ActivityViewModelProtocol {
    /// update loading status closure to update controller when contentState is changed
    var updateLoadingStatus: (() -> Void)? { get set }
    /// update activity UIData closure to update controller when activityDataViewModel is changed
    var updateActivityUIData: (() -> Void)? { get set }
    /// show error message alert closure to show alert when an error is happend
    var showErrorMessageAlert: (() -> Void)? { get set }
    /// activity UIData ViewModel to set activity view data
    var activityUIData: ActivityDataUIModel? { get }
    /// controller content state
    var contentState: ContentState { get }
    /// controller loading type
    var loadingType: LoadingType { get set }
    /// alert message string
    var alertMessage: String? { get }
    /// fetch activity data
    func fetchActivity()
}
