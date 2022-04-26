//
//  RecipeDetailesVC.swift
//  RecipeSearch
//
//  Created by LapStore on 26/04/2022.
//

import UIKit
import SafariServices
class RecipeDetailesVC: BaseWireFrame<RecipeDetailesViewModel> {
    // MARK: - properties
    
    // MARK: - outlets
    @IBOutlet weak var imageOfRecipt: UIImageView!
    @IBOutlet weak var ingredientLinesOfRecipt: UILabel!
    @IBOutlet weak var titelOfRecipt: UILabel!
    // MARK: - bind RecipeDetailes ViewModel
    override func bind(ViewModel: RecipeDetailesViewModel) {
        setupView()
    }
    // MARK: - setup View
    func setupView(){
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "share"), style: .plain, target: self, action: #selector(shareRecipe))
        imageOfRecipt.setImage(with: vieeModel.recipt.image ?? "")
        titelOfRecipt.text = vieeModel.recipt.label
        guard let ingredientLines =  vieeModel.recipt.ingredientLines else {return}
        for (IndexOfingredientLine , ingredientLine) in ingredientLines.enumerated(){
            ingredientLinesOfRecipt.text?.append("\(IndexOfingredientLine + 1) - " + ingredientLine + "\n")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Recipe Details"
    }
    // MARK: - share Recipe
    @objc func shareRecipe(sender : UIButton){
        print("share")
        guard let url = vieeModel.recipt.url else {
            createAlert(alertTite: "Invalid URL", alertMessage: "Invalid publisher URL")
            return
        }
        let UIActivity = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        UIActivity.popoverPresentationController?.sourceView = sender as UIView
        present(UIActivity, animated: true, completion: nil)
    }
    
    // MARK: - IBActions
    @IBAction func reciptWebsite(_ sender: Any) {
        guard let url = vieeModel.recipt.url else {
            createAlert(alertTite: "Invalid URL", alertMessage: "Invalid publisher URL")
            return
        }
        if let url = URL(string: url) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            let vc = SFSafariViewController(url: url, configuration: config)
            title  = ""
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
