//
//  Day4.swift
//  AdventOfCode2020
//
//  Created by James Pacheco on 12/5/20.
//

import Foundation

public struct Day4: Day {
    public init() { }
    public func part1() -> String {
        return String(passports().count)
    }
    
    public func part2() -> String {
        return String(validatedPassports().count)
    }
    
    func passports() -> [NPPassport] {
        let input = Input("input4").asString()
        let entries = input.components(separatedBy: "\n\n")
        
        return entries.compactMap { entry -> NPPassport? in
            var dictionary = [String: String]()
            for pair in entry
                .split(whereSeparator: { " \n".contains($0) }) {
                let array = pair.split(separator: ":")
                dictionary[String(array[0])] = String(array[1])
            }
            return passport(for: dictionary)
        }
    }
    
    func validatedPassports() -> [NPPassport] {
        let input = Input("input4").asString()
        let entries = input.components(separatedBy: "\n\n")
        
        return entries.compactMap { entry -> NPPassport? in
            var dictionary = [String: String]()
            for pair in entry
                .split(whereSeparator: { " \n".contains($0) }) {
                let array = pair.split(separator: ":")
                dictionary[String(array[0])] = String(array[1])
            }
            
            if let npPassport = passport(for: dictionary),
               validate(npPassport) {
                return npPassport
            } else {
                return nil
            }
        }
    }
    
    private func passport(for value: [String: String]) -> NPPassport? {
        guard let byr = value["byr"],
              let iyr = value["iyr"],
              let eyr = value["eyr"],
              let hgt = value["hgt"],
              let hcl = value["hcl"],
              let ecl = value["ecl"],
              let pid = value["pid"] else { return nil }
        
        return NPPassport(byr: byr, iyr: iyr, eyr: eyr, hgt: hgt, hcl: hcl, ecl: ecl, pid: pid, cid: value["cid"])
    }
    
    private func validate(_ passport: NPPassport) -> Bool {
        if passport.byr.count != 4 {
            return false
        }
        
        if Int(passport.byr) ?? 0 < 1920 {
            return false
        }
        
        if Int(passport.byr) ?? 0 > 2002 {
            return false
        }
        
        if passport.iyr.count != 4 {
            return false
        }
        
        if Int(passport.iyr) ?? 0 < 2010 {
            return false
        }
        
        if Int(passport.iyr) ?? 0 > 2020 {
            return false
        }
        
        if passport.eyr.count != 4 {
            return false
        }
        
        if Int(passport.eyr) ?? 0 < 2020 {
            return false
        }
        
        if Int(passport.eyr) ?? 0 > 2030 {
            return false
        }
        
        if passport.hgt.hasSuffix("cm") {
            let height = Int(passport.hgt[...passport.hgt.index(passport.hgt.endIndex, offsetBy: -3)]) ?? 0
            if height < 150 {
                return false
            }
            
            if height > 193 {
                return false
            }
        } else if passport.hgt.hasSuffix("in") {
            let height = Int(passport.hgt[...passport.hgt.index(passport.hgt.endIndex, offsetBy: -3)]) ?? 0
            if height < 59 {
                return false
            }
            
            if height > 76 {
                return false
            }
        } else {
            return false
        }
         
        if !passport.hcl.hasPrefix("#") {
            return false
            
        }
        
        if passport.hcl.count != 7 {
            return false
            
        }
        
        if passport.hcl[passport.hcl.index(passport.hcl.startIndex, offsetBy: 1)...].contains(where: { !"0123456789abcdef".contains($0) }) {
            return false
        }
           
        if !["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].contains(passport.ecl) {
            return false
        }
        
        if passport.pid.count != 9 {
            return false
        }
        
        if Int(passport.pid) == nil {
            return false
        }
        
        return true
    }
    
    struct NPPassport {
        var byr: String
        var iyr: String
        var eyr: String
        var hgt: String
        var hcl: String
        var ecl: String
        var pid: String
        var cid: String?
    }
    
    
}
