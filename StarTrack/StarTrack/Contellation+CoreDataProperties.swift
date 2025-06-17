//
//  Contellation+CoreDataProperties.swift
//  StarTrack
//
//  Created by Aluno 14 on 6/17/25.
//
//

import Foundation
import CoreData


extension Contellation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contellation> {
        return NSFetchRequest<Contellation>(entityName: "Contellation")
    }

    @NSManaged public var name: String?
    @NSManaged public var visibleMonths: NSObject?
    @NSManaged public var minDeclination: Double
    @NSManaged public var maxDeclination: Double
    @NSManaged public var rightAscension: Double

}

extension Contellation : Identifiable {

}
