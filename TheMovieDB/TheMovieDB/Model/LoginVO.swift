//
//  LoginVO.swift
//  TheMovieDB
//
//  Created by MANZANO MARTINEZ, ALAIN MARIANO on 30/03/22.
//

import Foundation

class LoginToken: JSONJoy{
	var success: Bool = false
	var expires_at:String = ""
	var request_token:String = ""
	
	init(){}

	required init(_ decoder: JSONDecoder) {

		success           = decoder["success"].bool
		expires_at    = decoder["expires_at"].string != nil ? decoder["expires_at"].string! : ""
		request_token = decoder["request_token"].string != nil ? decoder["request_token"].string! : ""
	}
	
}

class LoginValidate: JSONJoy{
	var username:String = ""
	var password:String = ""
	var request_token:String = ""
	
	init(){}
	
	init(username:String, password:String, request_token:String)
	{
		self.username = username
		self.password = password
		self.request_token = request_token
	}
	required init(_ decoder: JSONDecoder) {

	}
}

class LoginMessage: JSONJoy{
	var success: Bool = false
	var status_code:String = ""
	var status_message:String = ""
	
	init(){}

	required init(_ decoder: JSONDecoder) {

		success           = decoder["success"].bool
		status_code    = decoder["status_code"].string != nil ? decoder["status_code"].string! : ""
		status_message = decoder["status_message"].string != nil ? decoder["status_message"].string! : ""
	}
}
