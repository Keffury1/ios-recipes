//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Bobby Keffury on 9/4/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {

    // MARK: - Properties
    
    private var recipes: [Recipe] = [] {
        didSet {
            reloadInputViews()
        }
    }
 
    
    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath)
        
        let recipe = recipes[indexPath.row]
        cell.textLabel?.text = recipe.name
       

        return cell
    }
    

  
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailViewControllerSegue" {
            if let recipeDetailVC = segue.destination as? RecipeDetailViewController {
                // NEED TO FIGURE OUT HOW TO GET THE SPECIFIC RECIPE THAT WAS TAPPED
                recipeDetailVC.recipe = recipes[0]
            }
        }
    }
    

}
