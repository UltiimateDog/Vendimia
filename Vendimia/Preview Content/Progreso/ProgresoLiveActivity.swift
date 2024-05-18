//
//  ProgresoLiveActivity.swift
//  Progreso
//
//  Created by iOS Lab on 24/04/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct ProgresoAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct ProgresoLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: ProgresoAttributes.self) { context in
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

extension ProgresoAttributes {
    fileprivate static var preview: ProgresoAttributes {
        ProgresoAttributes(name: "World")
    }
}

extension ProgresoAttributes.ContentState {
    fileprivate static var smiley: ProgresoAttributes.ContentState {
        ProgresoAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: ProgresoAttributes.ContentState {
         ProgresoAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: ProgresoAttributes.preview) {
   ProgresoLiveActivity()
} contentStates: {
    ProgresoAttributes.ContentState.smiley
    ProgresoAttributes.ContentState.starEyes
}
