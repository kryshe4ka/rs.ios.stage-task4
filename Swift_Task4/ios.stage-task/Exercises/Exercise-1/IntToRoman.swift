//  Created by Liza Kryshkovskaya on 4.06.21.
// Approach:
// Store Letters used in Roman numerals and the corresponding numerical values in an array. Initialize a string builder, Now start checking if input number is >= highest roman numeral then add it to the string builder and reduce its corresponding value from the input number and if input number is < highest roman numeral then check with next highest roman numeral and repeat the process above till input number becomes 0. string builder will be our roman representation of input number.

import Foundation

public extension Int {
    
    var roman: String? {
        
        guard (1...3999).contains(self) else {
            return nil
        }
        var number = self
        let intNumbers = [1000,900,500,400,100,90,50,40,10,9,5,4,1]
        let romanNumbers = ["M","CM","D","CD","C","XC","L","XL","X","IX","V","IV","I"]
        var resultString:String = ""
        var i = 0
        
        while (i < intNumbers.count) {
            
            while (number >= intNumbers[i]) {
                number -= intNumbers[i];
                resultString.append(romanNumbers[i]);
            }
            i += 1
        }
        return resultString
    }
}
