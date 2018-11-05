//
//  Logo.swift
//  brasilogos
//
//  Created by Tiago Bencardino on 14/07/2018.
//  Copyright © 2018 MobWiz. All rights reserved.
//

import Foundation

//{
//    "id": 1,
//    "nome": "Petrobrás",
//    "alternativo": "br, petrobas, posto br",
//    "imagem": "petrobras.png",
//    "imagemModificada": "petrobras_mod.png",
//    "wikipedia": "Petrobras",
//    "slogan": "O desafio é a nossa energia.",
//    "dica1": "Atua no ramo de petróleo e energia",
//    "dica2": "Segunda maior empresa de energia do mundo"
//}

struct Logo: Decodable {
    let id: Int
    let name: String
    let alternativeNames: [String]?
    let questionImageName: String
    let answerImageName: String
    let firstClue: String
    let secondClue: String
    let thirdClue: String

    enum CodingKeys: String, CodingKey {
        case id
        case name = "nome"
        case questionImageName = "imagemModificada"
        case answerImageName = "imagem"
        case firstClue = "dica1"
        case secondClue = "dica2"
        case thirdClue = "slogan"
        case alternativeNames = "alternativo"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        name  = try container.decode(String.self, forKey: .name)
        questionImageName = try container.decode(String.self, forKey: .questionImageName)
        answerImageName = try container.decode(String.self, forKey: .answerImageName)
        firstClue = try container.decode(String.self, forKey: .firstClue)
        secondClue = try container.decode(String.self, forKey: .secondClue)
        thirdClue = try container.decode(String.self, forKey: .thirdClue)

        do {
            let alternatives = try container.decode(String.self, forKey: .alternativeNames).split(separator: ",")
            alternativeNames = alternatives.map { String($0).trimmingCharacters(in: .whitespaces) }
        } catch {
            alternativeNames = nil
        }
    }
}
