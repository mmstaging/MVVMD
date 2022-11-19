// DataSource

import Foundation
import Combine

public protocol MVVMDataSource: SingleInstance {
    var dataSourceID : String { get }
    func createDataAccessObject(id: String) -> MVVMDataAccessObject?
}
