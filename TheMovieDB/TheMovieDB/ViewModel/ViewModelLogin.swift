//
//  ViewModelLogin.swift
//  TheMovieDB
//
//  Created by MANZANO MARTINEZ, ALAIN MARIANO on 30/03/22.
//

import Foundation


class ViewModelLogin: NSObject{
	
	
	var refreshData = { ( ) -> () in }
//	let decoder = JSONDecoder()

	var loginToken = LoginToken()
	let parcer:FeedBack = FeedBack()

	func retrieveData(endpoint:String){
		
		let json = 	self.parcer.callWebService(Data(), endpoint: "/token/new?api_key=",post: false)
		self.loginToken = LoginToken(json.getData())

	}
	
	func sendData(endpoint:String, user:String, pass:String) -> AnyObject
	{
		let userRequest = user
		let passRequest = pass
		let token = self.loginToken.request_token
		var objAnyObject:AnyObject = LoginMessage()
		if !token.isEmpty
		{
			
			let logValidate = LoginValidate.init(username: userRequest, password: passRequest, request_token: token)
			
			let json = JSONSerializer.toJson(logValidate)
			print("json: \(json)")
			
			let data = json.data(using: String.Encoding.utf8)!
			
			let jsonResponse = parcer.callWebService(data, endpoint: "/token/validate_with_login?api_key=",post: true)
			let valida = LoginMessage(jsonResponse.getData())
			if !valida.success
			{
			      objAnyObject  = valida
				
			}else {
				let loginExitoso = LoginToken(jsonResponse.getData())
			      objAnyObject = loginExitoso
			}
				//objLoginMessage = try decoder.decode(LoginMessage.self, from: jsonResponse)
			
		}else {
			print(" \(NSLocalizedString("lblLoginValidate", comment: "Invalid user or password"))")
		}
		
		return objAnyObject
	}

}
