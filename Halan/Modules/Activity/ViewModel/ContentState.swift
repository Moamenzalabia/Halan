//
//  ContentState.swift
//  Halan
//
//  Created by Moamen Abd Elgawad on 24/01/2022.
//

import Foundation
/// This is the enum used to know data content states.
public enum ContentState {
    /// loading state
    case loading
    /// error state
    case error
    /// empty or init state
    case empty
    /// populated or completed state
    case populated
}
