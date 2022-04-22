//
//  BaseWireFrame.swift
//  Opportunities
//
//  Created by youssef on 3/13/20.
//  Copyright © 2020 youssef. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire
class BaseWireFrame <T>: UIViewController {
    
    var vieeModel : T!
    var coordinator : Coordinator!
   
    lazy var disposePag : DisposeBag = {
        return DisposeBag()
    }()
    
    // MARK: -  init
    init(ViewModel : T, coordinator : Coordinator) {
        self.vieeModel = ViewModel
        self.coordinator = coordinator
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    // MARK: -  viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(ViewModel: vieeModel)
       
    }
    // MARK: -  viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    // MARK: -  viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func bind(ViewModel : T) {
        fatalError("please Override the bind Function")
      
    }
}
