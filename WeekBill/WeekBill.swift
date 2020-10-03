//
//  WeekBill.swift
//  WeekBill
//
//  Created by Attempt D on 2020/9/27.
//  Copyright © 2020 Frank D. All rights reserved.
//

import WidgetKit
import SwiftUI
import Intents
import SwiftUICharts

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct WeekBillEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family: WidgetFamily

    var body: some View {
        HStack(alignment: .top, spacing: nil){
            Text("35345")
                .background(Color.yellow)
        }.frame(minWidth: 0,  maxWidth: .infinity, minHeight: 0,  maxHeight: .infinity, alignment: .top)
        .background(ContainerRelativeShape().fill(Color.init(.sRGB, red: 0.89, green: 0.89, blue: 0.89, opacity: 0.75)))

    }
}

@main
struct WeekBill: Widget {
    let kind: String = "WeekBill"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            WeekBillEntryView(entry: entry)
                
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        
        .supportedFamilies([.systemLarge,.systemMedium,.systemSmall])
    }
}

struct WeekBill_Previews: PreviewProvider {
    static var previews: some View {
        WeekBillEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
