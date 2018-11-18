//
//  ViewController.swift
//  Football League
//
//  Created by Arabia-IT on 11/18/18.
//  Copyright © 2018 Arabia-IT. All rights reserved.
//

import UIKit

protocol LeagesView: class  {
    func updateData()
}

class LeuguesViewController: UIViewController {
private var presenter = DefaultLeaguesPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attach(view: self)
        presenter.viewDidLoad()
    }
}

extension LeuguesViewController: LeagesView {
    func updateData() {
        print("data updated successfully")
    }
    
}

