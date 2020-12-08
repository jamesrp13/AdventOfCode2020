//
//  Day1.swift
//  AdventOfCode2020
//
//  Created by James Pacheco on 12/1/20.
//

import Foundation

public protocol Day {
    func part1() -> String
    func part2() -> String
}

public struct Day1: Day {
    public func part1() -> String {
        let input = Input("input1").asNumericSet()
        
        for x in input {
            if input.contains(2020 - x) {
                return String(x * (2020-x))
            }
        }
        
        fatalError("Something went wrong")
    }
    
    public func part2() -> String {
        let input = Input("input1").asNumericSet()
        
        for x in input {
            let remaining = 2020 - x
            
            for y in input {
                if input.contains(remaining - y) {
                    return String(x * y * (remaining - y))
                }
            }
        }
        
        fatalError("Something went wrong")
    }
}
