//
//  TransferProtocol.swift
//  Transfer App
//
//  Created by van on 18.10.2023.
//

import Foundation

// Такой подход позволяет скрыть за протоколом внутреннюю реализацию и кон- кретный тип контроллера, а значит при необходимости использовать любой вью контроллер, соответствующий протоколу UpdatingDataController.
protocol UpdatingDataTransferProtocol: class {
    var updatingData: String {get set}
}

protocol UpdatableDataTransferProtocol: class {
    var updatedData: String {get set}
}
