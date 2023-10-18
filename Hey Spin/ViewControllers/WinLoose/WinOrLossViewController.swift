//
//  WinOrLossViewController.swift
//  Hey Spin
//
//  Created by Artem Galiev on 17.10.2023.
//

import UIKit

class WinOrLossViewController: UIViewController {
    
    @IBOutlet weak var bgView: UIImageView!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var resultView: UIImageView!
    
    var isWin: Bool

    init(isWin: Bool) {
        self.isWin = isWin
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        switch isWin {
        case true:
            bgView.image = UIImage(named: NameImage.winBg.rawValue)
            resultView.image = UIImage(named: NameImage.winView.rawValue)
            restartButton.setImage(UIImage(named: NameImage.nextButton.rawValue), for: .normal)
        case false:
            bgView.image = UIImage(named: NameImage.bg.rawValue)
            resultView.image = UIImage(named: NameImage.looseView.rawValue)
            restartButton.setImage(UIImage(named: NameImage.restartButton.rawValue), for: .normal)
        }

    }
    
    @IBAction func onMenuButtonClick(_ sender: UIButton) {
        MainRouter.shared.showMenuViewScreen()
        
    }
    
    @IBAction func onRestartButtonClick(_ sender: UIButton) {
        MainRouter.shared.closeWinViewScreen()
    }
    
}
