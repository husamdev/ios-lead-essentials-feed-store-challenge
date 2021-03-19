//
//  NSManagedObjectModel+Extensions.swift
//  FeedStoreChallenge
//
//  Created by Husam Dayya on 19/03/2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectModel {
	static func with(name: String, in bundle: Bundle) -> NSManagedObjectModel? {
		return bundle
			.url(forResource: name, withExtension: "momd")
			.flatMap { NSManagedObjectModel(contentsOf: $0) }
	}
}
