//
//  Input.swift
//  AdventOfCode2020
//
//  Created by James Pacheco on 12/1/20.
//

import Foundation

public class Input {
    private let name: String
    
    init(_ name: String) {
        self.name = name
    }
    public func asString() -> String {
        let url = Bundle(identifier: "com.unboxed.AdventOfCode2020")!.url(forResource: name, withExtension: "txt")!
        return try! String(contentsOf: url)
    }
    
    public func asNumericList() -> [Int] {
        return asString().split(separator: "\n").compactMap { Int($0) }
    }
    
    public func asNumericSet() -> Set<Int> {
        return Set(asNumericList())
    }
}
