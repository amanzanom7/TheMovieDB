	//
	//  CustomNavBar.swift
	//  TheMovieDB
	//
	//  Created by MANZANO MARTINEZ, ALAIN MARIANO on 31/03/22.
	//

import UIKit

class CustomNavBar: UIView {
	
	var btnMenu:UIButton!
	var lblTittle:UILabel!
	var controller:ViewControllerMovies!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupview()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setupview()
	}
	
	func setupview() {
		tintColor = .white
		backgroundColor = .darkGray
		layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
		
		let offSetY:CGFloat = 60
		
		self.btnMenu = Util.createButton(posX: UIScreen.main.bounds.maxX-50 , posY: offSetY, width: 30, height: 30, tittle: "", actionSelector:  #selector(self.controller.actionAlert), colorTitleColor: UIColor.clear)
		btnMenu.setImage(UIImage(named: "menu"), for: .normal)
		self.addSubview(btnMenu)
		
		self.lblTittle = Util.createLabel(posX: UIScreen.main.bounds.midX-60, posY: offSetY, width: 120, height: 35, tittle: NSLocalizedString("tittleBar", comment: "Shows"), colorTitleColor: UIColor.white)
		lblTittle.font = UIFont.boldSystemFont(ofSize: 20.0)
		self.addSubview(lblTittle)
		
	}
	

}
