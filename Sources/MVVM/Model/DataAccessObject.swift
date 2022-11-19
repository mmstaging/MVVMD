//  DataAccessObject.swift
import Foundation

public protocol DataAccessObject {
    func getDataStream() -> AsyncStream<Data>
}

extension DataAccessObject {
    func getObjStream<T:Decodable>() -> AsyncMapSequence<AsyncStream<Data>, T> {
        getDataStream().map({try! JSONDecoder().decode(T.self, from: $0)})
    }
}
