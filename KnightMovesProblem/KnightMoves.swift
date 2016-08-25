//
//  KnightMoves.swift
//  KnightMovesProblem
//
//  Created by Filip Dolnik on 25.08.16.
//  Copyright © 2016 Filip Dolnik. All rights reserved.
//

public struct KnightMoves {

    public static func getNumberOfKnightMoves(x: Int, _ y: Int) -> Int {
        let (a, b) = normalizeCoordinates(x, y)
        if a < 7 {
            return getNumberOfKnightMovesIn7x7(a, b)
        } else {
            return getNumberOfKnightMovesOutside7x7(a, b)
        }
    }
    
    private static func normalizeCoordinates(x: Int, _ y: Int) -> (Int, Int) {
        let ax = abs(x)
        let ay = abs(y)
        return (max(ax, ay), min(ax, ay))
    }
    
    private static func getNumberOfKnightMovesIn7x7(x: Int, _ y: Int) -> Int {
        var a = x
        var b = y
        var moves = 0
        while true {
            (a, b) = normalizeCoordinates(a, b)
            switch (a, b) {
            case (0, 0):
                break
            case (1, 1), (2, 0), (3, 1):
                moves += 2
            case (4, 3), (1, 0):
                moves += 3
            default:
                a -= 2
                b -= 1
                moves += 1
                continue
            }
            return moves
        }
    }
    
    private static func getNumberOfKnightMovesOutside7x7(x: Int, _ y: Int) -> Int {
        var a = x
        var b = y
        var moves = 0
        while a >= 7 {
            if a == b {
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
        return getNumberOfKnightMovesIn7x7(a, b) + moves
    }
}
