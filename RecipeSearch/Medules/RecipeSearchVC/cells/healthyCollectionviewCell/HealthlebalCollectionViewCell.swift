//
//  HealthlebalCollectionViewCell.swift
//  RecipeSearch
//
//  Created by LapStore on 25/04/2022.
//

import UIKit

class HealthlebalCollectionViewCell: UICollectionViewCell {
// MARK: - properties
    @IBOutlet weak var nameOHelthyLbl : UILabel!
    
    // MARK: - cell life cycel
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override var isSelected: Bool{
        didSet{
            if isSelected{
                nameOHelthyLbl.backgroundColor = UIColor.RecipeSearchUIColor.appColor
                nameOHelthyLbl.textColor = .white
                nameOHelthyLbl.borderColor = .clear
            }else{
                nameOHelthyLbl.backgroundColor = .clear
                nameOHelthyLbl.textColor = .black
                nameOHelthyLbl.borderColor = .black.withAlphaComponent(0.5)
                nameOHelthyLbl.borderWidth = 1
            }
            
        }
    }
    
}
