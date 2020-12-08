//
//  Day2.swift
//  AdventOfCode2020
//
//  Created by James Pacheco on 12/5/20.
//

import Foundation

public struct Day2: Day {
    public init() {
        
    }
    
    public func part1() -> String {
        let input = Input("input2").asString()
        return String(input.split(separator: "\n").map { line -> Bool in
            let arr = line.split(maxSplits: 3, omittingEmptySubsequences: true, whereSeparator: { " :-".contains($0) })
            let policy = OldPasswordPolicy(letter: Character(String(arr[2])), min: Int(arr[0])!, max: Int(arr[1])!)
            return policy.meetsPolicy(password: String(arr[3]))
        }.filter { $0 }.count)
    }
    
    public func part2() -> String {
        let input = Input("input2").asString()
        return String(input.split(separator: "\n").map { line -> Bool in
            let arr = line.split(maxSplits: 3, omittingEmptySubsequences: true, whereSeparator: { " :-".contains($0) })
            let policy = NewPasswordPolicy(letter: Character(String(arr[2])), firstPosition: Int(arr[0])!, secondPosition: Int(arr[1])!)
            return policy.meetsPolicy(password: String(arr[3]))
        }.filter { $0 }.count)
    }
}

struct NewPasswordPolicy {
    let letter: Character
    let firstPosition: Int
    let secondPosition: Int
    
    func meetsPolicy(password: String) -> Bool {
        let first = password[password.index(password.startIndex, offsetBy: firstPosition)]
        let second = password[password.index(password.startIndex, offsetBy: secondPosition )]
        
        if first == second {
            return false
        }
        
        if [first, second].contains(letter) {
            return true
        }
        
        return false
    }
}

struct OldPasswordPolicy {
    let letter: Character
    let min: Int
    let max: Int
    
    func meetsPolicy(password: String) -> Bool {
        var count = 0
        for letter in password {
            if letter == self.letter {
                count += 1
            }
            
            if count > max {
                return false
            }
        }
        
        return count >= min
    }
}
