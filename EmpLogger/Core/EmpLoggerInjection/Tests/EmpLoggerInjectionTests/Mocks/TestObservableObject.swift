//
//  TestObservableObject.swift
//
//
//  Created by AnhDuc on 04/03/2024.
//

import SwiftUI
import EmpLoggerInjection
import EmpLoggerFoundation

protocol SomeObservableTestProtocol: ObservableObject, AnyObservableObject {
    var someObservableProperty: String { get set }
    func doSomething()
}

class TestObservableObject: SomeObservableTestProtocol {
    @Published var someObservableProperty: String = "test"
    func doSomething() {
        someObservableProperty = "did something"
    }
}

// MARK: - Mock ependency registration

extension DependencyMap {
    
    private struct TestObservableObjectKey: DependencyKey {
        static var dependency: any SomeObservableTestProtocol = TestObservableObject()
    }
    
    var testObservableObject: any SomeObservableTestProtocol {
        get { resolve(key: TestObservableObjectKey.self) }
        set { register(key: TestObservableObjectKey.self, dependency: newValue) }
    }
}
