//
//  CoreDataFeedStore.swift
//  FeedStoreChallenge
//
//  Created by Husam Dayya on 17/03/2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import Foundation
import CoreData

public class CoreDataFeedStore: FeedStore {
	
	private let container: NSPersistentContainer
	private let context: NSManagedObjectContext
	
	public init(storeURL: URL, bundle: Bundle = .main) throws {
		container = try NSPersistentContainer.load(modalName: "FeedStoreModel", url: storeURL, in: bundle)
		context = container.newBackgroundContext()
	}
	
	public func retrieve(completion: @escaping FeedStore.RetrievalCompletion) {
		completion(.empty)
	}
	
	public func deleteCachedFeed(completion: @escaping DeletionCompletion) {
		
	}
	
	public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
		
	}
}

private extension NSPersistentContainer {
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

private extension NSManagedObjectModel {
	static func with(name: String, in bundle: Bundle) -> NSManagedObjectModel? {
		return bundle
			.url(forResource: name, withExtension: "momd")
			.flatMap { NSManagedObjectModel(contentsOf: $0) }
	}
}
