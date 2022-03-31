//
//  ViewController.swift
//  TheMovieDB
//
//  Created by MANZANO MARTINEZ, ALAIN MARIANO on 30/03/22.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

	var viewModel = ViewModelLogin()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		self.setComponents()
		
	}

	func setComponents()
	{
		self.view.backgroundColor = UIColor().hexStringToUIColor("0d253f")

		let imgHeader:UIImageView = UIImageView()
		imgHeader.contentMode = UIView.ContentMode.scaleAspectFit
		imgHeader.frame.size.width = 140
		imgHeader.frame.size.height = 140
		imgHeader.frame.origin.y = self.view.frame.height / 6
		imgHeader.frame.origin.x = self.view.frame.width / 3.2
		imgHeader.image = UIImage(named:  "background")
				
		let spaceHeight:CGFloat = 20
		let offSetXUser:CGFloat = 50
		let offSetYUser = imgHeader.frame.origin.y + imgHeader.frame.size.height + spaceHeight
		let offSetheightUser:CGFloat = 55
		let offSetwidthUser:CGFloat = self.view.frame.width / 1.3
		let txtUsr = Util.createTextField(posX: offSetXUser, posY: offSetYUser, width: offSetwidthUser, height: offSetheightUser, stringPlaceholder: NSLocalizedString("usuario", comment: "Username") )
		
		let offSetYPass = txtUsr.frame.origin.y + txtUsr.frame.size.height + spaceHeight
		let txtPass = Util.createTextField(posX: offSetXUser, posY: offSetYPass, width: offSetwidthUser, height: offSetheightUser, stringPlaceholder: NSLocalizedString("password", comment: "Password") )
		
		let offSetYBtn = txtPass.frame.origin.y + txtPass.frame.size.height + spaceHeight

		let btnLogin = Util.createButton(posX: offSetXUser, posY: offSetYBtn, width: offSetwidthUser, height: offSetheightUser, tittle: NSLocalizedString("textLoginBtn", comment: "Login"), actionSelector:  nil, colorTitleColor: UIColor().hexStringToUIColor("d9d6d2"))
		
		let offSetXlbl:CGFloat = 20
		let offSetYlbl = btnLogin.frame.origin.y + btnLogin.frame.size.height + spaceHeight
		let offSetwidthlbl:CGFloat = self.view.frame.width / 1.1

		let lblMessage = Util.createLabel(posX: offSetXlbl, posY: offSetYlbl, width: offSetwidthlbl, height: offSetheightUser, tittle: NSLocalizedString("lblLoginValidate", comment: "Invalid user or password"), colorTitleColor: UIColor.orange)
		
		//#selector(self.validateLogin)
		self.addElementView(obj: imgHeader)
		self.addElementView(obj: txtUsr)
		self.addElementView(obj: txtPass)
		self.addElementView(obj: btnLogin)
		self.addElementView(obj: lblMessage)

		let parcer:FeedBack = FeedBack();
		let login:LoginToken = LoginToken();

		let bloqueConsumo:BloqueGenerico =
		{ () in
			let decoder = JSONDecoder()
			
			do {
				let json = 	parcer.callWebService(login, endpoint: "/token/new?api_key=",post: false)

				let loginToken = try decoder.decode(LoginToken.self, from: json)
				print("response \(loginToken.request_token)")
			}catch let error {
				print("Oh no... un error en la matrixx: \(error.localizedDescription)")
			}
			//parcer.callWebService(login, endpoint: "/validate_with_login?api_key=",post: true)

		}
		let bloqueRespuesta:BloqueGenerico =
			
		{() in
			
		}
		self.ejecutaSegundoPlano(bloqueConsumo, bloquePrimerPlano: bloqueRespuesta)

			//self.viewModel.retrieveData(endpoint: "/token/new?api_key=")
		//self.viewModel.sendData(endpoint: "validate_with_login?api_key=", user: "amanzanomtz", pass: "Master007")
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		

	}

}

