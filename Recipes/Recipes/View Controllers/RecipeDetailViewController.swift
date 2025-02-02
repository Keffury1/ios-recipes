//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Bobby Keffury on 9/4/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var recipeTextView: UITextView!
    
    // MARK: - Properties
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    
    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
        
    }
    
    // MARK: - Methods
    
    func updateViews() {
        if let recipe = recipe, self.isViewLoaded {
            titleLabel.text = recipe.name
            recipeTextView.text = recipe.instructions
        }
    }

}
