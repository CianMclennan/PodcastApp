//
//  Podcasts.swift
//  PodcastApp
//
//  Created by Cian McLennan on 29/07/2020.
//

import Foundation

struct Podcast: Identifiable {
    let id = UUID()
    var title: String = String()
    var description: String = String()
    var image : URL?
    var episodes: [Episode] = []
}

struct Episode: Identifiable {
    let id = UUID()
    var title: String = String()
    var description: String = String()
    var imageURL : String = String()
    var audioURL: String = String()
}

class PodcastParser: NSObject, XMLParserDelegate {
    
    var elementName: String = String()
    var attributes: [String : String] = [:];
    var isInEpisode:Bool = false;
    var podcast = Podcast()
    var episode = Episode()
    
    override init() {
        super.init();
        if let path = Bundle.main.url(forResource: "podcast", withExtension: "xml") {
            if let parser = XMLParser(contentsOf: path) {
                parser.delegate = self
                parser.parse()
            }
        }
    }
    // 1
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        self.elementName = elementName;
        if (elementName == "item") {
            isInEpisode = true;
            self.episode = Episode();
        }
        self.attributes = attributeDict;
    }

    // 2
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if (elementName == "item") {
            isInEpisode = false;
            self.podcast.episodes.append(self.episode);
        }
    }

    // 3
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

        if !data.isEmpty {
            if !isInEpisode {
                if self.elementName == "title" {
                    self.podcast.title = data
                } else if self.elementName == "description" {
                    self.podcast.description += data
                }
            } else {
                if self.elementName == "title" {
                    self.episode.title = data
                } else if self.elementName == "description" {
                    self.episode.description += data
                } else if self.elementName.contains("media") {
                    print(data)
                }
            }
        } else if self.elementName == "media:content" {
            if let audioURL = self.attributes["url"],
               let type = self.attributes["type"],
               type.contains("audio") {
                self.episode.audioURL = audioURL
            }
        }
    }
}

let testData = [
    Podcast(title: "Example Podcast", description: "this is a podcast", image: nil),
    Podcast(title: "Example Podcast2", description: "this is also a podcast", image: nil)
]

