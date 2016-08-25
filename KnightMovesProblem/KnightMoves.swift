//
//  KnightMoves.swift
//  KnightMovesProblem
//
//  Created by Filip Dolnik on 25.08.16.
//  Copyright © 2016 Filip Dolnik. All rights reserved.
//

public struct KnightMoves {
    
    private static let exceptions: [(x: Int, y: Int, numberOfMoves: Int)] = [
        (0, 0, 0),
        (1, 0, 3),
        (1, 1, 2),
        (2, 0, 2),
        (3, 1, 2),
        (4, 3, 3)
    ]
    
    public static func getNumberOfKnightMoves(x: Int, _ y: Int) -> Int {
        let (a, b) = normalizeCoordinates(x, y)
        if a < 6 {
            return getNumberOfKnightMovesIn6x6(a, b)
        } else {
            return getNumberOfKnightMovesOutside6x6(a, b)
        }
    }
    
    private static func normalizeCoordinates(x: Int, _ y: Int) -> (Int, Int) {
        let ax = abs(x)
        let ay = abs(y)
        return (max(ax, ay), min(ax, ay))
    }
    
    private static func getNumberOfKnightMovesIn6x6(x: Int, _ y: Int) -> Int {
        let (a, b) = normalizeCoordinates(x, y)
        for exception in exceptions {
            if exception.x == a && exception.y == b {
                return exception.numberOfMoves
            }
        }
        return getNumberOfKnightMovesIn6x6(a - 2, b - 1) + 1
    }
    
    private static func getNumberOfKnightMovesOutside6x6(x: Int, _ y: Int) -> Int {
        var a = x
        var b = y
        var moves = 0
        while a >= 6 {
            if a == 6 && b == 6 {
                a -= 1
                b -= 2
                moves += 1
            } else if a == b {
                a -= 3
                b -= 3
                moves += 2
            } else if b == 0 {
                a -= 4
                moves += 2
            } else {
                a -= 2
                b -= 1
                moves += 1
            }
        }
        return getNumberOfKnightMovesIn6x6(a, b) + moves
    }
}
