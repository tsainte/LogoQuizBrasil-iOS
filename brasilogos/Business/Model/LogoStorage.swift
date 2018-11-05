//
//  LogoStorage.swift
//  brasilogos
//
//  Created by Tiago Bencardino on 14/07/2018.
//  Copyright © 2018 MobWiz. All rights reserved.
//

import Foundation

struct LogoStorage {
    let fileURL: URL
    let levels: [Level]

    init(fileURL: URL) throws {
        self.fileURL = fileURL
        let data = try Data(contentsOf: fileURL)
        levels = try LogoStorage.loadLevels(with: data)
    }

    static func loadLevels(with data: Data) throws -> [Level] {
        let logoParser = LogoParser(data: data)
        return try logoParser.parse()
    }
}
