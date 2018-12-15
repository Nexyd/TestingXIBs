//
//  CTCocktailTypeController.swift
//  CocktailTest
//
//  Created by Daniel Morato on 14/12/2018.
//  Copyright © 2018 Daniel Moraleda. All rights reserved.
//

import UIKit

class CTCocktailTypeView: UIXibView {

    @IBOutlet var typeView: UIView!
    @IBOutlet weak var typesTableView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        super.view = typeView
        super.tableView = typesTableView
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
