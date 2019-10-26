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



<details><summary>Swift Math</summary> 
  <li><a href = "#최대공약수"><code>최대공약수</code></a></li>
  <li><a href = "#최소공배수"><code>최소공배수</code></a></li>
</details>  



<details><summary>Swift 자료구조</summary> 
  <li><a href = "#PriorityQueue"><code>PriorityQueue</code></a></li>
</details>  



<details><summary>알고리즘 Strategy</summary> 
  <li><a href = "#combination"><code>combination</code></a></li>
  <li><a href = "#Dijkstra"><code>Dijkstra</code></a></li>
</details>  



</br>
</hr>

# 문자열 처리

### subString
<details><summary>코드 보기</summary>
  
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
</details>


### 특정문자삭제
<details><summary>코드 보기</summary>
  
```swift
var str = "!~@@@ String@~!!mmTest"
str.components(separatedBy: ["~","!","@",","]).joined() // String Test

```
</details>



### 특정문자치환
<details><summary>코드 보기</summary>

```swift
let str = "()(((()())(())()))(())"
let replacingStr = arrangement.replacingOccurrences(of: "()", with: "0")  //0(((00)(0)0))(0)
```

</details>

</br>
</hr>

# 인스턴스 메서드


### enumerated 
<details><summary>코드 보기</summary>
  
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
</details>



### zip
<details><summary>코드 보기</summary>
  
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
</details>



### forEach
<details><summary>코드 보기</summary>
  
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
</details>  

</br>
</hr>

# Swift Math  

### 최대공약수  
<details><summary>코드 보기</summary>

```swift
func gcd(num1: Int, num2: Int) -> Int {
    let mod = num1 % num2
    if mod != 0 {
        return gcd(num1: num2, num2: mod)
    }
    return num2
}  
```  
</details>  

### 최소공배수  
<details><summary>코드 보기</summary>
- 두 수의 최소공배수
  
```swift
func lcm1(num1: Int, num2: Int) -> Int {
    return abs(num1 * num2) / gcd(num1: num1, num2: num2)
}  
```

- 두수 이상의 최소 공배수 

```swift
func lcm2(arr1: [Int]) -> Int {
    return arr1.reduce(1) { lcm1(num1: $0, num2: $1) }
}
```
</details>  

</br>
</hr>


# Swift 자료구조  

### PriorityQueue
<details><summary>코드 보기</summary>
- push(): heap에 값을 삽입
- pop(): heap root 반환
- adjust() : heap에 값을 추가하고 min/max heap을 유지하기위하 함수
- heapSort(): heap을 재정렬  

```swift
import Foundation

public struct PriorityQueue<T: Comparable> {
    private var heap = [T]()
    private let ordered: (T, T) -> Bool
    
    public init(ascending: Bool = false, startingValues: [T] = []) {
        if ascending {
            ordered = { a,b in a > b }
        } else {
            ordered = { a,b in a < b }
        }
        
        heap = startingValues
        var i = (heap.count / 2) - 1
        while i >= 0 {
            adjust(i)
            i = i - 1
        }
    }
    
    public var count: Int {
        return heap.count
    }
    
    public var isEmpty: Bool {
        return heap.isEmpty
    }
    
    public mutating func push(_ element: T) {
        heap.append(element)
        heapSort(heap.count - 1)
    }
    
    public mutating func pop() -> T? {
        if heap.isEmpty { return nil }
        if heap.count == 1 {
            return heap.removeFirst()
        }
        
        let root = heap.first
        heap.swapAt(0, heap.count - 1)
        _ = heap.removeLast()
        adjust(0)
        return root
    }
    
    public mutating func remove(_ item: T) {
        if let index = heap.firstIndex(of: item) {
            heap.swapAt(index, heap.count - 1)
            heap.removeLast()
            heapSort(index)
            adjust(index)
        }
    }
    
    public mutating func removeAll(_ item: T) {
        var lastCount = heap.count
        remove(item)
        while heap.count < lastCount {
            lastCount = heap.count
            remove(item)
        }
    }
    
    public func peek() -> T? {
        return heap.first
    }
    
    public mutating func clear() {
        heap.removeAll(keepingCapacity: false)
    }
    
    private mutating func adjust(_ index: Int) {
        var index = index
        while 2 * index + 1 < heap.count {
            var j = 2 * index + 1
            if j < (heap.count - 1) && ordered(heap[j], heap[j + 1]) { j = j + 1 }
            if !ordered(heap[index], heap[j]) { break }
            heap.swapAt(index, j)
            index = j
        }
    }
    
    private mutating func heapSort(_ index: Int) {
        var index = index
        while index > 0 && ordered(heap[(index - 1) / 2], heap[index]) {
            heap.swapAt((index - 1) / 2, index)
            index = (index - 1) / 2
        }
    }
}
```
</details>  

</br>
</hr>


# 알고리즘 Startegy

### combination

<details><summary>코드 보기</summary>

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
</details>  

### Dijkstra

<details><summary>코드 보기</summary>
  
- distance: 시작 vertex에서 갈 수 있는(pathLegnth가 존재하는) 모든 shortestPath 정보  
- matrix : weight 값을 가지는 undirected graph의 인접행렬
- visited : 재방문을 방지하는 배열
  
```swift
unc shortestPath(_ distance: inout [Int],_ matrix: [[Int]], _ visited: inout [Bool], _ N: Int) {
    var nextVertex: Int
    // 1 부터 시작
    distance[1] = 0
    
    for i in 1...N {
        distance[i] = matrix[1][i]
    }
    
    distance[1] = 0
    visited[1] = false
    for _ in 1...N-2 {
        nextVertex = selectPath(distance, N, visited)
        visited[nextVertex] = false
        for j in 1...N {
            if visited[j] {
                if distance[nextVertex] + matrix[nextVertex][j] < distance[j] {
                    distance[j] = distance[nextVertex] + matrix[nextVertex][j]
                }
            }
        }
    }
}

func selectPath(_ distance: [Int], _ N: Int, _ visited: [Bool]) -> Int {
    var minWeight = 987654321
    var minPosition = -1
    
    for i in 1...N {
        if minWeight > distance[i] && visited[i] {
            minWeight = distance[i]
            minPosition = i
        }
    }
    return minPosition
}
```
</details>  
    
