//
//  ViewController.swift
//  WeatherApp
//
//  Created by Vishal Patel on 26/10/23.
//

import UIKit
import CoreLocation
import MapKit


class SelectCityVC: UIViewController {
    
    // Label
    @IBOutlet weak var txtCity: UITextField!
    
    // Other
    var onComplete: ((_ city: String)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: - Action Method
extension SelectCityVC {
    
    @IBAction func didTapCancel(_ sender: UIButton) {
        self.view.endEditing(true)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapSubmit(_ sender: UIButton) {
        self.view.endEditing(true)
        
        if trim(txtCity.text!).isEmpty {
            showAlert(msg: "Please enter your city name")
            return
        }
        
        onComplete?(txtCity.text!)
        
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - Private Helper Method
extension SelectCityVC {
    
    private func trim(_ msg: String) -> String {
        return msg.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    private func showAlert(msg: String) {
        let alertController = UIAlertController(
            title: "Alert",
            message: msg,
            preferredStyle: .alert
        )
        
        // Create an action button for the alert
        let okAction = UIAlertAction(
            title: "OK",
            style: .default,
            handler: { _ in }
        )
        
        // Add the action button to the alert
        alertController.addAction(okAction)
        
        // Present the alert
        present(alertController, animated: true, completion: nil)
    }
}


