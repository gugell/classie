//
//  ListingDetailsModuleRouter.swift
//  Classie
//
//  Created by Ilia Gutu on 15.01.2022.
//

import Foundation
import UIKit

/// Modules router input
protocol ListingDetailsModuleRouterInput: AnyObject {
  /// Show images fullscreen
    func showListingImages(_ listing: Listing)
    /// Dismiss the screen
    func dismiss()
}

/// Modules router
final class ListingDetailsModuleRouter: ListingDetailsModuleRouterInput {

    let coordinator: DetailsFlowCoordinatorInput

    init(coordinator: DetailsFlowCoordinatorInput) {
        self.coordinator = coordinator
    }

    /// Show images fullscreen
    func showListingImages(_ listing: Listing) {

    }

    func dismiss() {
        coordinator.dismiss()
    }
}
