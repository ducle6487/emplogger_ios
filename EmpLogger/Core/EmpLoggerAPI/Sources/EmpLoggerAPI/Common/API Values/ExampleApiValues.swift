//
//  ExampleApiValues.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import Foundation
import EmpLoggerInjection

struct DevExamplesApiValues: ApiValues {
    public var baseUrl: URL = URL(string: "")!
    public var version: String = "v1.0"
}

struct StgExamplesApiValues: ApiValues {
    public var baseUrl: URL = URL(string: "")!
    public var version: String = "v1.0"
}

struct ProdExamplesApiValues: ApiValues {
    public var baseUrl: URL = URL(string: "")!
    public var version: String = "v1.0"
}

// MARK: - Injection
extension DependencyMap {
    private struct ExampleApiValuesKey: DependencyKey {
        @Inject(\.appEnvironment) static var environment
        static var dependency: any ApiValues = {
            switch environment {
            case .development:
                return DevExamplesApiValues()
            case .staging:
                return StgExamplesApiValues()
            case .production:
                return ProdExamplesApiValues()
            }
        }()
    }

    public var exampleApiValues: any ApiValues {
        get { resolve(key: ExampleApiValuesKey.self) }
        set { register(key: ExampleApiValuesKey.self, dependency: newValue) }
    }
}
