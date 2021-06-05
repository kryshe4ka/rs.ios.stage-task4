//  Created by Liza Kryshkovskaya on 4.06.21.

import Foundation

final class FillWithColor {
    
    var newColor: Int = 0
    var oldColor: Int = 0
    var newImage: [[Int]] = [[]]
    var m = 0
    var n = 0
    
    func fillWithColor(_ image: [[Int]], _ row: Int, _ column: Int, _ newColor: Int) -> [[Int]] {
        
        if (row < 0 || column < 0 || row >= image.count || column >= image.first!.count) {
            return image
        }
        
        self.newColor = newColor
        oldColor = image[row][column]
        newImage = image
        n = image.count - 1
        m = image.first!.count - 1

        checkNeighbour(row, column)
        return newImage
    }
    
    func checkNeighbour(_ i: Int, _ j: Int) {
        newImage[i][j] = newColor
        // проверяем соседей
        if (i > 0) {
            // проверяем соседа сверху
            if (newImage[i-1][j] == oldColor) {
                newImage[i-1][j] = newColor
                // проверяем соседей
                checkNeighbour(i-1, j)
            }
        }
        if (j < m) {
            // проверяем соседа справа
            if (newImage[i][j+1] == oldColor) {
                newImage[i][j+1] = newColor
                // проверяем соседей
                checkNeighbour(i, j+1)
            }
        }
        if (i < n) {
            // проверяем соседа снизу
            if (newImage[i+1][j] == oldColor) {
                newImage[i+1][j] = newColor
                // проверяем соседей
                checkNeighbour(i+1, j)
            }
        }
        if (j > 0) {
            // проверяем соседа слева
            if (newImage[i][j-1] == oldColor) {
                newImage[i][j-1] = newColor
                // проверяем соседей
                checkNeighbour(i, j-1)
            }
        }
    }
}
