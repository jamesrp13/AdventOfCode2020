//
//  Day6.swift
//  AdventOfCode2020
//
//  Created by James Pacheco on 12/6/20.
//

import Foundation

public struct Day6: Day {
    public init() { }
    
    public func part1() -> String {
        let allAnswers = Input("input6").asString()
            .components(separatedBy: "\n\n")
            .map { groupAnswers -> Set<Character> in
                var set = Set(groupAnswers)
                set.remove("\n")
                return set
            }
        
        return String(allAnswers.reduce(0, { $0 + $1.count }))
    }
    
    public func part2() -> String {
        let allAnswers = Input("input6").asString()
            .components(separatedBy: "\n\n")
            .map { $0.split(separator: "\n") }
        
        let numberWhereEveryoneAnswered = allAnswers.map { groupAnswers -> Int in
            let numberOfPeople = groupAnswers.count
            
            let merged = groupAnswers
                .flatMap { $0 }
                .sorted()
            
            var last = ""
            var numberOfAnswers = 0
            var numberWhereEveryoneAnswered = 0
            for letter in merged {
                if String(letter) != last {
                    if numberOfAnswers == numberOfPeople {
                        numberWhereEveryoneAnswered += 1
                    }
                    
                    last = String(letter)
                    numberOfAnswers = 1
                } else {
                    numberOfAnswers += 1
                }
            }
            
            if numberOfAnswers == numberOfPeople {
                numberWhereEveryoneAnswered += 1
            }
            
            return numberWhereEveryoneAnswered
        }
        
        return String(numberWhereEveryoneAnswered.reduce(0, { $0 + $1 }))
    }
}
