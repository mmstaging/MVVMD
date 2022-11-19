//  MVVMDataAccessObject.swift
import Foundation

public protocol MVVMDataAccessObject {
    func getDataStream() -> AsyncStream<Data>
    func onReceive(data: Data)
    func onDeinit(callback: () -> Void)
}

extension MVVMDataAccessObject {
    public func getObjStream<T:Decodable>() -> AsyncMapSequence<AsyncStream<Data>, T> {
        getDataStream().map({try! JSONDecoder().decode(T.self, from: $0)})
    }
}
