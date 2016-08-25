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
        let offset = 7
        let dx = x - offset
        let dy = y - offset
        let a: Int
        let b: Int
        var moves: Int
        if x == y {
            (a, b, moves) = diagonalSuperMove(dx)
        } else if y == 0 {
            (a, b, moves) = horizontalSuperMove(dx, offset)
        // Move 2x, y until y == 0
        } else if dx / 2 > y {
            let transientX = dx - (y * 2)
            (a, b, moves) = horizontalSuperMove(transientX, offset)
            moves += y
        // Move 2x, y until x == y
        } else if dx / 2 < dy {
            let firstMoves = dx - dy
            let transientX = dy - firstMoves
            (a, b, moves) = diagonalSuperMove(transientX)
            moves += firstMoves
        // Move 2x, y until x < offset
        } else {
            moves = (dx / 2) + 1
            a = dx - (moves * 2)
            b = dy - moves
        }
        return getNumberOfKnightMovesIn7x7(a + offset, b + offset) + moves
    }
    
    private static func diagonalSuperMove(x: Int) -> (Int, Int, Int) {
        let doubleMoves = (x / 3) + 1
        let resultX = x - (doubleMoves * 3)
        return (resultX, resultX, doubleMoves * 2)
    }
    
    private static func horizontalSuperMove(x: Int, _ offset: Int) -> (Int, Int, Int) {
        let doubleMoves = (x / 4) + 1
        return (x - (doubleMoves * 4), -offset, doubleMoves * 2)
    }
}
