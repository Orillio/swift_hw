//
//  Character+CoreDataProperties.swift
//  
//
//  Created by Ян Козыренко on 12.07.2023.
//
//

import Foundation
import CoreData


extension Character {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Character> {
        return NSFetchRequest<Character>(entityName: "Character")
    }

    @NSManaged public var gender: String?
    @NSManaged public var id: Int16
    @NSManaged public var location: String?
    @NSManaged public var name: String?
    @NSManaged public var species: String?
    @NSManaged public var status: String?

}
