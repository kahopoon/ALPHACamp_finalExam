# ALPHACamp_finalExam
```swift
// asumming no duplicate number and one solution
func matchAdd(numbers: [Int], target: Int) -> String {
    var numberHash:[Int:Int] = [:]
    for number in 1...numbers.count {
        numberHash[numbers[number-1]] = number
    }
    for loop in 1...numbers.count {
        if let bingo = numberHash[target - numbers[loop-1]] {
            return "index1=\(loop), index2=\(bingo)"
        }
    }
    return "nothing found hahahahaha"
}
```
