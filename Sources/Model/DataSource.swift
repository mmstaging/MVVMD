// DataSource

import Foundation
import Combine

public protocol DataSource: SingleInstance {
    var dataSourceID : String { get }
    func createDataAccessObject(id: String) -> DataAccessObject?
}
