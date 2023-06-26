//
//  ViewController.swift
//  HW3
//
//  Created by Ян Козыренко on 20.06.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var universityLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var mask: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    
    @IBAction func onTap1(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Enter new value", message: "", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            
        }
        
        let doneAction = UIAlertAction(title: "Done", style: .default) { action in
            let pText = alertController.textFields?.first?.text
            guard let text = pText else { return }
            self.universityLabel.text! = text
        }
        alertController.addTextField()
        alertController.addAction(cancelAction)
        alertController.addAction(doneAction)
        
        self.present(alertController, animated: true)
    }
    
    @IBAction func onTap2(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Enter new value", message: "", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            
        }
        
        let doneAction = UIAlertAction(title: "Done", style: .default) { action in
            let pText = alertController.textFields?.first?.text
            guard let text = pText else { return }
            
            self.cityLabel.text = text
        }
        alertController.addTextField()
        alertController.addAction(cancelAction)
        alertController.addAction(doneAction)
        
        self.present(alertController, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        mask.layer.cornerRadius = mask.frame.size.height / 2
    }
    
}

