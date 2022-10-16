//
//  Cache.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 16/10/2022.
//

import Foundation

final class Cache<Key: Hashable, Value> {
	
	private class WrappedKey: NSObject {
		let key: Key
		init(key: Key) {
			self.key = key
		}
		override var hash: Int { self.key.hashValue }
		override func isEqual(_ object: Any?) -> Bool {
			(object as? WrappedKey)?.key == key
		}
	}
	
	private class Entry {
		let value: Value
		init(value: Value) {
			self.value = value
		}
	}
	
	private let wrapped: NSCache<WrappedKey, Entry> = .init()
	
	
	subscript(_ key: Key) -> Value? {
		get {
			wrapped.object(forKey: WrappedKey(key: key))?.value
		}
		
		set {
			guard let value = newValue else {
				wrapped.removeObject(forKey: WrappedKey(key: key))
				return
			}
			wrapped.setObject(Entry(value: value), forKey: WrappedKey(key: key))
		}
	}
	
	func removeAll() {
		wrapped.removeAllObjects()
	}
	
}
