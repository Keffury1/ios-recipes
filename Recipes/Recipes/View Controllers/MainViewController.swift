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
    
    private let networkClient = RecipesNetworkClient()
    
    private var allRecipes: [Recipe] = []
    
    private var recipesTableViewController: RecipesTableViewController?
    
    private var filteredRecipes: [Recipe] = []
    
    
    // MARK: - View

    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkClient.fetchRecipes { (recipes, error) in
            // NOT SURE IF I DID THIS RIGHT
            if error != nil {
                NSLog("Error loading recipe data: \(String(describing: error))")
                return
            } else {
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
        
        allRecipes.filter { (recipe) -> Bool in
            return recipe.name == searchTerm
        }
        
        allRecipes.filter { (recipe) -> Bool in
            return recipe.instructions == searchTerm
        }
    }

    
    // MARK: - Navigation

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "TableViewControllerEmbedSegue" {
//            let tableVC = segue.destination as? RecipesTableViewController {
//                // NEED TO SET THE SUBCLASS?
//            }
//        }
//    }
    
    
    // MARK: - Actions
    
    @IBAction func searchTextField(_ sender: Any) {
        
    }
    

}

