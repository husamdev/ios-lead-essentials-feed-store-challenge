//
//  FeedImage+CoreDataProperties.swift
//  FeedStoreChallenge
//
//  Created by Husam Dayya on 08/03/2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//
//

import Foundation
import CoreData


extension FeedImage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FeedImage> {
        return NSFetchRequest<FeedImage>(entityName: "FeedImage")
    }

    @NSManaged public var id: String?
    @NSManaged public var imageDescription: String?
    @NSManaged public var location: String?
    @NSManaged public var url: URL?

}

extension FeedImage : Identifiable {

}
