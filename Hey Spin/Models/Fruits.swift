//
//  Fruits.swift
//  Hey Spin
//
//  Created by Artem Galiev on 17.10.2023.
//

import Foundation

struct Fruit {
    let id: Int
    let nameImage: String
}

struct Fruits {
    let fruitsList: [Fruit] = [Fruit(id: 1, nameImage: NameImage.frutOne.rawValue),
                               Fruit(id: 2, nameImage: NameImage.frunTwo.rawValue),
                               Fruit(id: 3, nameImage: NameImage.frutThree.rawValue),
                               Fruit(id: 4, nameImage: NameImage.frutFour.rawValue),
                               Fruit(id: 5, nameImage: NameImage.frutFive.rawValue),
                               Fruit(id: 6, nameImage: NameImage.frutSix.rawValue)]
}
