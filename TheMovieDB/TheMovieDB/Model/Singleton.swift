//
//  Singleton.swift
//  TheMovieDB
//
//  Created by MANZANO MARTINEZ, ALAIN MARIANO on 01/04/22.
//

import Foundation

private var objectSingleton = Singleton()

class Singleton
{
	
	var userLogin:String = ""
	var resultsResponse: Array<ResultsVO> =  Array<ResultsVO>()
	var categoriasMovies:Array<CategoriaMovies> = Array<CategoriaMovies>()

	fileprivate init()
	{
		
	}
	
	class var sharedInstance: Singleton
	{
		return objectSingleton
	}
	
	class func resetInstance () {
		objectSingleton = Singleton()
	}
}
