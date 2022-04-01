	//
	//  ViewModelCollection.swift
	//  TheMovieDB
	//
	//  Created by MANZANO MARTINEZ, ALAIN MARIANO on 31/03/22.
	//
import Foundation


class ViewModelCollection: NSObject{
	
	let parcer:FeedBack = FeedBack()
	var resultsResponse: Array<ResultsVO> =  Array<ResultsVO>()
	var detail:DetailVO = DetailVO()
	
	func retrieveData(endpoint:String){
		
		let json = 	self.parcer.callWebService(Data(), endpoint: endpoint,post: false,parameter: false, stringParameter: "")
		let obj = CollectionPopular(json.getData())
		resultsResponse = obj.results
	}
	
	func retrieveDataDetail(endpoint:String,parameter: Bool, stringParameter: String){
		
		let json = 	self.parcer.callWebService(Data(), endpoint: endpoint,post: false,parameter: parameter, stringParameter: stringParameter)
		detail = DetailVO(json.getData())
		var pos = 0
		for obj in detail.production_companies
		{

			if obj.logo_path.isEmpty 
			{
				detail.production_companies.remove(at: pos)
			}
			pos = pos + 1
		}
	}
}

