//
//  progresoWidgetLiveActivity.swift
//  progresoWidget
//
//  Created by Rod Espiritu Berra on 24/04/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct progresoWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct progresoWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: progresoWidgetAttributes.self) { context in
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

extension progresoWidgetAttributes {
    fileprivate static var preview: progresoWidgetAttributes {
        progresoWidgetAttributes(name: "World")
    }
}

extension progresoWidgetAttributes.ContentState {
    fileprivate static var smiley: progresoWidgetAttributes.ContentState {
        progresoWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: progresoWidgetAttributes.ContentState {
         progresoWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: progresoWidgetAttributes.preview) {
   progresoWidgetLiveActivity()
} contentStates: {
    progresoWidgetAttributes.ContentState.smiley
    progresoWidgetAttributes.ContentState.starEyes
}
