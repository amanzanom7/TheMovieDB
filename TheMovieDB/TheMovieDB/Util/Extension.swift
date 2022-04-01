//
//  Extension.swift
//  TheMovieDB
//
//  Created by MANZANO MARTINEZ, ALAIN MARIANO on 30/03/22.
//

import UIKit

extension UIViewController
{
	func addElementView(obj:UIView)
	{
		self.view.addSubview(obj)
	}
	
	func add(asChildViewController viewController: UIViewController) {
		addChild(viewController)
		view.addSubview(viewController.view)
		viewController.view.frame = view.bounds
		viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		viewController.didMove(toParent: self)
	}
}
extension String {
	func toImage() -> UIImage? {
		if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
			return UIImage(data: data)
		}
		return nil
	}
}

extension UIColor {

	func hexStringToUIColor (_ hex:String) -> UIColor {
		let cString:String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

		if ((cString.count) != 6) {
			return UIColor.gray
		}

		var rgbValue:UInt64 = 0
			Scanner(string: cString).scanHexInt64(&rgbValue)

			return UIColor(
				red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
				green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
				blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
				alpha: CGFloat(1.0)
			)
	}
}

extension UIButton
{
	func setBorderColorCustom(_ color:CGColor)
	{
		self.layer.cornerRadius = 1
		self.layer.borderWidth = 1
		self.layer.borderColor = color
		self.clipsToBounds = true
	}
	func enable(_ flag:Bool){
		if flag{
			self.isEnabled = true
		}else{
			self.isEnabled = false
		}
	}
}
extension Data
{
	func getData() -> JSONDecoder {
		return JSONDecoder(self as AnyObject)
	}
}

typealias BloqueGenerico = () -> Void

extension NSObject
{
	func ejecutaSegundoPlano(_ bloqueSegundoPlano:@escaping BloqueGenerico, bloquePrimerPlano:@escaping BloqueGenerico)
	{
		DispatchQueue.global(qos: .userInitiated).async {
			bloqueSegundoPlano()
			DispatchQueue.main.async(execute: {
				bloquePrimerPlano()
			});
		}
	
	}
}
