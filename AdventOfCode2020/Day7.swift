//
//  Day7.swift
//  AdventOfCode2020
//
//  Created by James Pacheco on 12/7/20.
//

import Foundation

public struct Day7: Day {
    public init() { }
    
    public func part1() -> String {
        let bags = createGraph()
        
        guard let index = bags.firstIndex(of: Bag(color: "shiny gold")) else { fatalError() }
        
        return String(bags[index].ancestors([]).count)
    }
    
    public func part2() -> String {
        let bags = createGraph()
        
        guard let index = bags.firstIndex(of: Bag(color: "shiny gold")) else { fatalError() }
        
        return String(bags[index].numChildBags())
    }
    
    func createGraph() -> Set<Bag> {
        let rules = Input("input7").asString()
            .components(separatedBy: "\n")
        var bags: Set<Bag> = []
        for entry in rules {
            guard !entry.isEmpty else { continue }
            
            let entry = entry.components(separatedBy: " bags contain ")
            var parentBag = Bag(color: entry[0])
            
            if let index = bags.firstIndex(of: parentBag) {
                parentBag = bags[index]
            } else {
                bags.insert(parentBag)
            }
            
            if entry[1].hasPrefix("no") { continue }
            
            let rules = entry[1].components(separatedBy: ", ").map { value -> (Bag, Int) in
                if let firstIndex = value.firstIndex(of: " "),
                   let lastIndex = value.lastIndex(of: " ") {
                    let count = Int(value[value.startIndex..<firstIndex]) ?? 0
                    let bag = Bag(color: String(value[value.index(after: firstIndex)..<lastIndex]))
                    
                    return (bag, count)
                }
                
                fatalError()
            }
            
            for rule in rules {
                let enclosedBag = rule.0
                
                if let index = bags.firstIndex(of: enclosedBag) {
                    parentBag.addEnclosedBag(bags[index], count: rule.1)
                } else {
                    bags.insert(enclosedBag)
                    parentBag.addEnclosedBag(enclosedBag, count: rule.1)
                }
            }
        }
        
        return bags
    }
}

class Bag {
    private var _enclosingBags: Set<Bag>
    private var _enclosedBags: [Bag: Int]
    
    let color: String
    
    var enclosingBags: Set<Bag> {
        return _enclosingBags
    }
    
    var enclosedBags: [Bag: Int] {
        return _enclosedBags
    }
    
    init(color: String, enclosingBags: Set<Bag> = [], enclosedBags: [Bag: Int] = [:]) {
        self.color = color
        self._enclosingBags = enclosingBags
        self._enclosedBags = enclosedBags
    }
    
    func addEnclosedBag(_ bag: Bag, count: Int) {
        guard _enclosedBags[bag] == nil else { return }
        
        _enclosedBags[bag] = count
        bag.addEnclosingBag(self)
    }
    
    func addEnclosingBag(_ bag: Bag) {
        guard !_enclosingBags.contains(bag) else { return }
        
        _enclosingBags.insert(bag)
    }
    
    func ancestors(_ bags: Set<Bag>) -> Set<Bag> {
        var bags: Set<Bag> = bags
        
        for enclosingBag in enclosingBags {
            if !bags.contains(enclosingBag) {
                bags.insert(enclosingBag)
                bags.formUnion(enclosingBag.ancestors(bags))
            }
        }
        
        return bags
    }
    
    func numChildBags() -> Int {
        var bagCount = 0
        
        for (bag, count) in enclosedBags {
            bagCount += count + count * bag.numChildBags()
        }
        
        return bagCount
    }
}

extension Bag: Equatable {
    static func == (lhs: Bag, rhs: Bag) -> Bool {
        return lhs.color == rhs.color
    }
}

extension Bag: Hashable {
    func hash(into hasher: inout Hasher) {
        return color.hash(into: &hasher)
    }
}
