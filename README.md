# ALPHACamp_finalExam
```swift
// asumming no duplicate number and one solution
func matchAdd(numbers: [Int], target: Int) -> String {
    // create hash map for Int array, O(n) time complexity for inserting hash map.
    var numberHash:[Int:Int] = [:]
    for number in 1...numbers.count {
        numberHash[numbers[number-1]] = number
    }
    // one single loop for Int array, simple substraction by target number and current loop number, if result found in hashmap (taking with O(1) complexity), take value of the hash value that indicating it's index on number array.
    for loop in 1...numbers.count {
        if let bingo = numberHash[target - numbers[loop-1]] {
            return "index1=\(loop), index2=\(bingo)"
        }
    }
    return "nothing found hahahahaha"
}
```
