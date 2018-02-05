//
//  AddCityModalViewController.swift
//  Dont Get Cold
//
//  Created by Hovig Kousherian on 2/3/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import UIKit

class AddCityModalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addBlur(withStyle: .dark)
    }
    
    //MARK: Actions
    @IBAction func dismissButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
