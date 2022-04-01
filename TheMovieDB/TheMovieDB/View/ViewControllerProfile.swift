//
//  ViewControllerProfile.swift
//  TheMovieDB
//
//  Created by MANZANO MARTINEZ, ALAIN MARIANO on 01/04/22.
//

import UIKit

class ViewControllerProfile: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

	var collectionView:UICollectionView?
	var lblFavorito:UILabel = UILabel()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = UIColor().hexStringToUIColor("06161C")
		
		setupComponents()
	}
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
	}

	func setupComponents()
	{
		let lblTitulo = Util.createLabel(posX: 0, posY: 50, width: self.view.frame.size.width, height: 30, tittle: NSLocalizedString("profile", comment: ""), colorTitleColor: UIColor.orange)
		lblTitulo.font = UIFont.boldSystemFont(ofSize: 28.0)
		self.addElementView(obj: lblTitulo)
		
		let offSetYlblTitulo:CGFloat = lblTitulo.frame.origin.y + lblTitulo.frame.size.height + 20
		let imgProfile:UIImageView = UIImageView()
		imgProfile.contentMode = UIView.ContentMode.scaleAspectFit
		imgProfile.frame.size.width = 140
		imgProfile.frame.size.height = 140
		imgProfile.frame.origin.y = offSetYlblTitulo
		imgProfile.frame.origin.x = lblTitulo.frame.width / 3.2
		imgProfile.image = UIImage(named:  "profile")
		self.addElementView(obj: imgProfile)

		let offSetYimgProfile:CGFloat = imgProfile.frame.origin.y + imgProfile.frame.size.height + 10
		let usr = "@" + Singleton.sharedInstance.userLogin
		let lblUser = Util.createLabel(posX: 0, posY: offSetYimgProfile, width: self.view.frame.size.width, height: 30, tittle: usr, colorTitleColor: UIColor.orange)
		lblUser.font = UIFont.boldSystemFont(ofSize: 18.0)
		self.addElementView(obj: lblUser)
		
		let offSetYlblUser:CGFloat = lblUser.frame.origin.y + lblUser.frame.size.height + 30
		lblFavorito = Util.createLabel(posX: 0, posY: offSetYlblUser, width: self.view.frame.size.width, height: 30, tittle: NSLocalizedString("favorito", comment: ""), colorTitleColor: UIColor.orange)
		lblFavorito.font = UIFont.boldSystemFont(ofSize: 18.0)
		self.addElementView(obj: lblFavorito)
		
		collectionControl()
	}
	
		//MARK: collectionControl delegates
	func collectionControl()
	{
		let offSetYlblFavorito:CGFloat = lblFavorito.frame.origin.y + lblFavorito.frame.size.height + 10

		let xPostionCollection:CGFloat = 30
		let yPostionCollection:CGFloat =  offSetYlblFavorito
		let elementWidthCollection:CGFloat = 340
		let elementHeightCollection:CGFloat = 300
		
		
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.itemSize = CGSize(width: elementWidthCollection, height: self.view.frame.size.width/1.3)
		layout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
		
		collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		guard collectionView != nil else {
			return
		}
		collectionView?.register(CustomCollectionCell.self, forCellWithReuseIdentifier: CustomCollectionCell.identifier)
		collectionView?.dataSource = self
		collectionView?.delegate = self
		collectionView?.frame = CGRect(x: xPostionCollection, y: yPostionCollection, width: elementWidthCollection, height: elementHeightCollection)
		collectionView?.backgroundColor = .clear
		self.view.addSubview(collectionView!)
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		Singleton.sharedInstance.resultsResponse.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionCell.identifier, for: indexPath) as! CustomCollectionCell
		let obj = Singleton.sharedInstance.resultsResponse[indexPath.row]
		let date = "Premier: " +  obj.release_date
		let average = "Vote: " +  String.init(format:"%.1f",obj.vote_average)
		let img = obj.poster_path
		cell.configureImg(nameImg: img!)
		cell.configureLbl(nameLbl: obj.original_title,description: obj.overview, date:date, average: average)
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
	}
}


