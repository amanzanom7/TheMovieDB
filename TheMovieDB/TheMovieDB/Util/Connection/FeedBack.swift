
import Foundation


fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
	return l < r
  case (nil, _?):
	return true
  default:
	return false
  }
}



fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
	return l > r
  default:
	return rhs < lhs
  }
}



class FeedBack: NSObject, URLSessionDelegate
{

	var iTimeOut:Int = 60
	var callPetition = NSMutableURLRequest()
	var dataResponse:Data = Data()
	var stringResponse:String = ""
	var delete:Bool = false
	override init()
	{
		super.init()

	}

	

	func callWebService(_ request: Data, endpoint:String, post:Bool, parameter:Bool, stringParameter:String) -> Data
	{

		var contURL = Util.getDataPlistFile(nameString: "urlBase") as? String
		contURL = contURL! + endpoint + Util.Encabezado.login
		if parameter
		{
			contURL = contURL! + stringParameter
		}
		guard let url = URL (string: contURL!) else { return Data() }
		
		let timeOut:TimeInterval = TimeInterval(iTimeOut)
		
		callPetition = NSMutableURLRequest(url: url, cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData, timeoutInterval: timeOut)
		if post {
			callPetition.httpMethod = "POST"
			callPetition.addValue("application/json", forHTTPHeaderField: "Content-Type")
			callPetition.httpBody = request
		}else if self.delete
		{
			callPetition.httpMethod = "DELETE"
			callPetition.addValue("application/json", forHTTPHeaderField: "Content-Type")
			callPetition.httpBody = request
		}
		

		if Util.netStatus() == Reachability.NetworkStatus.notReachable
		{

			return Data()
		}
		print("\n************\n")
		print("Peticion WS")
		print("\n************\n")
		print(contURL! as String)
		print("\n************\n")
		
		self.forData { jsonString in
		}


		return self.dataResponse
	}


	func forData(_ completion: (NSString) -> ()) {


			let config = URLSessionConfiguration.default

			config.timeoutIntervalForRequest = TimeInterval(iTimeOut)
			let session = URLSession(configuration: config, delegate: self, delegateQueue: nil)
			let task = session.synchronousDataTask(callPetition as URLRequest)
			if let data = task.0,
				let jsonString = NSString(data: data, encoding: String.Encoding.utf8.rawValue), task.2 == nil {
				self.dataResponse = data
				self.stringResponse = jsonString as String
				print("\n************\n")
				print("RESPUESTA WS")
				print("\n************\n")
				print("\(jsonString)")
				print("\n************\n")
		
					
			} else {
				print("Oh no... un error en la matrixx: \(task.2?.localizedDescription ?? "Oh no... un error en la matrixx")")

			}


	}

	func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
		   completionHandler(URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!) )
	}
}

extension URLSession {
	func synchronousDataTask(_ request: URLRequest) -> (Data?, URLResponse?, NSError?) {
		var data: Data?
		var response: URLResponse?
		var error: NSError?

		let semaphore = DispatchSemaphore(value: 0)
		let dataTask = self.dataTask(with: request, completionHandler: {
			data = $0
			response = $1
			error = $2 as NSError?

			semaphore.signal()
		})
		dataTask.resume()
		_ = semaphore.wait(timeout: .distantFuture)
		return (data, response, error)
	}
	func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
		   completionHandler(URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!) )
	}

}

