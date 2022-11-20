// DataSource

import Foundation
import Combine
import SingleInstance

public protocol MVVMDataSource: SingleInstance {
    var dataSourceID : String { get }
    func createDataAccessObject(id: String) -> MVVMDataAccessObject?
}
