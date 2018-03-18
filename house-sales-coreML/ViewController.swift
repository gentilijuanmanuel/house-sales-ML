//
//  ViewController.swift
//  house-sales-coreML
//
//  Created by Juan Manuel Gentili on 17/3/18.
//  Copyright © 2018 Juan Manuel Gentili. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var bedrooms: Int = 0
    var bathrooms: Int = 0
    var size: Int = 0
    
    @IBOutlet weak var bedroomsLabel: UILabel!
    @IBOutlet weak var bathroomsLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    
    @IBOutlet weak var predictButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var bedroomsSlider: UISlider!
    @IBOutlet weak var bathroomsSlider: UISlider!
    @IBOutlet weak var sizeSlider: UISlider!
    
    @IBAction func changeValue(_ sender: UISlider) {
        setChanges()
    }
    
    
    @IBAction func predict(_ sender: UIButton) {
        let price = predictPriceOfHouse(bathrooms: Double(bathrooms), bedrooms: Double(bedrooms), size: Double(size))
        if price > 0 {
            resultLabel.text = "El precio rondará los USD \(Int(price))."
        } else {
            resultLabel.text = "El sistema no pudo predecir buenos resultados 😔"
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setChanges()
    }
    
    func predictPriceOfHouse(bathrooms: Double, bedrooms: Double, size: Double) -> Double {
        let houseSales = HouseSalesInCalifornia()
        guard let price = try? houseSales.prediction(Bedrooms: bedrooms, Bathrooms: bathrooms, Size: size) else {
            print("Se produjo un error.")
            return 0.0
        }
        print(price.Price)
        return price.Price
    }
    
    func setChanges() {
        predictButton.layer.cornerRadius = 5
        bedrooms = Int(bedroomsSlider.value)
        bathrooms = Int(bathroomsSlider.value)
        size = Int(sizeSlider.value)
        
        bedroomsLabel.text = "\(bedrooms) habitaciones"
        bathroomsLabel.text = "\(bathrooms) baños"
        sizeLabel.text = "\(size) pies cuadrados"
    }
}

