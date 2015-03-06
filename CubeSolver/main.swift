//
//  main.swift
//  CubeSolver
//
//  Created by Simon Strandgaard on 05-03-15.
//  Copyright (c) 2015 Simon Strandgaard. All rights reserved.
//

import Foundation

struct XYZ {
	let x: Int
	let y: Int
	let z: Int
	
	init(_ x: Int, _ y: Int, _ z: Int) {
		self.x = x
		self.y = y
		self.z = z
	}
}

// -1, invisible face
// 0..5, visible face
struct Faces {
	let top: Int
	let bottom: Int
	let left: Int
	let right: Int
	let front: Int
	let back: Int
	
	init(_ top: Int, _ bottom: Int, _ left: Int, _ right: Int, _ front: Int, _ back: Int) {
		self.top = top
		self.bottom = bottom
		self.left = left
		self.right = right
		self.front = front
		self.back = back
	}
}

class Cube {
	let position: XYZ
	let faces: Faces
	init(_ position: XYZ, _ faces: Faces) {
		self.position = position
		self.faces = faces
	}
}

func colorForFace(value: Int) -> String {
	let s = ["-", "b", "o", "g", "r", "y", "w"]
	return s[value + 1]
}


func formatTop(cubes: [Cube]) -> String {
	var result = ""
	for var z = -1; z <= 1; z++ {
		for var x = -1; x <= 1; x++ {
			for cube in cubes {
				if cube.position.y != +1 {
					continue
				}
				if cube.position.z != z {
					continue
				}
				if cube.position.x != x {
					continue
				}
				result += colorForFace(cube.faces.top)
				if x == 1 && z != 1 {
					result += "\n"
				}
			}
		}
	}
	return result
}

func formatLeft(cubes: [Cube]) -> String {
	var result = ""
	for var y = -1; y <= 1; y++ {
		for var z = -1; z <= 1; z++ {
			for cube in cubes {
				if cube.position.y != y {
					continue
				}
				if cube.position.z != z {
					continue
				}
				if cube.position.x != -1 {
					continue
				}
				result += colorForFace(cube.faces.left)
				if z == 1 && y != 1 {
					result += "\n"
				}
			}
		}
	}
	return result
}

func formatFront(cubes: [Cube]) -> String {
	var result = ""
	for var y = 1; y >= -1; y-- {
		for var x = -1; x <= 1; x++ {
			for cube in cubes {
				if cube.position.y != y {
					continue
				}
				if cube.position.z != +1 {
					continue
				}
				if cube.position.x != x {
					continue
				}
				result += colorForFace(cube.faces.front)
				if x == 1 && y != -1 {
					result += "\n"
				}
			}
		}
	}
	return result
}

func formatRight(cubes: [Cube]) -> String {
	var result = ""
	for var y = 1; y >= -1; y-- {
		for var z = 1; z >= -1; z-- {
			for cube in cubes {
				if cube.position.y != y {
					continue
				}
				if cube.position.z != z {
					continue
				}
				if cube.position.x != 1 {
					continue
				}
				result += colorForFace(cube.faces.right)
				if z == -1 && y != -1 {
					result += "\n"
				}
			}
		}
	}
	return result
}

func formatBack(cubes: [Cube]) -> String {
	var result = ""
	for var y = 1; y >= -1; y-- {
		for var x = 1; x >= -1; x-- {
			for cube in cubes {
				if cube.position.y != y {
					continue
				}
				if cube.position.z != -1 {
					continue
				}
				if cube.position.x != x {
					continue
				}
				result += colorForFace(cube.faces.back)
				if x == -1 && y != -1 {
					result += "\n"
				}
			}
		}
	}
	return result
}

func formatDown(cubes: [Cube]) -> String {
	var result = ""
	for var z = 1; z >= -1; z-- {
		for var x = -1; x <= 1; x++ {
			for cube in cubes {
				if cube.position.y != -1 {
					continue
				}
				if cube.position.z != z {
					continue
				}
				if cube.position.x != x {
					continue
				}
				result += colorForFace(cube.faces.bottom)
				if x == 1 && z != -1 {
					result += "\n"
				}
			}
		}
	}
	return result
}

func takeRow(string: String, row: Int) -> String {
	let strings = string.componentsSeparatedByString("\n")
	assert(strings.count == 3)
	return strings[row]
}

func dumpRubix(cubes: [Cube]) {
	let top = formatTop(cubes)
	let left = formatLeft(cubes)
	let front = formatFront(cubes)
	let right = formatRight(cubes)
	let back = formatBack(cubes)
	let down = formatDown(cubes)
	
	var rows = ""
	rows += "    " + takeRow(top, 0) + "\n"
	rows += "    " + takeRow(top, 1) + "\n"
	rows += "    " + takeRow(top, 2) + "\n\n"
	rows += takeRow(left, 0) + " " + takeRow(front, 0) + " " + takeRow(right, 0) + " " + takeRow(back, 0) + "\n"
	rows += takeRow(left, 1) + " " + takeRow(front, 1) + " " + takeRow(right, 1) + " " + takeRow(back, 1) + "\n"
	rows += takeRow(left, 2) + " " + takeRow(front, 2) + " " + takeRow(right, 2) + " " + takeRow(back, 2) + "\n\n"
	rows += "    " + takeRow(down, 0) + "\n"
	rows += "    " + takeRow(down, 1) + "\n"
	rows += "    " + takeRow(down, 2) + "\n"
	print(rows)
}


let cubes: [Cube] = [
	// top, bottom, left, right, front, back
	Cube(XYZ(-1, -1, -1), Faces(-1,  5,  0, -1, -1, -1)),
	Cube(XYZ(-1, -1,  0), Faces(-1,  5,  0, -1, -1, -1)),
	Cube(XYZ(-1, -1, +1), Faces(-1,  5,  0, -1, -1, -1)),
	Cube(XYZ(-1,  0, -1), Faces(-1, -1,  0, -1, -1, -1)),
	Cube(XYZ(-1,  0,  0), Faces(-1, -1,  0, -1, -1, -1)),
	Cube(XYZ(-1,  0, +1), Faces(-1, -1,  0, -1, -1, -1)),
	Cube(XYZ(-1, +1, -1), Faces( 2, -1,  0, -1, -1, -1)),
	Cube(XYZ(-1, +1,  0), Faces( 2, -1,  0, -1, -1, -1)),
	Cube(XYZ(-1, +1, +1), Faces( 2, -1,  0, -1, -1, -1)),
	
	Cube(XYZ( 0, -1, -1), Faces(-1,  5, -1, -1, -1, -1)),
	Cube(XYZ( 0, -1,  0), Faces(-1,  5, -1, -1, -1, -1)),
	Cube(XYZ( 0, -1, +1), Faces(-1,  5, -1, -1, -1, -1)),
	Cube(XYZ( 0,  0, -1), Faces(-1, -1, -1, -1, -1, -1)),
	Cube(XYZ( 0,  0,  0), Faces(-1, -1, -1, -1, -1, -1)),
	Cube(XYZ( 0,  0, +1), Faces(-1, -1, -1, -1, -1, -1)),
	Cube(XYZ( 0, +1, -1), Faces( 2, -1, -1, -1, -1, -1)),
	Cube(XYZ( 0, +1,  0), Faces( 2, -1, -1, -1, -1, -1)),
	Cube(XYZ( 0, +1, +1), Faces( 2, -1, -1, -1, -1, -1)),
	
	Cube(XYZ(+1, -1, -1), Faces(-1,  5, -1,  1, -1, -1)),
	Cube(XYZ(+1, -1,  0), Faces(-1,  5, -1,  1, -1, -1)),
	Cube(XYZ(+1, -1, +1), Faces(-1,  5, -1,  1, -1, -1)),
	Cube(XYZ(+1,  0, -1), Faces(-1, -1, -1,  1, -1, -1)),
	Cube(XYZ(+1,  0,  0), Faces(-1, -1, -1,  1, -1, -1)),
	Cube(XYZ(+1,  0, +1), Faces(-1, -1, -1,  1, -1, -1)),
	Cube(XYZ(+1, +1, -1), Faces( 2, -1, -1,  1, -1, -1)),
	Cube(XYZ(+1, +1,  0), Faces( 2, -1, -1,  1, -1, -1)),
	Cube(XYZ(+1, +1, +1), Faces( 2, -1, -1,  1, -1, -1))
]


dumpRubix(cubes)

