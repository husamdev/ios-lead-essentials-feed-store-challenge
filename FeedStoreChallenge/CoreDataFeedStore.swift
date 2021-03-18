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
	
	public init(bundle: Bundle = .main) throws {
		container = try NSPersistentContainer.load(modalName: "FeedStoreModel", in: bundle)
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
	
	static func load(modalName name: String, in bundle: Bundle) throws -> NSPersistentContainer {
		guard let model = NSManagedObjectModel.with(name: name, in: bundle) else {
			throw LoadingError.modelNotFound
		}
		
		let container = NSPersistentContainer(name: name, managedObjectModel: model)
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
