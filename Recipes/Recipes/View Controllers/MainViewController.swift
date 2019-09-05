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
    
    var recipesTableViewController: RecipesTableViewController? 
    
    
    
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = self.filteredRecipes
            recipesTableViewController?.tableView.reloadData()
        }
    }
    
    
    // MARK: - View

    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error loading students: \(error)")
                return
            }
           
            self.allRecipes = recipes ?? []
            
        }

    }
    
    // MARK: - Methods
    
    func filterRecipes() {
        DispatchQueue.main.async {
            
            guard let enteredText = self.searchTextField.text,
                !enteredText.isEmpty else {
                    self.filteredRecipes = self.allRecipes
                    return }
            
            self.filteredRecipes = self.allRecipes.filter { ($0.name.range(of: enteredText, options: .caseInsensitive) != nil) || ($0.instructions.range(of: enteredText, options: .caseInsensitive) != nil)}
            
            
        }
        
    }

    
     // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TableViewControllerEmbedSegue" {
            if let tableVC = segue.destination as? RecipesTableViewController {
                recipesTableViewController = tableVC
               
            }
        }
    }
    
    
    // MARK: - Actions
    
    @IBAction func searchTextField(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    

}

