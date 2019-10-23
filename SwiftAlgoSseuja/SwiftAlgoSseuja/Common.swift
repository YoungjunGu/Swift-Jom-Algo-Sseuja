//
//  Common.swift
//  SwiftAlgoSseuja
//
//  Created by youngjun goo on 2019/10/23.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import Foundation

// String subscript를 활용한 subString 가져오기
extension String {
    subscript(r: Range<Int>) -> String {
        let start = self.index(self.startIndex, offsetBy: r.lowerBound)
        let end = self.index(self.startIndex, offsetBy:  r.upperBound)
        
        return String(self[start..<end])
    }
}
