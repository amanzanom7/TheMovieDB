//
//  ViewDetail.swift
//  TheMovieDB
//
//  Created by MANZANO MARTINEZ, ALAIN MARIANO on 01/04/22.
//

import UIKit

class ViewDetail: UIView, UICollectionViewDataSource, UICollectionViewDelegate
{
	
	var collectionView:UICollectionView?
	var detail:DetailVO = DetailVO()
	var resultsResponse: ResultsVO!
	var controller:ViewControllerMovies = ViewControllerMovies()
	var imageOff = UIImage(named:"star")
	var imageOn = UIImage(named:"fullStar")
	var favSelect =  false

	override func awakeFromNib() {
		super.awakeFromNib()
		
	}
			
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	private var lblTitulo:UILabel = UILabel()
	
	private var lblDescrip:UILabel = UILabel()
	
	private var lblGenero:UILabel = UILabel()
	
	private var lblTittleProductora:UILabel = UILabel()
	
	private var btnFav:UIButton = UIButton()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = .darkGray
		
		let offSetX:CGFloat = 10
		let offSetWidth:CGFloat = self.frame.size.width - 20

		self.lblTitulo =  Util.createLabel(posX: offSetX, posY: 0, width:offSetWidth, height: 35, tittle: "", colorTitleColor: UIColor.white)
		lblTitulo.numberOfLines = 10
		lblTitulo.font = UIFont.boldSystemFont(ofSize: 18.0)
		lblTitulo.textAlignment = NSTextAlignment.left

		
		let offSetYlblTitulo:CGFloat = lblTitulo.frame.origin.y + lblTitulo.frame.size.height + 20
		lblDescrip =  Util.createLabel(posX: offSetX, posY: offSetYlblTitulo, width: offSetWidth, height: 140, tittle: "", colorTitleColor: UIColor.white)
		lblDescrip.numberOfLines = 10
		lblDescrip.font = UIFont.boldSystemFont(ofSize: 16.0)
		lblDescrip.textAlignment = NSTextAlignment.justified


		let offSetYlblDescrip:CGFloat = lblDescrip.frame.origin.y + lblDescrip.frame.size.height + 10
		lblGenero =  Util.createLabel(posX: offSetX, posY: offSetYlblDescrip, width: offSetWidth, height: 35, tittle: "", colorTitleColor: UIColor.white)
		lblGenero.font = UIFont.boldSystemFont(ofSize: 16.0)


		let offSetYlblGenero:CGFloat = lblGenero.frame.origin.y + lblGenero.frame.size.height
		lblTittleProductora =  Util.createLabel(posX: offSetX, posY: offSetYlblGenero, width: offSetWidth, height: 35, tittle: "Productoras: ", colorTitleColor: UIColor.white)
		lblTittleProductora.font = UIFont.boldSystemFont(ofSize: 16.0)

		btnFav = Util.createButton(posX: offSetX, posY: offSetYlblGenero, width: 45, height: 45, tittle: "", actionSelector: nil
								   , colorBackground: UIColor.white)
		btnFav.setBackgroundImage(imageOff!, for: UIControl.State.normal)
		
		self.addSubview(lblTitulo)
		self.addSubview(lblDescrip)
		self.addSubview(lblGenero)
		self.addSubview(lblTittleProductora)
		self.addSubview(btnFav)
	}
	override func layoutSubviews() {
		super.layoutSubviews()

		
		if Singleton.sharedInstance.resultsResponse.count > 0
		{
			for obj in Singleton.sharedInstance.resultsResponse
			{
				if obj.id == self.resultsResponse.id
				{
					favSelect = true
					btnFav.setBackgroundImage(imageOn!, for: UIControl.State.normal)
					break
				}
			}
		}
		btnFav.addTarget(self, action: #selector(self.tapStar(_:)), for: .touchUpInside)

		collectionControl()
	}
	
	@objc fileprivate func tapStar(_ sender:AnyObject){
		var pos = 0

		if !favSelect
		{
			favSelect = true
			btnFav.setBackgroundImage(imageOn!, for: UIControl.State.normal)
			
			if Singleton.sharedInstance.resultsResponse.count == 0
			{
				Singleton.sharedInstance.resultsResponse.append(self.resultsResponse)
			}else {
				for obj in Singleton.sharedInstance.resultsResponse
				{
					if obj.id != self.resultsResponse.id
					{
						self.resultsResponse.off = true
						Singleton.sharedInstance.resultsResponse.append(self.resultsResponse)
						break
					}
					pos = pos + 1
				}
			}
			
		}else {
			
			favSelect = false
			btnFav.setBackgroundImage(imageOff!, for: UIControl.State.normal)
			for obj in Singleton.sharedInstance.resultsResponse
			{
				if obj.id == self.resultsResponse.id
				{
					
					Singleton.sharedInstance.resultsResponse.remove(at: pos)
					break
				}
				pos = pos + 1
			}
		}
	}
	
	func collectionControl()
	{
		let xPostionCollection:CGFloat = 20
		let yPostionCollection:CGFloat = 290
		let elementWidthCollection:CGFloat = 300
		let elementHeightCollection:CGFloat = self.frame.size.height / 1.8
				

		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.itemSize = CGSize(width: elementWidthCollection, height: self.frame.size.height/4)
		layout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
		
		collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		guard collectionView != nil else {
			return
		}
		collectionView?.register(CustomCollectionDetail.self, forCellWithReuseIdentifier: CustomCollectionDetail.identifier)
		collectionView?.dataSource = self
		collectionView?.delegate = self
		collectionView?.frame = CGRect(x: xPostionCollection, y: yPostionCollection, width: elementWidthCollection, height: elementHeightCollection)
		collectionView?.backgroundColor = .clear
		self.addSubview(collectionView!)
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		detail.production_companies.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionDetail.identifier, for: indexPath) as! CustomCollectionDetail
		let obj = detail.production_companies[indexPath.row]

		let img = obj.logo_path
		cell.configureImg(nameImg: img)
		return cell
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
	}
	
	public func configureCollection()
	{
		self.lblTitulo.text = detail.title
		self.lblDescrip.text = detail.overview
		var genero = "Genero(s): "
		for obj in detail.genres
		{
			genero = genero + obj.name + ", "
		}
		self.lblGenero.text = genero
		collectionView?.reloadData()
	}
}
