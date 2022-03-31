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
