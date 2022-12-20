// DataSource

import Foundation
import SingleInstance

public protocol DataSource: SingleInstance {
    var state: DataSourceState { get }
    var dataSourceID : String { get }
    var params: [String:String] { get }
    func createDataAccessObject(id: String, params:[String:String]) -> DataAccessObject?
}
