//
//  CTCocktailCategoriesView.swift
//  CocktailTest
//
//  Created by Daniel Moraleda on 19/11/18.
//  Copyright © 2018 Daniel Moraleda. All rights reserved.
//

import UIKit

/// Class for the Cocktail category XIB
class CTCocktailCategoriesView: UIXibView {

    @IBOutlet var categoriesView: UIView!
    @IBOutlet weak var categoriesTableView: UITableView!
    @IBOutlet weak var spinner: UIImageView!
    
    /// Base initializer
    /// - Parameters:
    ///     - frame: A CGRect to setup the frame.
    override init(frame: CGRect) {
        super.init(frame: frame)
        super.view = categoriesView
        super.tableView = categoriesTableView
    }
    
    /// Initializer from NSCoder
    /// Required from parent
    /// - Parameters:
    ///     - aDecoder: The decoder to be used.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
