//
//  LogoParser.swift
//  brasilogos
//
//  Created by Tiago Bencardino on 02/11/2018.
//  Copyright © 2018 MobWiz. All rights reserved.
//

import Foundation

struct LogoParser {
    let data: Data

    //TODO: move it to a proper place
    static let logosPerLevel = 16

    init(data: Data) {
        self.data = data
    }

    func parse() throws -> [Level] {
        let allLogos = try JSONDecoder().decode([Logo].self, from: data)
        return LogoParser.levelGenerator(with: allLogos)
    }

    static func levelGenerator(with allLogos: [Logo]) -> [Level] {
        var levels: [Level] = []
        var logos: [Logo] = []

        for i in 1...allLogos.count {
            logos.append(allLogos[i-1])
            if i % logosPerLevel == 0 {
                let levelNumber = i/logosPerLevel
                let newLevel = Level(levelNumber: levelNumber, logos: logos)
                levels.append(newLevel)
                logos = []
            }
        }
        return levels
    }
}
