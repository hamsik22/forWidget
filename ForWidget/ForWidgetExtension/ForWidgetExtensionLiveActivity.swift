//
//  ForWidgetExtensionLiveActivity.swift
//  ForWidgetExtension
//
//  Created by 황석현 on 1/6/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct ForWidgetExtensionAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct ForWidgetExtensionLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: ForWidgetExtensionAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension ForWidgetExtensionAttributes {
    fileprivate static var preview: ForWidgetExtensionAttributes {
        ForWidgetExtensionAttributes(name: "World")
    }
}

extension ForWidgetExtensionAttributes.ContentState {
    fileprivate static var smiley: ForWidgetExtensionAttributes.ContentState {
        ForWidgetExtensionAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: ForWidgetExtensionAttributes.ContentState {
         ForWidgetExtensionAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: ForWidgetExtensionAttributes.preview) {
   ForWidgetExtensionLiveActivity()
} contentStates: {
    ForWidgetExtensionAttributes.ContentState.smiley
    ForWidgetExtensionAttributes.ContentState.starEyes
}
