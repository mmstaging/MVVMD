// DataManager

import os
import Foundation
import SingleInstance

public protocol DataManagerClass: AnyObject {
    init?(dataSources: [MVVMD_DataSource.Type])
    func createDataAccessObject(id: String, params:[String:String]) -> MVVMD_DataAccessObject?
}

open class MVVMD_DataManager: SingleInstance {
    // responsibilities: create DAO, manage datasources, manage middleware hooks
    private var dataSources = [String: MVVMD_DataSource]()

    public required init?() {
        guard !(type(of: self) === MVVMD_DataManager.self)
        else {
            os_log("ERROR: Do not create direct instances of MVVMD_DataManager class, instantiate subclasses instead.")
            return nil
        }
    }

    public init?(dataSources: [MVVMD_DataSource.Type]) {
        guard !(type(of: self) === MVVMD_DataManager.self)
        else {
            os_log("ERROR: Do not create direct instances of MVVMD_DataManager class, instantiate subclasses instead.")
            return nil
        }

        guard !dataSources.isEmpty
        else {
            os_log("ERROR: MVVMD_DataManager cannot initialize without data sources")
            return nil
        }

        for dataSource in dataSources {
            if let instantiatedDataSource = dataSource.init() {
                self.dataSources[instantiatedDataSource.dataSourceID] = instantiatedDataSource
            } else {
                os_log("ERROR: Couldn't instantiate SingleInstance data source \(dataSource). DataManager not initialized.")
                return nil
            }
        }
    }

    public func createDataAccessObject(id: String, params:[String:String]=[:]) -> MVVMD_DataAccessObject? {
        let components = id.split(separator: ".").map(String.init)
        guard components.count == 2
        else {
            os_log("ERROR: createDataAccessObject `id` requires two dot-separated components (\"datasource.service\"), got \"\(id)\"")
            return nil
        }
        guard let dataSource = dataSources[components[0]] else { return nil }
        return dataSource.createDataAccessObject(id: components[1], params: params)
    }
}
