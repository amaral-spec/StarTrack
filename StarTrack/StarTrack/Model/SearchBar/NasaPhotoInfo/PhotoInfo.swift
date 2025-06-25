//
//  PhotoInfo.swift
//  StarTrack
//
//  Created by Aluno 14 on 6/11/25.
//

import Foundation

struct PhotoInfo: Codable {
    var title: String
    var description: String
    var url: URL?
    var copyright: String?
    var date: String
    
    enum CodingKeys: String, CodingKey{
        case title = "title"
        case description = "explanation"
        case url = "url"
        case copyright = "copyright"
        case date = "date"
    }
    
    init(from decoder: Decoder) throws{
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        self.title = try valueContainer.decode(String.self, forKey: CodingKeys.title)
        self.description = try valueContainer.decode(String.self, forKey: CodingKeys.description)
        self.url = try valueContainer.decode(URL.self, forKey: CodingKeys.url)
        self.copyright = try? valueContainer.decode(String.self, forKey: CodingKeys.copyright)
        self.date = try valueContainer.decode(String.self, forKey: CodingKeys.date)
    }
    
    init() {
        self.description = ""
        self.title = ""
        self.date = ""
    }
    
    static func createDefault() -> PhotoInfo{
        var photoInfo = PhotoInfo()
        photoInfo.title = "25 Brightest Stars in the Night Sky"
        photoInfo.description = "Do you know the names of some of the brightest stars? It's likely that you do, even though some bright stars have names so old they date back to near the beginning of written language. Many world cultures have their own names for the brightest stars, and it is culturally and historically important to remember them. In the interest of clear global communication, however, the International Astronomical Union (IAU) has begun to designate standardized star names. Featured here in true color are the 25 brightest stars in the night sky, currently as seen by humans, coupled with their IAU-recognized names. Some star names have interesting meanings, including Sirius ('the scorcher' in Latin), Vega ('falling' in Arabic), and Antares ('rival to Mars' in Greek). You are likely even familiar with the name of at least one star too dim to make this list: Polaris."
        photoInfo.date = "2025-06-11"
        return photoInfo
    }
}
