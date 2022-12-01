//  MVVMD_DataAccessObject.swift
import Foundation

public protocol MVVMD_DataAccessObject: AnyObject {
    func getDataStream() -> AsyncStream<Data>
    func onReceive(data: Data)
}

extension MVVMD_DataAccessObject {
    public func getObjStream<T:Decodable>() -> AsyncMapSequence<AsyncStream<Data>, T> {
        getDataStream().map({try! JSONDecoder().decode(T.self, from: $0)})
    }
}
