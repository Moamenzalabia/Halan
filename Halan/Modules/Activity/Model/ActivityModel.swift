//
//  ActivityModel.swift
//  Halan
//
//  Created by Moamen Abd Elgawad on 24/01/2022.
//

import Foundation

// MARK: - ActivityModel
struct ActivityModel: Codable {
    let activity: String?
    let type: String?
    let participants: Int?
    let price: Double?
    let link: String?
    let key: String?
    let accessibility: Double?
}
