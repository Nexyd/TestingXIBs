//
//  CTCocktailCategoriesViewController.swift
//  CocktailTest
//
//  Created by Daniel Moraleda on 19/11/18.
//  Copyright © 2018 Daniel Moraleda. All rights reserved.
//

import UIKit

class CTCocktailCategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var categoryView: CTCocktailCategoriesView!

    private var userIsRefreshing = false
    private let threshold: CGFloat = 50.0
    private var categoryModel: CTCocktailCategoriesModel

    init() {
        self.categoryModel = CTCocktailCategoriesModel()
        super.init(nibName: "CTCocktailCategoriesViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupController()
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
    
    private func setupController() {
        self.setupTable()
    }
    
    private func setupTable() {
        self.categoryView.categoriesTableView.delegate = self
        self.categoryView.categoriesTableView.dataSource = self
    }
    
    private func refreshTable() {
        userIsRefreshing = true
        DispatchQueue.global(qos: .userInitiated).async {
            self.getCocktailCategories()
            DispatchQueue.main.async {
                self.categoryView.categoriesTableView.reloadData()
                self.userIsRefreshing = false
            }
        }
    }
    
    private func checkForCachedCategories() {
        if Archiver.Exists(key: "categories") {
            let categories = Archiver.retrieveElement(forKey: "categories")
            categoryModel.setCategoriesList(catList: categories as? [CTCocktailCategory])
            categoryView.categoriesTableView.reloadData()
        } else {
            getCocktailCategories()
        }
    }
    
    private func getCocktailCategories() {
        CTAPI.getCocktailCategories { [weak self] (success, failure) in
            if let this = self {
                if let catList = success {
                    let sortedCats = catList.getCategoriesList()!.sorted { $0.getCategory() < $1.getCategory() }
                    this.categoryModel.setCategoriesList(catList: sortedCats)
                    this.categoryView.categoriesTableView.reloadData()
                    Archiver.store(element: sortedCats, as: "categories")
                }

                if let error = failure {
                    print("Error: \(error.description)")
                }
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
    
    //MARK: -UIScrollViewDelegate
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let table = categoryView.categoriesTableView
        let contentOffset = table!.contentOffset.y
        let maximumOffset = table!.contentSize.height
            - table!.frame.size.height

        if !userIsRefreshing && (maximumOffset + contentOffset <= threshold) {
            refreshTable()
        }
    }
}
