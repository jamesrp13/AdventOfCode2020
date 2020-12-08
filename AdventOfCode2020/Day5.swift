//
//  Day5.swift
//  AdventOfCode2020
//
//  Created by James Pacheco on 12/5/20.
//

import Foundation

public struct Day5: Day {
    public init() { }
    
    public func part1() -> String {
        let seats = Input("input5").asString()
            .split(separator: "\n")
            .compactMap { Seat(String($0)) }
            .sorted(by: { $0.id > $1.id })

        return String(seats.first?.id ?? 0)
    }
    
    public func part2() -> String {
        let seats = Input("input5").asString()
            .split(separator: "\n")
            .compactMap { Seat(String($0)) }
            .sorted(by: { $0.id > $1.id })
        
        for (index, seat) in seats.enumerated() {
            guard index > 0 && index < seats.underestimatedCount else { continue }
            
            if seats[index - 1].id == seat.id + 2 {
                return String(seat.id + 1)
            }
        }
        
        fatalError()
    }
    
    struct Seat {
        var id: Int {
            return row * 8 + column
        }
        
        let row: Int
        let column: Int
        
        init?(_ value: String) {
            let separator = value.index(value.endIndex, offsetBy: -3)
            let rowString = value[...separator]
            let columnString = value[separator...]
            
            var rows = 0..<128
            var columns = 0..<8
            
            for letter in rowString {
                if letter == "F" {
                    rows = rows.lowerBound..<(rows.lowerBound + rows.count/2)
                } else if letter == "B" {
                    rows = (rows.lowerBound + rows.count/2)..<rows.upperBound
                }
            }
            
            for letter in columnString {
                if letter == "L" {
                    columns = columns.lowerBound..<(columns.lowerBound + columns.count/2)
                } else if letter == "R" {
                    columns = (columns.lowerBound + columns.count/2)..<columns.upperBound
                }
            }
            
            self.row = rows.lowerBound
            self.column = columns.lowerBound
        }
    }
}
