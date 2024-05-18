//
//  Progreso.swift
//  Progreso
//
//  Created by iOS Lab on 24/04/24.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct ProgresoEntryView : View {
    var entry: Provider.Entry
    let colorP = ColorPalette()
    var body: some View {
        ProgressContainer()
            .cornerRadius(15)
            .frame(width: 170, height: 170)
            .border(colorP.rojo , width: 0)
            .padding(7)
            .background(Color.red)
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(colorP.rojo, lineWidth: 0)
            )
    }
    
}
struct CircularProgressView: View {
    let progress: Double
    
    var body: some View {
        let colorP = ColorPalette()
        ZStack {
            Circle()
                .stroke(
                    Color(colorP.gris).opacity(0.5),
                    lineWidth: 20
                )
                .frame(width: 90, height: 90)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color(colorP.barraBlanco),
                    style: StrokeStyle(
                        lineWidth: 20,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .frame(width: 90, height: 90)
            

            Text(String(format: "%.0f%%", progress * 100))
                .font(.headline)
                .foregroundColor(Color.white)
        }

    }
}


struct ProgressContainer: View {
    let colorP = ColorPalette()
    var body: some View {
        ZStack {
            Color(colorP.rojoClaro)
                .edgesIgnoringSafeArea(.all)
                    CircularProgressView(progress: 0.6)
                        .padding(.horizontal)
                }
            }
        }


struct ColorPalette {
    let rojo = Color.init(red: 234/255, green: 0/255, blue: 41/255)
    let rojoClaro = Color.init(red: 255/255, green: 33/255, blue: 64/255)
    let gris = Color.init(red: 237/255, green: 237/255, blue: 237/255)
    let c4 = Color.init(red: 221/255, green: 246/255, blue: 226/255)
    let c5 = Color.init(red: 119/255, green: 220/255, blue: 137/255)
    let barraBlanco = Color.init(red: 255/255, green: 255/255, blue: 255/255)
    let grisOscuro = Color.init(red: 100/255, green: 100/255, blue: 100/255)
}


struct Progreso: Widget {
    let kind: String = "Progreso"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            ProgresoEntryView(entry: entry)
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
    Progreso()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley)
    SimpleEntry(date: .now, configuration: .starEyes)
}
