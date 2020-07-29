//
//  PodcastAppApp.swift
//  Shared
//
//  Created by Cian McLennan on 29/07/2020.
//

import SwiftUI

let feed = XMLParser(contentsOf: URL(fileReferenceLiteralResourceName: "podcast.xml"))

@main
struct PodcastApplication: App {
    let test = PodcastParser().podcast;
    var body: some Scene {
        WindowGroup {
            ContentView(podcasts: [
                test
            ])
        }
    }
}
