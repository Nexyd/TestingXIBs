//
//  CTCocktailCategoriesViewController.swift
//  CocktailTest
//
//  Created by Daniel Moraleda on 19/11/18.
//  Copyright © 2018 Daniel Moraleda. All rights reserved.
//

import UIKit
import SwiftGifOrigin

/// ViewController associated with CTCocktailTypeView
class CTCocktailCategoriesViewController: UIViewController,
    UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var categoryView: CTCocktailCategoriesView!
    private var categoryModel:  CTCocktailCategoriesModel
    private var refreshControl: UIRefreshControl
 
    /// Initializes the controller with a filter.
    /// - Parameters:
    ///     - filter: the selected cocktail type.
    init() {
        self.categoryModel = CTCocktailCategoriesModel()
        self.refreshControl = UIRefreshControl()
        super.init(nibName: "CTCocktailCategoriesViewController", bundle: nil)
    }
    
    /// Initializer from NSCoder
    /// Required from parent
    /// - Parameters:
    ///     - aDecoder: The decoder to be used.
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTable()

        self.categoryView.spinner.image = UIImage.gif(name: "spinner")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.checkForCachedCategories()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: -Private Funcs
    
    /// Sets up the connection with the table view
    private func setupTable() {
        self.categoryView.categoriesTableView.delegate = self
        self.categoryView.categoriesTableView.dataSource = self
        
        self.setupRefreshControl()
    }
    
    /// Sets up the refresh control data
    private func setupRefreshControl() {
        if #available(iOS 10.0, *) {
            self.categoryView.categoriesTableView.refreshControl = refreshControl
        } else {
            self.categoryView.categoriesTableView.addSubview(refreshControl)
        }
        
        refreshControl.tintColor = UIColor(red: 0.25,
            green: 0.72, blue: 0.85, alpha: 1.0)

        refreshControl.attributedTitle = NSAttributedString(
            string: "Fetching Drinks List...")
        
        refreshControl.addTarget(self, action: #selector(
            getCocktailCategories(_:)), for: .valueChanged)
    }
    
    /// Checks the UserDefaults store for existing cocktail categories.
    private func checkForCachedCategories() {
        if Archiver.Exists(key: "categories") {
            let categories = Archiver.retrieveElement(forKey: "categories")
            categoryModel.setCategoriesList(catList: categories as? [CTCocktailCategory])
            categoryView.categoriesTableView.reloadData()
        } else {
            getCocktailCategories(self)
        }
    }
    
    /// Retrieves all filtered drinks from the web service.
    @objc private func getCocktailCategories(_ sender: Any) {
        DispatchQueue.global(qos: .userInitiated).async {
            CTAPI.getCocktailCategories { [weak self] (success, failure) in
                if let this = self {
                    if let catList = success {
                        let sortedCats = catList.getCategoriesList()!.sorted {
                            $0.getCategory() < $1.getCategory()
                        }

                        this.categoryModel.setCategoriesList(catList: sortedCats)
                        this.categoryView.categoriesTableView.reloadData()
                        Archiver.store(element: sortedCats, as: "categories")
                    }

                    if let error = failure {
                        print("Error: \(error.description)")
                    }
                }
            }
            
            DispatchQueue.main.async {
                self.categoryView.categoriesTableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    //MARK: -UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categoryModel.getCategoriesListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cellId")
        cell.textLabel?.text = self.categoryModel.getCategoryForIndex(indexPath.row)?.getCategory()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let value = categoryModel.getCategoryForIndex(indexPath.row)?.getCategory()
        let targetVC = CTCocktailTypeListViewController(filter: value!)
        super.navigationController!.pushViewController(targetVC, animated: true)
    }
}
