//
//  NSPersistentContainer+Extensions.swift
//  FeedStoreChallenge
//
//  Created by Husam Dayya on 19/03/2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import Foundation
import CoreData

extension NSPersistentContainer {
	enum LoadingError: Error {
		case modelNotFound
		case failedToLoadPersistentStores(Swift.Error)
	}
	
	static func load(modalName name: String, url: URL, in bundle: Bundle) throws -> NSPersistentContainer {
		guard let model = NSManagedObjectModel.with(name: name, in: bundle) else {
			throw LoadingError.modelNotFound
		}
		
		let description = NSPersistentStoreDescription(url: url)
		let container = NSPersistentContainer(name: name, managedObjectModel: model)
		container.persistentStoreDescriptions = [description]
		
		var loadError: Error?
		container.loadPersistentStores { loadError = $1 }
		try loadError.map {
			throw LoadingError.failedToLoadPersistentStores($0)
		}
		
		return container
	}
}
