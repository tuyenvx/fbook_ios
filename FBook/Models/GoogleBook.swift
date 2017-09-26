//
//  GoogleBook.swift
//  FBook
//
//  Created by Huy Pham on 9/26/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import ObjectMapper

struct GoogleBook: Mappable {

    var id = ""
    var title = ""
    var subtitle = ""
    var authors: [String] = []
    var publisher = ""
    var description = ""
    var printType = ""
    var categories: [String] = []
    var averageRating = 0
    var ratingsCount = 0
    var maturityRating = ""
    var allowAnonLogging = false
    var contentVersion = ""
    var thumbnail = ""
    var language = ""
    var previewLink = ""
    var infoLink = ""
    var canonicalVolumeLink = ""

    init?(map: Map) {
        mapping(map: map)
    }

    mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["volumeInfo.title"]
        subtitle <- map["volumeInfo.subtitle"]
        authors <- map["volumeInfo.authors"]
        publisher <- map["volumeInfo.publisher"]
        description <- map["volumeInfo.description"]
        printType <- map["volumeInfo.printType"]
        categories <- map["volumeInfo.categories"]
        averageRating <- map["volumeInfo.averageRating"]
        ratingsCount <- map["volumeInfo.ratingsCount"]
        maturityRating <- map["volumeInfo.maturityRating"]
        allowAnonLogging <- map["volumeInfo.allowAnonLogging"]
        contentVersion <- map["volumeInfo.contentVersion"]
        thumbnail <- map["volumeInfo.imageLinks.thumbnail"]
        language <- map["volumeInfo.language"]
        previewLink <- map["volumeInfo.previewLink"]
        infoLink <- map["volumeInfo.infoLink"]
        canonicalVolumeLink <- map["volumeInfo.canonicalVolumeLink"]
    }
}
