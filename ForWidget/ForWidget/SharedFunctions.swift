//
//  SharedFunctions.swift
//  ForWidget
//
//  Created by 황석현 on 1/6/25.
//

import Foundation
import WidgetKit

/// 위젯과 앱이 공통으로 사용하는 기능들
class SharedFunctions {
    let sharedDefaults = UserDefaults(suiteName: Utility.appId)
    func saveNumber(number: Int) -> Int {
        sharedDefaults?.set((number + 1), forKey: UserDefaultsKey.number)
        
        WidgetCenter.shared.reloadAllTimelines()
        print("app : \(sharedDefaults?.integer(forKey: UserDefaultsKey.number) ?? 0)")
        
        return number + 1
    }
    
}
