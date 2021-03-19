//
//  NSManagedObjectContext+Extensions.swift
//  FeedStoreChallenge
//
//  Created by Husam Dayya on 19/03/2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
	func executeAndMergeChanges(using batchDeleteRequest: NSBatchDeleteRequest) throws {
		batchDeleteRequest.resultType = .resultTypeObjectIDs
		let result = try execute(batchDeleteRequest) as? NSBatchDeleteResult
		let changes: [AnyHashable: Any] = [NSDeletedObjectsKey: result?.result as? [NSManagedObjectID] ?? []]
		NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [self])
	}
}
