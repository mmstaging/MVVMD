// DataSource

import Foundation
import Combine
import SingleInstance


public protocol MVVMD_DataSource: SingleInstance {
    var dataSourceID : String { get }
    var params: [String:String] { get }
    func createDataAccessObject(id: String, params:[String:String]) -> MVVMD_DataAccessObject?
}
