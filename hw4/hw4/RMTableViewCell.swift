//
//  RMTableViewCell.swift
//  HW4
//
//  Created by Ян Козыренко on 01.07.2023.
//

import UIKit
import Kingfisher

final class RMTableViewCell: UITableViewCell {

    @IBOutlet weak var rmImageView: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var species: UILabel!
    @IBOutlet weak var status: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
        
    func setupData(_ char: CharacterModel.Character) {
        name.text = "Name: " + char.name
        location.text = "Location: " + char.location.name
        gender.text = "Gender: \(char.gender)"
        status.text = "Status: \(char.status)"
        species.text = "Species: " + char.species
        if let url = URL(string: char.image) {
            rmImageView.kf.setImage(with: url)
        } else {
            rmImageView.backgroundColor = .black
        }
    }
}
