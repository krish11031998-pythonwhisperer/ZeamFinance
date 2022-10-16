//
//  DataBindable.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 15/10/2022.
//

import Foundation

//MARK: - TargetWrapper

private class TargetWrapper {
	weak var object: AnyObject?
	var binds:[Any?]
	
	init(_ object: AnyObject?, binds:[Any?]) {
		self.object = object
		self.binds = binds
	}
}

extension TargetWrapper: Equatable{
	static func == (lhs: TargetWrapper, rhs: TargetWrapper) -> Bool {
		lhs.object === rhs.object
	}
}

//MARK: - Wrapper

private struct Wrapper {
	static var all: Cache<String, [TargetWrapper]> = .init()
}

//MARK: - DataBindable

public protocol DataBindable {
	associatedtype Key: RawRepresentable
}

public extension DataBindable {
	
	static func namespace<T:RawRepresentable>(_ key:T) -> String { "\(Self.self).\(key.rawValue)" }
	
	static func bind<T>(key: Key, target cancellable: NSObject, callback: @escaping (T?) -> Void) {
		let wrapper = TargetWrapper(cancellable, binds: [callback])
		let keyName = namespace(key)
	
		if let item = Wrapper.all[keyName] {
			if let index = item.firstIndex(of: wrapper) {
				item[index].binds.append(callback)
			} else {
				Wrapper.all[keyName]?.append(wrapper)
			}
		} else {
			Wrapper.all[keyName] = [wrapper]
		}
		
	}
	
}
