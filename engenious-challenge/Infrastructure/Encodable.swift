//
//  File.swift
//  engenious-challenge
//
//  Created by Юлія Воротченко on 11.01.2024.
//

import Foundation

extension Encodable {
    func encode() -> Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            return nil
        }
    }
}
