//
//  GameViewController.swift
//  Hey Spin
//
//  Created by Artem Galiev on 17.10.2023.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var frutOneButton: UIButton!
    @IBOutlet weak var frutTwoButton: UIButton!
    @IBOutlet weak var frutThreeButton: UIButton!
    @IBOutlet weak var frutFourButton: UIButton!
    @IBOutlet weak var frutFiveButton: UIButton!
    @IBOutlet weak var frutSixButton: UIButton!
    
    @IBOutlet weak var buttonStack: UIStackView!
    @IBOutlet weak var gameStackView: UIStackView!
    @IBOutlet weak var timeImage: UIImageView!
    
    let fruits = Fruits()
    
    var valueFruit: Int = 3
    var timeGame: Int = 3
    
    var answerUser: String = ""
    var correctAnswer: String = ""
    var level: Int = 1
    
    var arrayView: [UIImageView] = []
    var arrayButton: [UIButton] = []
    
    var timerGame = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        levelComplexity()
        startGame(maxFruit: valueFruit)
    }
    
    //MARK: - StartGame
    private func startGame(maxFruit: Int) {
        hiddenButton()
        answerUser = ""
        correctAnswer = ""
        timeImage.isHidden = false

        if timeGame == 3 {
            timeImage.image = UIImage(named: NameImage.numberThree.rawValue)
        } else if timeGame == 5 {
            timeImage.image = UIImage(named: NameImage.numberFive.rawValue)
        } else if timeGame == 4 {
            timeImage.image = UIImage(named: NameImage.numberFour.rawValue)
        }
        
        for _ in 1...valueFruit {
            let random = Int.random(in: 1...6)
//            if i == 1 {
//                let imageView = UIView()
//                imageView.translatesAutoresizingMaskIntoConstraints = false
//                imageView.widthAnchor.constraint(greaterThanOrEqualToConstant: 1).isActive = true
//                gameStackView.addArrangedSubview(imageView)
//            }
            for fruit in fruits.fruitsList {
                if fruit.id == random {
                    let imageView = UIImageView(image: UIImage(named: fruit.nameImage))
                    imageView.translatesAutoresizingMaskIntoConstraints = false
                    gameStackView.addArrangedSubview(imageView)
                    imageView.widthAnchor.constraint(lessThanOrEqualToConstant: 44).isActive = true
                    imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.0/1.0).isActive = true
                    
                    arrayView.append(imageView)
                    correctAnswer = correctAnswer + String(fruit.id)
                    
                    for button in arrayButton {
                        if fruit.id == button.tag {
                            button.isHidden = false
                        }
                    }
                }
            }
//            if i == valueFruit {
//                let imageView = UIView()
//                imageView.translatesAutoresizingMaskIntoConstraints = false
//                imageView.widthAnchor.constraint(greaterThanOrEqualToConstant: 1).isActive = true
//                gameStackView.addArrangedSubview(imageView)
//            }
        }
        startLevelTimer()
    }
    
    func startLevelTimer() {
        timerGame = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(levelCountdown), userInfo: nil, repeats: true)
    }
    
    @objc func levelCountdown() {
        switch timeGame {
        case 5:
            timeImage.image = UIImage(named: NameImage.numberFive.rawValue)
        case 4:
            timeImage.image = UIImage(named: NameImage.numberFour.rawValue)
        case 3:
            timeImage.image = UIImage(named: NameImage.numberThree.rawValue)
        case 2:
            timeImage.image = UIImage(named: NameImage.numberTwo.rawValue)
        case 1:
            timeImage.image = UIImage(named: NameImage.numberOne.rawValue)
        case 0:
            timeImage.image = UIImage(named: NameImage.numberZero.rawValue)
        default:
            timeImage.image = UIImage(named: NameImage.numberThree.rawValue)
        }
        timeGame = timeGame - 1
        
        if timeGame == -1 {
            timeImage.isHidden = true
            for image in arrayView {
                image.removeFromSuperview()
            }
            arrayView = []
            buttonStack.isHidden = false
            timerGame.invalidate()
        }
    }
    
    private func hiddenButton() {
        arrayButton.append(frutOneButton)
        arrayButton.append(frutTwoButton)
        arrayButton.append(frutThreeButton)
        arrayButton.append(frutFourButton)
        arrayButton.append(frutFiveButton)
        arrayButton.append(frutSixButton)

        for button in arrayButton {
            button.isHidden = true
        }
        
        buttonStack.isHidden = true
    }
    
    
    //MARK: - onFructButtonClick
    @IBAction func onFructButtonClick(_ sender: UIButton) {
        for fruit in fruits.fruitsList {
            if sender.tag == fruit.id {
                let imageView = UIImageView(image: UIImage(named: fruit.nameImage))
                imageView.translatesAutoresizingMaskIntoConstraints = false
                gameStackView.addArrangedSubview(imageView)
                imageView.widthAnchor.constraint(lessThanOrEqualToConstant: 44).isActive = true
                imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.0/1.0).isActive = true
                
                arrayView.append(imageView)

            }
        }
        
        answerUser = answerUser + String(sender.tag)
        if answerUser.count == correctAnswer.count {
            if answerUser == correctAnswer {
                level = level + 1
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: { [weak self] in
                    guard let self = self else { return }
                    MainRouter.shared.showWinViewScreen(isWin: true)
                    for image in self.arrayView {
                        image.removeFromSuperview()
                    }
                    self.arrayView = []
                })
            } else {
                level = 1
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: { [weak self] in
                    guard let self = self else { return }
                    MainRouter.shared.showWinViewScreen(isWin: false)
                    for image in self.arrayView {
                        image.removeFromSuperview()
                    }
                    self.arrayView = []
                })
            }
        }
        
    }
    
    //MARK: - onCloseButtonClick
    @IBAction func onCloseButtonClick(_ sender: UIButton) {
        MainRouter.shared.closeGameViewScreen()
    }
}

//MARK: - Level complexity generation
extension GameViewController {
    private func levelComplexity() {
        switch level {
        case 1:
            valueFruit = 3
            timeGame = 3
        case 2:
            valueFruit = 4
            timeGame = 5
        case 3:
            valueFruit = 4
            timeGame = 4
        case 4:
            valueFruit = 4
            timeGame = 3
        case 5:
            valueFruit = 5
            timeGame = 5
        case 6:
            valueFruit = 5
            timeGame = 4
        case 7:
            valueFruit = 5
            timeGame = 3
        case 8:
            valueFruit = 6
            timeGame = 5
        case 9:
            valueFruit = 6
            timeGame = 4
        case 10:
            valueFruit = 6
            timeGame = 3
        case 11:
            valueFruit = 7
            timeGame = 5
        case 12:
            valueFruit = 7
            timeGame = 4
        case 13:
            valueFruit = 7
            timeGame = 3
        case 14:
            valueFruit = 8
            timeGame = 5
        case 15:
            valueFruit = 8
            timeGame = 4
        case 16:
            valueFruit = 8
            timeGame = 3
        case 17:
            valueFruit = 9
            timeGame = 5
        case 18:
            valueFruit = 9
            timeGame = 4
        case 19:
            valueFruit = 9
            timeGame = 3
        case 20:
            valueFruit = 10
            timeGame = 5
        case 21:
            valueFruit = 10
            timeGame = 4
        case 22:
            valueFruit = 10
            timeGame = 3
        case 23:
            valueFruit = 11
            timeGame = 5
        case 24:
            valueFruit = 11
            timeGame = 4
        case 25:
            valueFruit = 11
            timeGame = 3
        case 26:
            valueFruit = 12
            timeGame = 5
        case 27:
            valueFruit = 12
            timeGame = 4
        case 28:
            valueFruit = 12
            timeGame = 3
        case 29:
            valueFruit = 13
            timeGame = 5
        case 30:
            valueFruit = 13
            timeGame = 4
        case 31:
            valueFruit = 13
            timeGame = 3
        case 32:
            valueFruit = 14
            timeGame = 5
        case 33:
            valueFruit = 14
            timeGame = 4
        case 34:
            valueFruit = 14
            timeGame = 3
        case 35:
            valueFruit = 15
            timeGame = 5
        case 36:
            valueFruit = 15
            timeGame = 4
        case 37:
            valueFruit = 15
            timeGame = 3
        case 38:
            valueFruit = 16
            timeGame = 4
        case 39:
            valueFruit = 16
            timeGame = 3
        case 40:
            valueFruit = 16
            timeGame = 2
        case 41...1000:
            valueFruit = level - 20
            timeGame = 2
        default:
            valueFruit = 3
            timeGame = 3
        }
    }
}
