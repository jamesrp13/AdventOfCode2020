//
//  Day3.swift
//  AdventOfCode2020
//
//  Created by James Pacheco on 12/5/20.
//

import Foundation

public struct Day3: Day {
    public init() { }
    
    public func part1() -> String {
        return String(encounteredTrees(in: treeMap(), from: (3,1)))
    }
    
    public func part2() -> String {
        let slopes = [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)]
        let map = treeMap()
        
        let trees = slopes.map { encounteredTrees(in: map, from: $0) }
        
        return String(trees.reduce(1) { (result, current) -> Int in
            return result * current
        })
    }
    
    private func encounteredTrees(in map: [String], from slope: (Int, Int)) -> Int {
        var index = 0
        var count = 0
        
        for y in stride(from: 0, to: map.count, by: slope.1) {
            let line = map[y]
            let mark = line[line.index(line.startIndex, offsetBy: index % line.count)]
            if mark == "#" {
                count += 1
            }
            
            index += slope.0
        }
        
        return count
    }
    
    private func treeMap() -> [String] {
        return Input("input3").asString().split(separator: "\n").map { String($0) }
    }
}
