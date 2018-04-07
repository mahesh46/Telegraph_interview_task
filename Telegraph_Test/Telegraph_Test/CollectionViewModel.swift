//
//  CollectionViewModel.swift
//  Telegraph_test
//
//  Created by Administrator on 04/04/2018.
//  Copyright © 2018 mahesh lad. All rights reserved.
//

import Foundation
struct author  {
    let name: String?
    let headshot: String?
    let twitter: String?

}
struct websiteData {
    let webData : [Collection]?
}

struct Collection {
    let id: Int?
    let websiteUrl: URL?
    let headline : String?
    let description: String?
    let articleBody: String?
    let ratings : Int?
    let pictureUrl : String?
    let videoUrl: URL?
    let actors : [String]?
    let director: String?
    let genre : [String]?
    let synopsis : String?
    let releaseDate : String?
    let duration: String?
    let publishedDate : String?
    let author : author?
 
}


class CollectionViewModel {
    
    private var collection: Collection
    
    init(collection: Collection) {
        self.collection =  collection
    }
    
    var id: Int? {
        return collection.id
    }
    
    var websiteUrl: URL? {
        return collection.websiteUrl
    }
    
    var headline: String? {
        return collection.headline
    }
    
    var description: String? {
        return collection.description
    }
    var articleBody: String? {
        return collection.articleBody
    }
    var ratings: Int? {
        return collection.ratings
    }
    var pictureUrl: String? {
        return collection.pictureUrl
    }
    var videoUrl: URL? {
        return collection.videoUrl
    }
    var actors: [String]? {
        return collection.actors
    }
    var director: String? {
        return collection.director
    }
    var genre: [String]? {
        return collection.genre
    }
    var synopsis: String? {
        return collection.synopsis
    }
    var releaseDate: String? {
        return collection.releaseDate
    }
   
    var duration: String? {
        return collection.duration
    }
    var publishedDate: String? {
        return collection.publishedDate
    }
    var author: author? {
        return collection.author
    }
  
}
