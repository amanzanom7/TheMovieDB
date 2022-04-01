//
//  CollectionPopular.swift
//  TheMovieDB
//
//  Created by MANZANO MARTINEZ, ALAIN MARIANO on 31/03/22.
//

class CollectionPopular: JSONJoy{
	
	var results: Array<ResultsVO> =  Array<ResultsVO>()
	
	init(){}

	required init(_ decoder: JSONDecoder) {

		if let arrDecode = decoder["results"].array {
			results = Array<ResultsVO>()

			for obj in arrDecode {
				results.append(ResultsVO(obj))
			}
		}
	}
	
}
class ResultsVO:JSONJoy{
	var adult:Bool!
	var backdrop_path:String = ""
	var original_language:String = ""
	var original_title:String = ""
	var poster_path:String = ""
	var vote_average:Double
	var vote_count:Int
	var overview:String = ""
	var release_date:String = ""
	var title:String = ""
	var id:Int
	var popularity:Float
	var media_type:String = ""


	required init(_ decoder: JSONDecoder) {
		
		adult   = decoder["adult"].bool
		backdrop_path   = decoder["backdrop_path"].string != nil ? decoder["backdrop_path"].string! : ""
		original_language   = decoder["original_language"].string != nil ? decoder["original_language"].string! : ""
		original_title   = decoder["original_title"].string != nil ? decoder["original_title"].string! : ""
		poster_path   = decoder["poster_path"].string != nil ? decoder["poster_path"].string! : ""
		vote_average   = decoder["vote_average"].double != nil ? decoder["vote_average"].double! : 0.0
		vote_count   = decoder["vote_count"].integer != nil ? decoder["vote_count"].integer! : 0
		overview   = decoder["overview"].string != nil ? decoder["overview"].string! : ""
		release_date   = decoder["release_date"].string != nil ? decoder["release_date"].string! : ""
		title   = decoder["title"].string != nil ? decoder["title"].string! : ""
		id   = decoder["id"].integer != nil ? decoder["id"].integer! : 0
		popularity   = decoder["popularity"].float != nil ? decoder["popularity"].float! : 0.0
		media_type   = decoder["media_type"].string != nil ? decoder["media_type"].string! : ""

	}
}


class DetailVO:JSONJoy{
	var adult:Bool!
	var backdrop_path:String!
	var belongs_to_collection:BelongVO!
	var genres: Array<GeneroVO> =  Array<GeneroVO>()
	var poster_path:String!
	var vote_average:Double!
	var vote_count:Int!
	var overview:String!
	var release_date:String!
	var title:String!
	var id:Int!
	var popularity:Float!
	var tagline:String!
	var production_companies: Array<ProductCompaniesVO> =  Array<ProductCompaniesVO>()
	
	init () {
	}
	
	required init(_ decoder: JSONDecoder) {
		
		adult   = decoder["adult"].bool
		backdrop_path   = decoder["backdrop_path"].string != nil ? decoder["backdrop_path"].string! : ""
		belongs_to_collection = BelongVO(decoder["belongs_to_collection"])
		poster_path   = decoder["poster_path"].string != nil ? decoder["poster_path"].string! : ""
		vote_average   = decoder["vote_average"].double != nil ? decoder["vote_average"].double! : 0.0
		vote_count   = decoder["vote_count"].integer != nil ? decoder["vote_count"].integer! : 0
		overview   = decoder["overview"].string != nil ? decoder["overview"].string! : ""
		release_date   = decoder["release_date"].string != nil ? decoder["release_date"].string! : ""
		title   = decoder["title"].string != nil ? decoder["title"].string! : ""
		id   = decoder["id"].integer != nil ? decoder["id"].integer! : 0
		popularity   = decoder["popularity"].float != nil ? decoder["popularity"].float! : 0.0

		if let arrDecode = decoder["genres"].array {
			genres = Array<GeneroVO>()

			for obj in arrDecode {
				genres.append(GeneroVO(obj))
			}
		}
		
		if let arrDecode = decoder["production_companies"].array {
			production_companies = Array<ProductCompaniesVO>()

			for obj in arrDecode {
				production_companies.append(ProductCompaniesVO(obj))
			}
		}
	}
}
class BelongVO: JSONJoy{
	
	var id:Int!
	var name:String!
	var poster_path:String!
	var backdrop_path:String!


	required init(_ decoder: JSONDecoder) {

		name   = decoder["name"].string != nil ? decoder["name"].string! : ""
		id   = decoder["id"].integer != nil ? decoder["id"].integer! : 0
		poster_path   = decoder["poster_path"].string != nil ? decoder["poster_path"].string! : ""
		backdrop_path   = decoder["backdrop_path"].string != nil ? decoder["backdrop_path"].string! : ""
	}
	
}
class GeneroVO: JSONJoy{
	
	var id:Int
	var name:String = ""


	required init(_ decoder: JSONDecoder) {

		name   = decoder["name"].string != nil ? decoder["name"].string! : ""
		id   = decoder["id"].integer != nil ? decoder["id"].integer! : 0
	}
	
}
class ProductCompaniesVO: JSONJoy{
	
	var id:Int
	var logo_path:String = ""
	var name:String = ""
	var origin_country:String = ""

	required init(_ decoder: JSONDecoder) {

		id   = decoder["id"].integer != nil ? decoder["id"].integer! : 0
		logo_path   = decoder["logo_path"].string != nil ? decoder["logo_path"].string! : ""
		name   = decoder["name"].string != nil ? decoder["name"].string! : ""
		origin_country   = decoder["origin_country"].string != nil ? decoder["origin_country"].string! : ""

	}
	
}
