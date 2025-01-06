//
//  ForWidgetExtension.swift
//  ForWidgetExtension
//
//  Created by 황석현 on 1/6/25.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    
    /// 위젯의 초기 상태에 사용되는 UI
    /// - 데이터 갱신 : 정적(Static)
    /// - 사용시점 : 초기 로딩 상태
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent(), count: 0)
    }

    /// 위젯 갤러리 또는 미리보기에서 사용되는 샘플 데이터
    /// - 데이터 갱신 : 정적(Static)
    /// - 사용시점 : 미리보기, 위젯 갤러리
    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration, count: 0)
    }
    
    
    /// 시간에 따라 데이터 제공
    /// - 사용시점 : 실제 위젯 업데이트
    ///
    /// **타임라인 정책**
    /// - .atEnd: 마지막 엔트리를 표시한 후 타임라인을 새로고침
    /// - .after(Date): 특정 날짜 이후에 타임라인을 새로고침
    /// - .never: 타임라인이 새로고침되지 않음
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []
        let sharedUserDefaults = UserDefaults(suiteName: Utility.appId)
        let count = sharedUserDefaults?.integer(forKey: UserDefaultsKey.number) ?? 0

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .second, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration, count: count)
            entries.append(entry)
        }
        
        print("widget Count : \(count)")

        return Timeline(entries: entries, policy: .atEnd)
    }

//    func relevances() async -> WidgetRelevances<ConfigurationAppIntent> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
    let count: Int
}

struct ForWidgetExtensionEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("\(entry.count)")
                .font(.largeTitle)
        }
    }
}

struct ForWidgetExtension: Widget {
    let kind: String = "ForWidgetExtension"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            ForWidgetExtensionEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    ForWidgetExtension()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley, count: 0)
    SimpleEntry(date: .now, configuration: .starEyes, count: 0)
}
