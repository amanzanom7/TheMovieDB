//
//  LoginVO.swift
//  TheMovieDB
//
//  Created by MANZANO MARTINEZ, ALAIN MARIANO on 30/03/22.
//

import Foundation

struct LoginToken: Codable{
	var success: Bool = false
	var expires_at:String = ""
	var request_token:String = ""
	
}

struct LoginValidate: Codable{
	var username:String = ""
	var password:String = ""
	var request_token:String = ""
	
	init(username:String, password:String, request_token:String)
	{
		self.username = username
		self.password = password
		self.request_token = request_token
	}
}
