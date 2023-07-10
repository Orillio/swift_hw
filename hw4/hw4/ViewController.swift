//
//  ViewController.swift
//  HW4
//
//  Created by Ян Козыренко on 01.07.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var allCharacters: [CharacterModel.Character] = []
    var manager: APIManager = APIManager()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allCharacters.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let dialogMessage = UIAlertController(title: "Change name", message: "", preferredStyle: .alert)
        
        dialogMessage.addTextField(configurationHandler: { textField in
            textField.placeholder = "Name"
        })
                
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            self.allCharacters[indexPath.row].name = dialogMessage.textFields?.first?.text ?? ""
            tableView.reloadData()
        })

        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
        }

        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)

        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    private func fetchCharacters() {
        manager.fetchData { [weak self] result in
            switch result{
                case let .success(response):
                    self?.allCharacters = response.results
                self?.table.reloadData()
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let personCell = tableView.dequeueReusableCell(withIdentifier: "RMTableViewCell") as? RMTableViewCell else { return UITableViewCell() }
        personCell.setupData(allCharacters[indexPath.row])
        
        return personCell
    }
    

    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        fetchCharacters()
        // Do any additional setup after loading the view.
    }


}

