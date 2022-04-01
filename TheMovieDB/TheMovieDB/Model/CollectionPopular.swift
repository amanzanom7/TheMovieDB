//
//  CollectionPopular.swift
//  TheMovieDB
//
//  Created by MANZANO MARTINEZ, ALAIN MARIANO on 31/03/22.
//

import Foundation

class CollectionPopular: JSONJoy{
	
	var results: Array<ResultsVO> =  Array<ResultsVO>()
	
	init(){}

	required init(_ decoder: JSONDecoder) {

		if let arrDecode = decoder["results"].array {
			results = Array<ResultsVO>()

			for balance in arrDecode {
				results.append(ResultsVO(balance))
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
