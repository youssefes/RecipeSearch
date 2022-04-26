//
//  ResulteTableViewCell.swift
//  RecipeSearch
//
//  Created by LapStore on 25/04/2022.
//

import UIKit
import SwiftUI

class ResulteTableViewCell: UITableViewCell {

   // MARK: -  Outlet
    @IBOutlet weak var healthyLabelsOfRecipe: UILabel!
    @IBOutlet weak var sourceOfRecipe: UILabel!
    @IBOutlet weak var titeOfRecipe: UILabel!
    @IBOutlet weak var imageoFRecipe: UIImageView!
    // MARK: -  cell life cycel
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
