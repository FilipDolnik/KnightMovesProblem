//
//  KnightMovesProblemTest.swift
//  KnightMovesProblemTest
//
//  Created by Filip Dolnik on 25.08.16.
//  Copyright © 2016 Filip Dolnik. All rights reserved.
//

import XCTest

class KnightMovesProblemTest: XCTestCase {
    
    func testSpeed() {
        // Fix for optimizations
        var result = 0
        measureBlock {
            for i in 0...1000 {
                for j in 0...1000 {
                    result += KnightMoves.getNumberOfKnightMoves(i, j)
                }
            }
        }
    }
    
    func testLargeInputSpeed() {
        measureBlock {
            KnightMoves.getNumberOfKnightMoves(123456789, 987654321)
        }
    }
    
    func testMediumInputSpeed() {
        measureBlock {
            KnightMoves.getNumberOfKnightMoves(1234567, 9876543)
        }
    }
    
    func testSmallInputSpeed() {
        measureBlock {
            KnightMoves.getNumberOfKnightMoves(123, 987)
        }
    }
    
    func testNumberOfKnightMoves() {
        let gridSize = (1000, 1000)
        let offset = (50, 50)
        let grid = getGridOfNumberOfKnightMoves(gridSize.0, gridSize.1, offset.0, offset.1)
        
        for (i, row) in grid.enumerate() {
            for (j, cell) in row.enumerate() {
                let x = i - offset.0
                let y = j - offset.1
                let computedMoves = KnightMoves.getNumberOfKnightMoves(x, y)
                XCTAssertEqual(cell, computedMoves, "[\(x)][\(y)]")
            }
        }
    }
    
    private func getGridOfNumberOfKnightMoves(gridSizeX: Int, _ gridSizeY: Int, _ originX: Int, _ originY: Int) -> [[Int]] {
        var grid = Array(count: gridSizeX, repeatedValue: Array(count: gridSizeY, repeatedValue: -1))
        var changedValues: [(x: Int, y: Int)] = [(originX, originY)]
        grid[originX][originY] = 0

        var numberOfMoves = 1
        while !changedValues.isEmpty {
            let values = changedValues
            changedValues.removeAll()
            func changeValue(x: Int, _ y: Int) {
                if grid.indices.contains(x) && grid[x].indices.contains(y) && grid[x][y] == -1 {
                    grid[x][y] = numberOfMoves
                    changedValues.append((x, y))
                }
            }
            
            for value in values {
                changeValue(value.x + 2, value.y + 1)
                changeValue(value.x + 1, value.y + 2)
                changeValue(value.x - 2, value.y + 1)
                changeValue(value.x - 1, value.y + 2)
                changeValue(value.x + 2, value.y - 1)
                changeValue(value.x + 1, value.y - 2)
                changeValue(value.x - 2, value.y - 1)
                changeValue(value.x - 1, value.y - 2)
            }
            numberOfMoves += 1
        }
        return grid
    }
}
