//
//  SectionModel.swift
//  MVVM+Coordinator
//
//  Created by Жеребцов Данил on 17.05.2022.
//

import Foundation
import RxDataSources


public struct SectionModel<Section, ItemType> {
    public var model: Section
    public var items: [Item]

    public init(model: Section, items: [Item]) {
        self.model = model
        self.items = items
    }
}

extension SectionModel: SectionModelType {
    public typealias Identity = Section
    public typealias Item = ItemType
    
    public var identity: Section {
        model
    }
}

extension SectionModel
    : CustomStringConvertible {

    public var description: String {
        "\(self.model) > \(items)"
    }
}

extension SectionModel {
    public init(original: SectionModel<Section, Item>, items: [Item]) {
        self.model = original.model
        self.items = items
    }
}
