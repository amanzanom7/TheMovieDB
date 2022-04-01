//
//  CategoriaMovies.swift
//  TheMovieDB
//
//  Created by MANZANO MARTINEZ, ALAIN MARIANO on 01/04/22.
//

import UIKit

class CategoriaMovies: NSObject, NSCoding {
	
	var backdrop_path:String!
	var original_language:String!
	var original_title:String!
	var poster_path:String!
	var vote_average:Double!
	var vote_count:Int!
	var overview:String!
	var release_date:String!
	var title:String!
	var id:Int!
	var popularity:Float!
	var media_type:String!
	var off:Bool!
	
	override init() {
	
	}

	required  init?(coder aDecoder: NSCoder) {
		self.backdrop_path = aDecoder.decodeObject(forKey: "backdrop_path") as? String ?? ""
		self.original_language = aDecoder.decodeObject(forKey: "original_language") as? String ?? ""
		self.original_title = aDecoder.decodeObject(forKey: "original_title") as? String ?? ""
		self.poster_path = aDecoder.decodeObject(forKey: "poster_path") as? String ?? ""
		self.vote_average = aDecoder.decodeObject(forKey: "vote_average") as? Double ?? 0.0
		self.vote_count = aDecoder.decodeObject(forKey: "vote_count") as? Int ?? 0
		self.overview = aDecoder.decodeObject(forKey: "overview") as? String ?? ""
		self.release_date = aDecoder.decodeObject(forKey: "release_date") as? String ?? ""
		self.title = aDecoder.decodeObject(forKey: "title") as? String ?? ""
		self.id = aDecoder.decodeObject(forKey: "id") as? Int ?? 0
		self.popularity = aDecoder.decodeObject(forKey: "popularity") as? Float ?? 0.0
		self.media_type = aDecoder.decodeObject(forKey: "media_type") as? String ?? ""
		self.off = aDecoder.decodeObject(forKey: "off") as? Bool ?? false
	}

	func encode(with aCoder: NSCoder) {
		aCoder.encode(backdrop_path, forKey: "backdrop_path")
		aCoder.encode(original_language, forKey: "original_language")
		aCoder.encode(original_title, forKey: "original_title")
		aCoder.encode(poster_path, forKey: "poster_path")
		aCoder.encode(vote_average, forKey: "vote_average")
		aCoder.encode(vote_count, forKey: "vote_count")
		aCoder.encode(overview, forKey: "overview")
		aCoder.encode(release_date, forKey: "release_date")
		aCoder.encode(title, forKey: "title")
		aCoder.encode(id, forKey: "id")
		aCoder.encode(popularity, forKey: "popularity")
		aCoder.encode(media_type, forKey: "media_type")
		aCoder.encode(off, forKey: "off")

	}
}
