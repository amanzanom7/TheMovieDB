//
//  CustomCollectionCell.swift
//  TheMovieDB
//
//  Created by MANZANO MARTINEZ, ALAIN MARIANO on 31/03/22.
//

import UIKit

class CustomCollectionCell: UICollectionViewCell {
	
	static let identifier = "CustomCollectionCell"
	
	
	private let imgViewCell: UIImageView = {
		let imageView:UIImageView = UIImageView()
		imageView.image = UIImage(named: "profile")
		imageView.contentMode = .scaleAspectFit
		imageView.clipsToBounds = true
		return imageView
	}()
	
	private var lblTitulo:UILabel = UILabel()
	
	private var lblDescrip:UILabel = UILabel()
	
	private var lblDate:UILabel = UILabel()
	
	private var lblAverage:UILabel = UILabel()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		contentView.backgroundColor = .clear
		let offSetX:CGFloat = 205

		self.lblTitulo =  Util.createLabel(posX: 200, posY: 0, width: contentView.frame.size.width/2.4, height: 50, tittle: "", colorTitleColor: UIColor.orange)
		lblTitulo.numberOfLines = 2
		
		let offSetY = lblTitulo.frame.origin.y + lblTitulo.frame.size.height + 10
		lblDescrip =  Util.createLabel(posX: offSetX, posY: offSetY, width: contentView.frame.size.width/2.5, height: 150, tittle: "", colorTitleColor: UIColor.white)
		lblDescrip.numberOfLines = 12
		lblDescrip.font = UIFont.boldSystemFont(ofSize: 13.0)


		let offSetYlblDate = lblDescrip.frame.origin.y + lblDescrip.frame.size.height
		lblDate =  Util.createLabel(posX: offSetX, posY: offSetYlblDate, width: contentView.frame.size.width/2.5, height: 50, tittle: "", colorTitleColor: UIColor.white)

		let offSetYlblAverage = lblDate.frame.origin.y + lblDate.frame.size.height + 5
		lblAverage =  Util.createLabel(posX: offSetX, posY: offSetYlblAverage, width: contentView.frame.size.width/2.4, height: 35, tittle: "", colorTitleColor: UIColor.white)
		
		contentView.addSubview(lblTitulo)
		contentView.addSubview(lblDescrip)
		contentView.addSubview(lblDate)
		contentView.addSubview(lblAverage)
		contentView.addSubview(imgViewCell)
	}
	
	required init?(coder: NSCoder) {
		fatalError()
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		imgViewCell.frame = CGRect(x: -70, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height)
	
	}
	
	public func configureLbl(nameLbl:String, description:String, date:String, average:String)
	{
		lblTitulo.text = nameLbl
		lblDescrip.text = description
		lblDate.text = date
		lblAverage.text = average
	}
	
	public func configureImg(nameImg:String)
	{
		let string = "https://image.tmdb.org/t/p/w500" + nameImg
		if let image = getImage(from: string) {
			imgViewCell.image = image
		}
	}
	
	func getImage(from string: String) -> UIImage? {
		guard let url = URL(string: string)
			else {
				return nil
		}

		var image: UIImage? = nil
		do {
			let data = try Data(contentsOf: url, options: [])
			image = UIImage(data: data)
		}
		catch {
			print(error.localizedDescription)
		}

		return image
	}

}
