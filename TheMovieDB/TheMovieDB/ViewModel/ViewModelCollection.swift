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
	
	func retrieveData(endpoint:String){
		
		let json = 	self.parcer.callWebService(Data(), endpoint: endpoint,post: false)
		let obj = CollectionPopular(json.getData())
		resultsResponse = obj.results
	}
	
}

