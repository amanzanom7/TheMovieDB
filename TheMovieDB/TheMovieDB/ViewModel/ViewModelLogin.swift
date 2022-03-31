//
//  ViewModelLogin.swift
//  TheMovieDB
//
//  Created by MANZANO MARTINEZ, ALAIN MARIANO on 30/03/22.
//

import Foundation


class ViewModelLogin{
	
	
	var refreshData = { ( ) -> () in }
	
	var loginToken = LoginToken()
	
	func retrieveData(endpoint:String){
		
		var contURL = Util.getDataPlistFile(nameString: "urlAuth") as? String
		contURL = contURL! + endpoint + Util.Encabezado.login
		guard let url = URL (string: contURL!) else { return }
		
		URLSession.shared.dataTask(with: url) { (data, response, error) in
			guard let json = data else { return }
			
			
			if error == nil && data != nil
			{
				let decoder = JSONDecoder()
				
				do {
					self.loginToken = try decoder.decode(LoginToken.self, from: json)
					print("response \(self.loginToken.request_token)")
				}catch let error {
					print("Oh no... un error en la matrixx: \(error.localizedDescription)")
				}
			}
			
		}.resume()
	}
	
	func sendData(endpoint:String, user:String, pass:String){
		
		var contURL = Util.getDataPlistFile(nameString: "urlAuth") as? String
		contURL = contURL! + endpoint + Util.Encabezado.login
		guard let url = URL (string: contURL!) else { return }
		
		let userRequest = user
		let passRequest = pass
		let token = loginToken.request_token
		
		let logValidate = LoginValidate.init(username: userRequest, password: passRequest, request_token: token)
		do{
		var callPetition = URLRequest(url: url)
		callPetition.httpMethod = "POST"
		callPetition.addValue("application/json", forHTTPHeaderField: "Content-Type")
		callPetition.httpBody = try JSONEncoder().encode(logValidate)
			
			URLSession.shared.dataTask(with: callPetition) { (data, response, error) in
				guard let json = data else { return }
				
				
				if error == nil && data != nil
				{
					let decoder = JSONDecoder()
					
					do {
						let feedback = try decoder.decode(LoginToken.self, from: json)
						print("response \(feedback)")
					}catch let error {
						print("Oh no... un error en la matrixx: \(error.localizedDescription)")
					}
				}
				
			}.resume()
			
		}catch  let error {
			print("Oh no... un error en la matrixx: \(error.localizedDescription)")
		}
		

	}
	
}
