//
//  CTCocktailCategoriesView.swift
//  CocktailTest
//
//  Created by Daniel Moraleda on 19/11/18.
//  Copyright © 2018 Daniel Moraleda. All rights reserved.
//

import UIKit

class CTCocktailCategoriesView: UIXibView {

    @IBOutlet var categoriesView: UIView!
    @IBOutlet weak var categoriesTableView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        super.view = categoriesView
        super.tableView = categoriesTableView
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
