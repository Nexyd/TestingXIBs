//
//  CTCocktailTypeController.swift
//  CocktailTest
//
//  Created by Daniel Morato on 14/12/2018.
//  Copyright © 2018 Daniel Moraleda. All rights reserved.
//

import UIKit

/// Class for the Cocktail type XIB
class CTCocktailTypeView: UIXibView {

    @IBOutlet var typeView: UIView!
    @IBOutlet weak var typesTableView: UITableView!
    @IBOutlet weak var spinner: UIImageView!
    
    /// Base initializer
    /// - Parameters:
    ///     - frame: A CGRect to setup the frame.
    override init(frame: CGRect) {
        super.init(frame: frame)
        super.view = typeView
        super.tableView = typesTableView
    }
    
    /// Initializer from NSCoder
    /// Required from parent
    /// - Parameters:
    ///     - aDecoder: The decoder to be used.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
