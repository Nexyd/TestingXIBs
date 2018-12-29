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

    private var spinner: UIImageView?
    private var userDirection: Direction
    private var contentOffset: CGFloat
    private var minimumOffset: CGFloat
    private var maximumOffset: CGFloat

    /// Base initializer
    init() {
        self.userDirection = .up
        self.contentOffset = 0.0
        self.minimumOffset = 0.0
        self.maximumOffset = 0.0
    }

    /// Enumeration of the possible directions to pull.
    enum Direction {
        case up
        case down
    }

    /// Validates the pull with boundaries before refresh.
    /// - Parameters:
    ///     - direction: Direction in which the user pulled.
    ///     - table: Table which is going to be refreshed.
    ///     - method: Method to be called upon refresh.
    func validatePullRefresh(withDirection directionAllowed: Direction,
        for table: UITableView, with method: @escaping () -> Void)
    {
        maximumOffset = table.contentSize.height - table.frame.size.height

        // If the direction in which the user pulled, is the same that the direction
        // we want the pull to be done, we can proceed.
        if userDirection == directionAllowed && checkOffset() {
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
        self.spinner?.isHidden = false
        DispatchQueue.global(qos: .userInitiated).async {
            method()
            DispatchQueue.main.async {
                table.reloadData()
                self.spinner?.isHidden = true
            }
        }
    }
    
    private func checkOffset() -> Bool {
        // If we've pulled up and have reached the top of the table or
        // pulled down and reached the bottom, we can proceed.
        return (userDirection == .up   && contentOffset < minimumOffset)
            || (userDirection == .down && contentOffset > maximumOffset)
    }
    
    /// Sets the direction in which the user pulled.
    /// - Parameters:
    ///     - direction: direction pulled
    func set(direction: Direction) {
        self.userDirection = direction
    }

    /// Sets the content offset reached upon pull's end.
    /// - Parameters:
    ///     - spinner: Content offset reached.
    func set(offset: CGFloat) {
        self.contentOffset = offset
    }


    /// Sets the spinner used in the refresh.
    /// - Parameters:
    ///     - spinner: Spinner to be used
    func set(spinner: UIImageView) {
        self.spinner = spinner
    }
}
