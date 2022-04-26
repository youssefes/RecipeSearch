//
//  RecipeSearchVC.swift
//  RecipeSearch
//
//  Created by LapStore on 22/04/2022.
//

import UIKit
import RxSwift
import RxCocoa
class RecipeSearchVC: BaseWireFrame<RecipeSearchViewModel> {
    
    //MARK: - properties
    private var healthyCellIdentifier = "HealthlebalCollectionViewCell"
    private var recipeResulteTableCellIdentifier = "ResulteTableViewCell"
    private var selectedHealthyLables : [String] = []
    //MARK: - outlets
    @IBOutlet weak var noDateLbl: UILabel!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var searchTf: UITextField!
    @IBOutlet weak var healthLableCollectionView: UICollectionView!
    
    @IBOutlet weak var recipeSearchTable: UITableView!
    
    func setUpView(){
        title = "Recipe search"
        searchTf.delegate = self
        //MARK: - setUp health collection view
        //        healthLableCollectionView.allowsMultipleSelection = true
        healthLableCollectionView.rx.setDelegate(self).disposed(by: disposePag)
        healthLableCollectionView.register(UINib(nibName: healthyCellIdentifier, bundle: nil), forCellWithReuseIdentifier: healthyCellIdentifier)
        //MARK: - setUp Recipe Search Table
        recipeSearchTable.rx.setDelegate(self).disposed(by: disposePag)
        recipeSearchTable.register(UINib(nibName: recipeResulteTableCellIdentifier, bundle: nil), forCellReuseIdentifier: recipeResulteTableCellIdentifier)
        
    }
    
    //MARK: - bind view model
    override func bind(ViewModel: RecipeSearchViewModel) {
        setUpView()
        //MARK: - bind health labels Options
        ViewModel.healthOptions.bind(to: healthLableCollectionView.rx.items(cellIdentifier: healthyCellIdentifier, cellType: HealthlebalCollectionViewCell.self)){ (row , item , cell) in
            cell.nameOHelthyLbl.text = item
        }.disposed(by: disposePag)
        healthLableCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .left)
        //MARK: - subscribe retulte of search
        ViewModel.recipeResulteOfSearch.subscribe(onNext: { [weak self] recipeResulte in
            guard let self = self else {return}
            if recipeResulte.isEmpty {
                print("no date")
                self.indicatorView.stopAnimating()
                self.noDateLbl.isHidden = false
            }else{
                self.noDateLbl.isHidden = true
                if recipeResulte.count > 10 {
                    let lest10Element = Array(recipeResulte.suffix(10))
                    self.vieeModel.saveLeastResulte(arrayOfRecipt: lest10Element)
                }else{
                    self.vieeModel  .saveLeastResulte(arrayOfRecipt: recipeResulte)
                }
            }
        },onError: { [weak self] error in
            guard let self = self else {return}
            self.indicatorView.stopAnimating()
            self.createAlert(alertTite: "Error", alertMessage: error.localizedDescription)
        }).disposed(by: disposePag)
        
        //MARK: - bind retulte of search
        ViewModel.recipeResulteOfSearch.bind(to: recipeSearchTable.rx.items(cellIdentifier: recipeResulteTableCellIdentifier, cellType: ResulteTableViewCell.self)){ [weak self] (row , item , cell) in
            self?.indicatorView.stopAnimating()
            cell.selectionStyle = .none
            cell.titeOfRecipe.text = item.recipe?.label
            cell.sourceOfRecipe.text = item.recipe?.source
            cell.healthyLabelsOfRecipe.text = item.recipe?.healthLabels?.joined(separator: "-")
            cell.imageoFRecipe.setImage(with: item.recipe?.image ?? "")
        }.disposed(by: disposePag)
        
        //MARK: - selected retulte of search
        Observable.zip(recipeSearchTable.rx.itemSelected,recipeSearchTable.rx.modelSelected(Hits.self))
            .bind{ indexPath, model in
                guard let recipe = model.recipe else {return}
                print(recipe.label)
                //                let SelectedExploreVc = self.coordinator.mainNavigator.viewController(for: .SelectedExplorVC(brands: brands, catId: model.catID ?? "0"))
            }.disposed(by: disposePag)
        
        //MARK: - selected healthy labels
        Observable.zip(healthLableCollectionView.rx.itemSelected,healthLableCollectionView.rx.modelSelected(String.self))
            .bind{ [weak self] (indexPath, healthyLable) in
                
                guard let self = self else {return}
                self.selectedHealthyLables.append(healthyLable)
                if indexPath.row == 0 {
                    self.selectedHealthyLables.removeAll()
                }
                if let searchWords = self.searchTf.text , !searchWords.isEmpty{
                    self.indicatorView.startAnimating()
                    self.vieeModel.getRecipeSearch(quary: searchWords, health:  self.selectedHealthyLables)
                }
            }.disposed(by: disposePag)
        
        //MARK: - Deselected healthy labels
        Observable.zip(healthLableCollectionView.rx.itemDeselected,healthLableCollectionView.rx.modelDeselected(String.self))
            .bind{[weak self] (indexPath, healthyLable) in
                print(healthyLable)
                guard let self = self else {return}
                for (indexOf , healthyLableDeSelected) in self.selectedHealthyLables.enumerated(){
                    print(healthyLableDeSelected)
                    if healthyLable == healthyLableDeSelected {
                        self.selectedHealthyLables.remove(at: indexOf)
                        if let searchWords = self.searchTf.text , !searchWords.isEmpty{
                            self.indicatorView.startAnimating()
                            self.vieeModel.getRecipeSearch(quary: searchWords, health:  self.selectedHealthyLables)
                        }
                        return
                    }
                }
            }.disposed(by: disposePag)
    }
    
}

//MARK: - conform collection viwe deleget
extension RecipeSearchVC: UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 150, height: 40)
    }
}


//MARK: - conform tableview viwe deleget
extension RecipeSearchVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
//MARK: - conform search TextField Delegate
extension RecipeSearchVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let wordsToSearch = textField.text else {return false}
        indicatorView.startAnimating()
        vieeModel.getRecipeSearch(quary: wordsToSearch, health: selectedHealthyLables)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        vieeModel.getLeastResulteSave()
    }
}
