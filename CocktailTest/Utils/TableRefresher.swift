//
//  TableRefresher.swift
//  CocktailTest
//
//  Created by Daniel Morato on 14/12/2018.
//  Copyright © 2018 Daniel Moraleda. All rights reserved.
//

import Foundation
import UIKit

class TableRefresher {
    private var userIsRefreshing = false
    private let threshold: CGFloat = 50.0

    func performPullRefresh(onView table: UITableView, for method: ()) {
        let contentOffset = table.contentOffset.y
        let maximumOffset = table.contentSize.height
            - table.frame.size.height

        if !userIsRefreshing && (maximumOffset + contentOffset <= threshold) {
            refresh(table: table, for: method)
        }
    }

    private func refresh(table: UITableView, for method: ()) {
        userIsRefreshing = true
        DispatchQueue.global(qos: .userInitiated).async {
            //method()
            DispatchQueue.main.async {
                table.reloadData()
                self.userIsRefreshing = false
            }
        }
    }
}
