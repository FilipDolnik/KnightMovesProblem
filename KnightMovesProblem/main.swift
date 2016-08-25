//
//  main.swift
//  KnightMovesProblem
//
//  Created by Filip Dolnik on 25.08.16.
//  Copyright © 2016 Filip Dolnik. All rights reserved.
//

if Process.arguments.count == 3, let x = Int(Process.arguments[1]), let y = Int(Process.arguments[2]) {
    print(KnightMoves.getNumberOfKnightMoves(x, y))
} else {
    print("Wrong parameters, must be two integers.")
}
