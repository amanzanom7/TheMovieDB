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
		imageView.image = UIImage(named: "menu")
		imageView.contentMode = .scaleAspectFit
		imageView.clipsToBounds = true
		return imageView
	}()
	
	private let lblTitulo:UILabel = {
		let label = UILabel()
		label.text = ""
		label.numberOfLines = 2
		label.backgroundColor = UIColor.clear
		label.textColor = UIColor.orange
		label.font = UIFont.boldSystemFont(ofSize: 14.0)
		label.textAlignment = NSTextAlignment.center
		label.adjustsFontSizeToFitWidth = true
		return label
	}()
	
	private let lblDescrip:UILabel = {
		let label = UILabel()
		label.text = ""
		label.numberOfLines = 12
		label.backgroundColor = UIColor.clear
		label.textColor = UIColor.white
		label.font = UIFont.boldSystemFont(ofSize: 13.0)
		label.textAlignment = NSTextAlignment.center
		label.adjustsFontSizeToFitWidth = true
		return label
	}()
	
	private let lblDate:UILabel = {
		let label = UILabel()
		label.text = ""
		label.numberOfLines = 1
		label.backgroundColor = UIColor.clear
		label.textColor = UIColor.white
		label.font = UIFont.boldSystemFont(ofSize: 13.0)
		label.textAlignment = NSTextAlignment.center
		label.adjustsFontSizeToFitWidth = true
		return label
	}()
	
	private let lblAverage:UILabel = {
		let label = UILabel()
		label.text = ""
		label.numberOfLines = 1
		label.backgroundColor = UIColor.clear
		label.textColor = UIColor.white
		label.font = UIFont.boldSystemFont(ofSize: 13.0)
		label.textAlignment = NSTextAlignment.center
		label.adjustsFontSizeToFitWidth = true
		return label
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		contentView.backgroundColor = .clear
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
		
		let offSetX:CGFloat = 205
		imgViewCell.frame = CGRect(x: -70, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height)
		
		lblTitulo.frame = CGRect(x: 200, y: 0, width: contentView.frame.size.width/2.4, height: 50)
		
		let offSetY = lblTitulo.frame.origin.y + lblTitulo.frame.size.height + 10
		lblDescrip.frame = CGRect(x: offSetX, y: offSetY, width: contentView.frame.size.width/2.5, height: 150)

		let offSetYlblDate = lblDescrip.frame.origin.y + lblDescrip.frame.size.height
		lblDate.frame = CGRect(x: offSetX, y: offSetYlblDate, width: contentView.frame.size.width/2.5, height: 50)
		
		let offSetYlblAverage = lblDate.frame.origin.y + lblDate.frame.size.height + 5
		lblAverage.frame = CGRect(x: offSetX, y: offSetYlblAverage, width: contentView.frame.size.width/2.4, height: 35)

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
				print("Unable to create URL")
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
