//
//  LogoStorage.swift
//  brasilogos
//
//  Created by Tiago Bencardino on 14/07/2018.
//  Copyright © 2018 MobWiz. All rights reserved.
//

import Foundation

struct LogoStorage {
    let levels: [Level] = levelGenerator()

    //TODO: implement parser
    static func levelGenerator() -> [Level] {
        var levels: [Level] = []
        for _ in 0..<16 {
            levels.append(Level(logos: [Logo()]))
        }
        return levels
    }
}
