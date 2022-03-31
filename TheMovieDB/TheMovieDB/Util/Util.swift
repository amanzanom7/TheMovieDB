//
//  Util.swift
//  TheMovieDB
//
//  Created by MANZANO MARTINEZ, ALAIN MARIANO on 30/03/22.
//

import Foundation
import UIKit

open class Util : NSObject 
{
	struct Encabezado{
		
		static let login = "fbe20d9486e2909773a473a8365e5886"
	}
	
	static func getDataPlistFile(nameString:String)  -> AnyObject
	{
		let localfilePath = Bundle.main.path(forResource: "Data", ofType: "plist")
		
		let dResponse =  NSDictionary(contentsOfFile:localfilePath!)!

		return 	dResponse.object(forKey: nameString) as AnyObject
	}
	
	static func createTextField(posX:CGFloat, posY:CGFloat, width:CGFloat, height:CGFloat, stringPlaceholder:String) -> UITextField
	{
		let txtGen: UITextField = UITextField.init(frame: CGRect(x: posX, y: posY, width: width, height: height))
		txtGen.placeholder = stringPlaceholder
		txtGen.backgroundColor = .white
		txtGen.clearButtonMode = .always
		txtGen.borderStyle = .roundedRect
	
		return txtGen
	}
	
	static func createButton(posX:CGFloat, posY:CGFloat, width:CGFloat, height:CGFloat, tittle:String, actionSelector:Selector?, colorTitleColor:UIColor) -> UIButton
	{
		let btnGen =  UIButton.init(frame: CGRect(x: posX,y: posY, width: width , height: height))
		btnGen.backgroundColor = UIColor.clear
		btnGen.setTitle(tittle, for: .normal)
		btnGen.backgroundColor = colorTitleColor 
		if actionSelector != nil{
			btnGen.addTarget(nil, action: actionSelector!, for: UIControl.Event.touchUpInside)
		}
		
		return btnGen
		
	}
	
	static func createLabel(posX:CGFloat, posY:CGFloat, width:CGFloat, height:CGFloat, tittle:String,  colorTitleColor:UIColor) -> UILabel
	{
		let lblGen  =  UILabel.init(frame: CGRect(x: posX, y: posY, width: width , height: height))
		lblGen.numberOfLines = 1
		lblGen.text =  tittle
		lblGen.backgroundColor = UIColor.clear
		lblGen.textColor = colorTitleColor
		lblGen.font = UIFont.boldSystemFont(ofSize: 14.0)
		lblGen.textAlignment = NSTextAlignment.center
		lblGen.adjustsFontSizeToFitWidth = true
		return lblGen
		
	}
	
	static func netStatus()-> Reachability.NetworkStatus
	{
		let reachability: Reachability
		var status:Reachability.NetworkStatus! = Reachability.NetworkStatus.notReachable

		do
		{
			reachability = try Reachability.reachabilityForInternetConnection()
			status = reachability.currentReachabilityStatus
		}
		catch
		{
			status = Reachability.NetworkStatus.reachableViaWWAN
		}

		return status
	}

}
