//
//  ActivityViewModel.swift
//  Halan
//
//  Created by Moamen Abd Elgawad on 24/01/2022.
//

import Foundation

// MARK: - ActivityViewModel
class ActivityViewModel {
    
    var service: ActivityDataService?
    var updateUIClosure: (()->())?
    var showAlertClosure: (()->())?
    var updateLoadingStatus: (()->())?
    
    init(service: ActivityDataService?) {
        self.service = service
    }
    
    var activityDataViewModel: ActivityDataViewModel? {
        didSet {
            self.updateUIClosure?()
        }
    }
    
    var state: State = .empty {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    func fetchActivity() {
        state = .loading
        service?.requestFetchActivity { [weak self] (activity, error) in
            guard let self = self else {
                return
            }
            guard error == nil else {
                self.state = .error
                self.alertMessage = error?.localizedDescription
                return
            }
            if let activity = activity {
                self.createActivityDataViewModel(activity: activity)
            }
            self.state = .populated
        }
    }
    
    func createActivityDataViewModel(activity: ActivityModel ) {
        activityDataViewModel = ActivityDataViewModel(activity: activity.activity, type: activity.type, participants: activity.participants, price: activity.price, link: activity.link)
    }
    
}
