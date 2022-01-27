//
//  ActivityViewModel.swift
//  Halan
//
//  Created by Moamen Abd Elgawad on 24/01/2022.
//

import Foundation

// MARK: - ActivityViewModel
class ActivityViewModel: ActivityViewModelProtocol {
    
    var dataService: ActivityDataServiceProtocol?
    
    var updateLoadingStatus: (() -> Void)?
    
    var updateActivityUIData: (() -> Void)?
    
    var showErrorMessageAlert: (() -> Void)?
    
    var activityUIData: ActivityDataUIModel? {
        didSet {
            updateActivityUIData?()
        }
    }
    
    var contentState: ContentState = .empty {
        didSet {
            updateLoadingStatus?()
        }
    }
    
    var alertMessage: String? {
        didSet {
            showErrorMessageAlert?()
        }
    }
    
    init(service: ActivityDataServiceProtocol?) {
        dataService = service
    }
    
    func fetchActivity() {
        contentState = .loading
        dataService?.requestFetchActivity { [weak self] (activity, error) in
            guard let self = self else {
                return
            }
            guard error == nil else {
                self.contentState = .error
                self.alertMessage = error?.localizedDescription
                return
            }
            if let activity = activity {
                self.createActivityDataViewModel(activity: activity)
            }
            self.contentState = .populated
        }
    }
    
    func createActivityDataViewModel(activity: ActivityModel) {
        activityUIData = ActivityDataUIModel(activity: activity.activity, type: activity.type, participants: activity.participants, price: activity.price, link: activity.link)
    }
    
}
