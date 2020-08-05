//
//  Podcasts.swift
//  PodcastApp
//
//  Created by Cian McLennan on 29/07/2020.
//

import Foundation

class PodcastParser: NSObject, XMLParserDelegate {
    
    private var elementName: String = String()
    private var attributes: [String : String] = [:];
    private var isInEpisode:Bool = false;
    private var podcast: Podcast?
    private var episode: Episode?
    
    override init() {
        super.init();
        if let path = Bundle.main.url(forResource: "podcast", withExtension: "xml") {
            if let parser = XMLParser(contentsOf: path) {
                self.podcast = Podcast(context: PodcastData.shared.context());
                parser.delegate = self
                parser.parse()
            }
        }
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        print(documentsDirectory);
    }
    // 1
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        self.elementName = elementName;
        if (elementName == "item") {
            isInEpisode = true;
            self.episode = Episode(context: PodcastData.shared.context());
            self.episode?.podcast = self.podcast;
        }
        self.attributes = attributeDict;
    }
    
    // 2
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if (elementName == "item") {
            PodcastData.shared.saveContext();
            isInEpisode = false;
        }
    }
    
    // 3
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if !data.isEmpty {
            if !isInEpisode {
                if self.elementName == "title" {
                    self.podcast?.title = data
                } else if self.elementName == "description" {
                    self.podcast?.summary = self.podcast?.summary ?? "" + data
                }
            } else {
                if self.elementName == "title" {
                    self.episode?.title = data
                } else if self.elementName == "description" {
                    self.episode?.summary = self.episode!.summary ?? "" + data
                } else if self.elementName == "itunes:episode" {
                    self.episode?.episode_number = Int64(data) ?? -1;
                } else if self.elementName == "pubDate" {
                    let df = DateFormatter()
                    df.locale = Locale(identifier: "en_US_POSIX")
                    df.dateFormat = "E, d MMM yyyy HH:mm:ss Z";
                    self.episode?.pub_date = df.date(from: data);
                }
            }
        } else if isInEpisode && self.elementName == "enclosure" {
            if let audioURL = self.attributes["url"],
               let type = self.attributes["type"],
               type.contains("audio") {
                self.episode?.content_url = URL(string:audioURL);
            }
        }
    }
}

