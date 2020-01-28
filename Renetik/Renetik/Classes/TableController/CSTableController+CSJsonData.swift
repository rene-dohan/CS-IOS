//
// Created by Rene Dohan on 1/9/20.
//

import Foundation
import RenetikObjc

public extension CSTableController where Row: CSJsonData, Data: CSListServerJsonData<Row> {
    @discardableResult
    public func onLoadList(operation: CSOperation<Data>) -> Self {
        onLoad = { operation.onSuccess { data in self.load(data.list) } }
        return self
    }
}

public extension CSTableController where Data: CSListData {
    @discardableResult
    public func onLoadList(operation: CSOperation<Data>) -> Self {
        onLoad = { operation.onSuccess { data in self.load(data.list.cast()) } }
        return self
    }
}