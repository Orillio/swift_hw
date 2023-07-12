//
//  ViewController.swift
//  HW4
//
//  Created by Ян Козыренко on 01.07.2023.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    
    var allCharacters: [CharacterModel.Character] = []
    var manager: APIManager = APIManager()
    
    lazy var resultController: NSFetchedResultsController<Character> = {
        let request = Character.fetchRequest()
        request.sortDescriptors = []
        
        let frc = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: Container.shared.viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        
        frc.delegate = self
        
        return frc
    }()
    
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
            self.save(characters: self.allCharacters)
            tableView.reloadData()
        })

        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
        }

        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)

        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    private func fetchCharacters() {
        if NetworkAvailability.instance.isAvailable() {
            manager.fetchData { [weak self] result in
                switch result{
                case let .success(response):
                    self?.allCharacters = response.results
                    self?.table.reloadData()
                    self?.save(characters: self?.allCharacters ?? [])
                case let .failure(error):
                    self?.loadCharactersFromCoreData()
                    print(error)
                }
            }
        }
        else {
            loadCharactersFromCoreData()
        }
    }
    
    private func loadCharactersFromCoreData() {
        let request = Character.fetchRequest()
        do {
            let fetched = try Container.shared.viewContext.fetch(request)
            self.allCharacters = fetched.map { character in
                return CharacterModel.Character(
                    id: Int(character.id),
                    name: character.name ?? "",
                    status: character.status ?? "",
                    species: character.species ?? "",
                    gender: character.gender ?? "",
                    location: CharacterModel.Location(name: character.location ?? "",url: ""),
                    image: ""
                )
            }
            self.table.reloadData()
        } catch {
            print(error)
        }
    }

    private func save(characters: [CharacterModel.Character]) {
        Container.shared.performBackgroundTask { context in
            for character in characters {
                let fetchRequest: NSFetchRequest<Character> = Character.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "id == %d", character.id)
                
                if let existingCharacter = try? context.fetch(fetchRequest).first {
                    existingCharacter.gender = character.gender
                    existingCharacter.location = character.location.name
                    existingCharacter.name = character.name
                    existingCharacter.species = character.species
                    existingCharacter.status = character.status
                } else {
                    let newEntity = Character(context: context)
                    newEntity.id = Int16(character.id)
                    newEntity.gender = character.gender
                    newEntity.location = character.location.name
                    newEntity.name = character.name
                    newEntity.species = character.species
                    newEntity.status = character.status
                }
            }
            
            Container.shared.saveContext(backgroundContext: context)
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
        do {
            try resultController.performFetch()
        } catch {
            print(error)
        }
        fetchCharacters()
    }


}

