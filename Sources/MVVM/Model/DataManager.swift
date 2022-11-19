// DataManager

import Foundation

public class DataManager: SingleInstance {
    // responsibilities: create DAO, manage datasources.
    private var dataSources = [DataSource]()

    required init?() {
    }

    func add(dataSource: DataSource) {
        dataSources.append(dataSource)
    }

    func createDataAccessObject(id: String) -> DataAccessObject? {
        let components = id.split(separator: ".")
        guard components.count == 2 else { fatalError("createDataAccessObject requires two components, got \"\(id)\"") }
        guard let dataSource = dataSources.first(where: {components[0] == $0.dataSourceID}) else { return nil }
        return dataSource.createDataAccessObject(id: String(components[1]))
    }

    deinit {

    }
}
