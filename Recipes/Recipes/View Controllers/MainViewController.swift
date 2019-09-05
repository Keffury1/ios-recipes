//
//  MainViewController.swift
//  Recipes
//
//  Created by Bobby Keffury on 9/4/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var searchTextField: UITextField!
    
    // MARK: - Properties
    
    let networkClient = RecipesNetworkClient()
    
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = self.filteredRecipes
        }
    }
    
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = self.filteredRecipes
        }
    }
    
    
    // MARK: - View

    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                print("Error loading recipes: \(error)")
                return
            }
            
            DispatchQueue.main.async {
                self.allRecipes = recipes ?? []
            }
        }

    }
    
    // MARK: - Methods
    
    func filterRecipes() {
        guard let searchTerm = searchTextField.text, searchTextField != nil else {
            filteredRecipes = allRecipes
            return
        }
        
        filteredRecipes = allRecipes.filter { (recipe) -> Bool in
            return recipe.name == searchTerm
        }
        
        filteredRecipes = allRecipes.filter { (recipe) -> Bool in
            return recipe.instructions == searchTerm
        }
        
    }

    
     // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TableViewControllerEmbedSegue" {
            if let tableVC = segue.destination as? RecipesTableViewController {
                self.recipesTableViewController = tableVC
            }
        }
    }
    
    
    // MARK: - Actions
    
    @IBAction func searchTextField(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    

}

