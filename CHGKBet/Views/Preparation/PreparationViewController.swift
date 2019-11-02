//
//  PreparationViewController.swift
//  CHGKBet
//
//  Created by ThePsych0 on 01.11.2019.
//  Copyright © 2019 thepsych0. All rights reserved.
//

import UIKit

class PreparationViewController: UIViewController {

    let preparatioPresenter = PreparatioPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        preparatioPresenter.checkUser()
    }
}
