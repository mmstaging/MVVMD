// DataManager

import Foundation

public class MVVMDataManager: SingleInstance {
    // responsibilities: create DAO, manage datasources.
    private var dataSources = [MVVMDataSource]()

    public required init?() {
    }

    public func add(dataSource: MVVMDataSource) {
        dataSources.append(dataSource)
    }

    public func createDataAccessObject(id: String) -> MVVMDataAccessObject? {
        let components = id.split(separator: ".")
        guard components.count == 2 else { fatalError("createDataAccessObject requires two components, got \"\(id)\"") }
        guard let dataSource = dataSources.first(where: {components[0] == $0.dataSourceID}) else { return nil }
        return dataSource.createDataAccessObject(id: String(components[1]))
    }

    deinit {

    }
}
