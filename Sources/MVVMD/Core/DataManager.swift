// DataManager

import os.log
import Foundation
import SingleInstance

open class DataManager: SingleInstance {
    // responsibilities: create DAO, manage datasources, manage middleware hooks
    private var dataSources = [String: DataSource]()

    public required init?() {
        guard type(of: self) !== DataManager.self
        else {
            os_log("ERROR: Do not create direct instances of DataManager class, instantiate subclasses instead.")
            return nil
        }
    }

    public init?(dataSources: [DataSource.Type]) {
        guard type(of: self) !== DataManager.self
        else {
            os_log("ERROR: Do not create direct instances of DataManager class, instantiate subclasses instead.")
            return nil
        }

        guard !dataSources.isEmpty
        else {
            os_log("ERROR: DataManager cannot initialize without data sources")
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

    public func createDataAccessObject(id: String, params:[String:String]=[:]) -> DataAccessObject? {
        let components = id.split(separator: ".").map(String.init)
        guard components.count > 1
        else {
            os_log("ERROR: createDataAccessObject `id` requires at least two dot-separated components (\"datasource.service\"), got \"\(id)\"")
            return nil
        }
        guard let dataSource = dataSources[components[0]] else { return nil }
        return dataSource.createDataAccessObject(id: components[1], params: params)
    }
}
