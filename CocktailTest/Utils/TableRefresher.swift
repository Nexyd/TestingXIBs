//
//  TableRefresher.swift
//  CocktailTest
//
//  Created by Daniel Morato on 14/12/2018.
//  Copyright © 2018 Daniel Moraleda. All rights reserved.
//

import Foundation
import UIKit

/// This class serves as a quick implementation of a pull to refresh action.
class TableRefresher {

    private var userIsRefreshing: Bool
    private var lastContentOffset: CGFloat
    private var contentOffset: CGFloat
    private var maximumOffset: CGFloat

    /// Base initializer
    init() {
        self.userIsRefreshing = false
        self.lastContentOffset = 0.0
        self.contentOffset = 0.0
        self.maximumOffset = 0.0
    }

    /// Enumeration of the possible directions to pull.
    enum Directions {
        case up
        case down
    }

    /// Validates the pull with boundaries before refresh.
    /// - Parameters:
    ///     - direction: Direction in which the user pulled.
    ///     - table: Table which is going to be refreshed.
    ///     - method: Method to be called upon refresh.
    func validatePullRefresh(withDirection direction: Directions,
        for table: UITableView, with method: @escaping () -> Void)
    {
        contentOffset = table.contentOffset.y
        maximumOffset = table.contentSize.height
            - table.frame.size.height

        // If the user has ended refreshing and the table is within boundaries
        // then we can refresh the table with the method passed.
        // This is done to prevent multiple callings upon pull.
        if !userIsRefreshing && isWithinThreshold(of: direction) {
            refresh(table: table, with: method)
        }
    }

    /// Calls on the passed method to gather data,
    /// and refreshes the table with it
    /// - Parameters:
    ///     - table: Table to refresh
    ///     - method: Method to gather data
    private func refresh(table: UITableView,
        with method: @escaping () -> Void)
    {
        userIsRefreshing = true
        DispatchQueue.global(qos: .userInitiated).async {
            method()
            DispatchQueue.main.async {
                table.reloadData()
                self.userIsRefreshing = false
            }
        }
    }
    
    /// Checks the boundaries to know if the pull has been done.
    /// - Parameters:
    ///     - direction: direction in which the pull would be done.
    /// - Returns: Whether the pull has been done.
    private func isWithinThreshold(of direction: Directions) -> Bool {
        let threshold: CGFloat = (direction == .up) ? 50.0 : 10.0
        let thresholdCheck = (direction == .up) ?
            maximumOffset + contentOffset :
            maximumOffset - contentOffset
        
        let withinThreshold = (direction == .up) ?
            (thresholdCheck <= threshold) :
            (thresholdCheck >= threshold)

        return withinThreshold
    }
    
    /// Sets the last direction pulled.
    /// - Parameters:
    ///     - lastDirection: last direction pulled
    func set(lastDirection: CGFloat) {
        self.lastContentOffset = lastDirection
    }
}
