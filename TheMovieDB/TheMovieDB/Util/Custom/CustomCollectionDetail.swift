//
//  CustomCollectionDetail.swift
//  TheMovieDB
//
//  Created by MANZANO MARTINEZ, ALAIN MARIANO on 01/04/22.
//


import UIKit

class CustomCollectionDetail: UICollectionViewCell {
	
	static let identifier = "CustomCollectionCell"
	
	
	private let imgViewCell: UIImageView = {
		let imageView:UIImageView = UIImageView()
		imageView.image = UIImage(named: "menu")
		imageView.contentMode = .scaleAspectFit
		imageView.clipsToBounds = true
		return imageView
	}()

	
	override init(frame: CGRect) {
		super.init(frame: frame)
		contentView.backgroundColor = .clear
		contentView.addSubview(imgViewCell)
	}
	
	required init?(coder: NSCoder) {
		fatalError()
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		imgViewCell.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height)
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

