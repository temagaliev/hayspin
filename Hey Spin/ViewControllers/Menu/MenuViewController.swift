//
//  MenuViewController.swift
//  Hey Spin
//
//  Created by Artem Galiev on 17.10.2023.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func onPlayButtonClick(_ sender: UIButton) {
        MainRouter.shared.showGameViewScreen()
    }
    
    @IBAction func onTermsButtonClick(_ sender: UIButton) {
        MainRouter.shared.showTermsViewScreen()
    }
}
