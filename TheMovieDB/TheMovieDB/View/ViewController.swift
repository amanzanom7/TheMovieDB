//
//  ViewController.swift
//  TheMovieDB
//
//  Created by MANZANO MARTINEZ, ALAIN MARIANO on 30/03/22.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

	var txtUsr = UITextField()
	var txtPass = UITextField()
	var lblMessage = UILabel()
	var btnLogin = UIButton()

	
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
		txtUsr = Util.createTextField(posX: offSetXUser, posY: offSetYUser, width: offSetwidthUser, height: offSetheightUser, stringPlaceholder: NSLocalizedString("usuario", comment: "Username") )
		txtUsr.keyboardType = .default
		txtUsr.autocapitalizationType = .none
		txtUsr.delegate = self
		
		let offSetYPass = txtUsr.frame.origin.y + txtUsr.frame.size.height + spaceHeight
		txtPass = Util.createTextField(posX: offSetXUser, posY: offSetYPass, width: offSetwidthUser, height: offSetheightUser, stringPlaceholder: NSLocalizedString("password", comment: "Password") )
		txtPass.isSecureTextEntry = true
		txtPass.keyboardType = .default
		txtPass.delegate = self
		
		let offSetYBtn = txtPass.frame.origin.y + txtPass.frame.size.height + spaceHeight
		btnLogin = Util.createButton(posX: offSetXUser, posY: offSetYBtn, width: offSetwidthUser, height: offSetheightUser, tittle: NSLocalizedString("textLoginBtn", comment: "Login"), actionSelector:  #selector(self.actionLogin), colorTitleColor: UIColor().hexStringToUIColor("d9d6d2"))
		
		let offSetXlbl:CGFloat = 20
		let offSetYlbl = btnLogin.frame.origin.y + btnLogin.frame.size.height + spaceHeight
		let offSetwidthlbl:CGFloat = self.view.frame.width / 1.1
		lblMessage = Util.createLabel(posX: offSetXlbl, posY: offSetYlbl, width: offSetwidthlbl, height: offSetheightUser, tittle: NSLocalizedString("lblLoginValidate", comment: "Invalid user or password"), colorTitleColor: UIColor.orange)
		lblMessage.isHidden = true
		
		self.addElementView(obj: imgHeader)
		self.addElementView(obj: txtUsr)
		self.addElementView(obj: txtPass)
		self.addElementView(obj: btnLogin)
		self.addElementView(obj: lblMessage)

		let bloqueConsumo:BloqueGenerico =
		{ () in
				self.viewModel.retrieveData(endpoint: "/token/new?api_key=")
		}
		let bloqueRespuesta:BloqueGenerico =
		{() in}
		self.ejecutaSegundoPlano(bloqueConsumo, bloquePrimerPlano: bloqueRespuesta)

	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
	}
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

		self.view.endEditing(true)
	}
	
	//MARK: TextField Delegate
	func textFieldDidBeginEditing(_ textField: UITextField)
	{
		self.lblMessage.isHidden = true
		if txtUsr == textField
		{
			txtPass.text = ""
		}
	}

	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		self.view.endEditing(true)

		return true
	}
	func textFieldDidEndEditing(_ textField: UITextField) {

	
	}

	func textFieldShouldClear(_ textField: UITextField) -> Bool {
		self.lblMessage.isHidden = true
		return true
	}

	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

		var result = false

		if textField == txtUsr || textField == txtPass {
			let maxLength = 20
			let currentString: NSString = textField.text! as NSString
			let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString

			let longitudCorrecta = newString.length <= maxLength
			let letters = CharacterSet.alphanumerics

			if longitudCorrecta {
				let range = string.rangeOfCharacter(from: letters)
				if let _ = range
				{
					return true
				}
				else
				{
					if string == " " || string == ""
					{
						result = true
					}
				}
			}
		}
		

		return result
	}

	func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
		
		return true
	}

	
	func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {

		return true
	}

	
	@objc func actionLogin()
	{
		self.view.endEditing(true)
		self.lblMessage.isHidden = true
		var objLoginMessage:AnyObject!
		
		objLoginMessage = self.viewModel.sendData(endpoint: "validate_with_login?api_key=", user: txtUsr.text!, pass: txtPass.text!)
		if objLoginMessage.isKind(of: LoginMessage.self)
		{
			print("LoginMessage")
//			if objLoginMessage.success
//			{
//
//			}else {
//				self.lblMessage.isHidden = false
//			}
		}else if objLoginMessage.isKind(of: LoginToken.self)
		{
			print("LoginToken")

		}
	
	}

}

