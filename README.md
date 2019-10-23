# 영준아 Swift 좀 Algo 쓰자  

알고리즘 문제를 Swift로 해결하면서 새롭게 알게 된 내용을 마구마구 기록하겠습니다.  

</br>


<details><summary>문자열 처리</summary> 
  <li><a href = "#subString"><code>subString</code></a></li>
  <li><a href = "#특정문자삭제"><code>특정문자삭제</code></a></li>
  <li><a href = "#특정문자치환"><code>특정문자치환</code></a></li>
</details>



<details><summary>인스턴스 메서드</summary> 
  <li><a href = "#enumerated"><code>enumerated</code></a></li>
  <li><a href = "#forEach"><code>forEach</code></a></li>
  <li><a href = "#zip"><code>zip</code></a></li>
</details>



<details><summary>알고리즘 Strategy</summary> 
  <li><a href = "#combination"><code>combination</code></a></li>
</details>



## 문자열 처리

### subString

```swift
// String subscript를 활용한 subString 가져오기
extension String {
    subscript(r: Range<Int>) -> String {
        let start = self.index(self.startIndex, offsetBy: r.lowerBound)
        let end = self.index(self.startIndex, offsetBy:  r.upperBound)
        
        return String(self[start..<end])
    }
}
```



### 특정문자삭제

```swift
var str = "!~@@@ String@~!!mmTest"
str.components(separatedBy: ["~","!","@",","]).joined() // String Test

```



### 특정문자치환

```swift
let str = "()(((()())(())()))(())"
let replacingStr = arrangement.replacingOccurrences(of: "()", with: "0")  //0(((00)(0)0))(0)
```





## 인스턴스 메서드

### enumerated 

```swift
// Sequence의 index 와 position의 pair로 접근
for (n, c) in "Swift".enumerated() {
    print("\(n): '\(c)'")
}
// Prints "0: 'S'"
// Prints "1: 'w'"
// Prints "2: 'i'"
// Prints "3: 'f'"
// Prints "4: 't'"
```



### zip

```swift
let names: Set = ["Sofia", "Camilla", "Martina", "Mateo", "Nicolás"]
var shorterIndices: [Set<String>.Index] = []
for (i, name) in zip(names.indices, names) {
    if name.count <= 5 {
        shorterIndices.append(i)
    }
}

for i in shorterIndices {
    print(names[i])
}
// Prints "Sofia"
// Prints "Mateo"
```



### forEach

map 과 동일한 기능을 하지만 `forEach` 의 경우 컨테이너를 반환하지 않고 단순하게 접근을 한다. 그렇기 때문에 값을 변경할려면 map을 사용, 단순 요소 접근은 `forEach` 를 사용하자.

```swift
let numberWords = ["one", "two", "three"]
numberWords.forEach { word in
    print(word)
}
// Prints "one"
// Prints "two"
// Prints "three"
```









## 알고리즘 Startegy

### combination

```swift
// nCk : n 개 중에 k 개의 조합 선택 index: 0~k 개의 선택된 개수, target 0~n개 중에서 하나를 선택, combi: 선택된 index의 조합
func combination(_ number:[Character],_ k: Int, combi: inout [Int], target: Int, n: Int, index: Int, list: inout [Int]) {
    if k == 0 {
        print(str)
        var comStr = ""
        for i in combi {
            comStr += String(number[i])
        }
        list.append(Int(comStr)!)
    }
    else if target == n {
        return
    }
    else {
        combi[index] = target
        combination(number, k - 1, combi: &combi, target: target + 1, n: n, index: index + 1, list: &list)
        combination(number, k, combi: &combi, target: target + 1, n: n, index: index, list: &list)
    }
}
```

