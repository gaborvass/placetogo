//
//  ComponentProvider.swift
//  FourSquareAPI
//
//  Created by Gábor Vass on 15/01/2021.
//

import Foundation

final class ComponentProvider {

	fileprivate var components: [Key: Provider] = [:]
	fileprivate var resolvedComponents: [Key: Any] = [:]

	func provide<Component>(_ type: Component.Type) -> Component {
		let key = Key(type: type)
		if let component = resolvedComponents[key] as? Component {
			return component
		}
		let provider = components[key]
		let factory = provider?.factory as? (ComponentProvider) -> Component
		// if this fails, setup is incorrect
		let component = factory.map { $0(self) }!
		resolvedComponents[key] = component
		return component
	}

	func injectMock<Component>(_ component: Component.Type, factory: @escaping (ComponentProvider) -> Component) {
		components[Key(type: component)] = Provider(factory: factory)
	}

	fileprivate func register<Component>(_ component: Component.Type, factory: @escaping (ComponentProvider) -> Component) {
		components[Key(type: component)] = Provider(factory: factory)
	}
}

// MARK: Extension: production components
extension ComponentProvider {
	static var production: ComponentProvider = {
		let provider = ComponentProvider()
		provider.register(Executors.self) { _ in
			return Executors()
		}
		provider.register(DataProvider.self) { _ in
			return RemoteDataProvider()
		}
		provider.register(ConfigReader.self) { _ in
			return BundleConfigReader()
		}
		provider.register(Configuration.self) {
			return Configuration($0)
		}
		provider.register(RequestParameterProvider.self) {
			return RequestParameterProvider($0)
		}
		provider.register(DataDecoder.self) { _ in
			return JSONDataDecoder()
		}
		return provider
	}()
}

// MARK: Fileprivate structs

fileprivate struct Key {
	let type: Any.Type
}

fileprivate struct Provider {
	let factory: Any
}

extension Key: Hashable {
	public func hash(into hasher: inout Hasher) {
		ObjectIdentifier(type).hash(into: &hasher)
	}
}

extension Key: Equatable {
	static func == (lhs: Key, rhs: Key) -> Bool {
		return lhs.type == rhs.type
	}
}
