//
//  AccessibleImageEntity+CoreDataProperties.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 18/06/25.
//
//

import Foundation
import CoreData


extension AccessibleImageEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AccessibleImageEntity> {
        return NSFetchRequest<AccessibleImageEntity>(entityName: "AccessibleImageEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var alternativeText: String?
    @NSManaged public var imageData: Data?

}

extension AccessibleImageEntity : Identifiable {

}
