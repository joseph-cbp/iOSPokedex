//
//  PokemonTypes.swift
//  PokedexProject
//
//  Created by Joseph Pereira on 19/06/25.
//
import Foundation
import UIKit

enum PokemonTypes: String, Codable {
    case normal
    case fire
    case water
    case electric
    case grass
    case ice
    case fighting
    case poison
    case ground
    case flying
    case psychic
    case bug
    case rock
    case ghost
    case dragon
    case dark
    case steel
    case fairy
    
    func getTitle() -> String {
        return self.rawValue.capitalized
    }
    
    func getColor() -> UIColor {
        return UIColor(named: self.rawValue) ?? .clear
    }
}
