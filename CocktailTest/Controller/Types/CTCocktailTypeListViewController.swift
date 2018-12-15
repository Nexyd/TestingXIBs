//
//  CTCocktailTypeListViewController.swift
//  CocktailTest
//
//  Created by Daniel Morato on 15/12/2018.
//  Copyright © 2018 Daniel Moraleda. All rights reserved.
//

import UIKit

class CTCocktailTypeListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var typeView: CTCocktailTypeView!
    
    private let typesModel: CTCocktailTypeModel
    private var filter: String
    
    init(filter: String) {
        self.filter = filter
        self.typesModel = CTCocktailTypeModel()
        super.init(nibName: "CTCocktailTypesViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.typeView.typesTableView.dataSource = self
        self.typeView.typesTableView.delegate   = self

        let bundle = Bundle(for: type(of: self))
        let customCell = UINib(nibName: "CustomTableViewCell", bundle: bundle)
        self.typeView.typesTableView.register(customCell,
            forCellReuseIdentifier: "CustomTableViewCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.global(qos: .userInitiated).async {
            self.getDrinks()
            DispatchQueue.main.async {
                self.typeView.typesTableView.reloadData()
            }
        }
    }
    
    private func getDrinks() {
        CTAPI.getDrinks(filter: "filter.php", args: ["c":self.filter]) {
            [weak self] (success, failure) in

            if let this = self {
                if let typesList = success {
                    let sortedTypes = typesList.getDrinks()!.sorted { $0.getDrink() < $1.getDrink() }
                    this.typesModel.setTypeList(typeList: sortedTypes)
                    this.typeView.typesTableView.reloadData()
                }

                if let error = failure {
                    print("Error: \(error.description)")
                }
            }
        }
    }
    
    //MARK: -UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.typesModel.getTypeListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .default, reuseIdentifier: "cellId")
//        cell.textLabel?.text = self.typesModel.getTypeForIndex(indexPath.row)?.getDrink()

        let cell = self.typeView.typesTableView.dequeueReusableCell(
            withIdentifier: "CustomTableViewCell") as! CustomTableViewCell

        cell.name.text = self.typesModel.getTypeForIndex(indexPath.row)?.getDrink()
        let imageUrl = self.typesModel.getTypeForIndex(indexPath.row)?.getDrinkThumb()
        let url = URL(string: imageUrl!)

        DispatchQueue.global(qos: .userInitiated).async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                cell.drinkThumb.image = UIImage(data: data!)
            }
        }
        
        return cell
    }
}
