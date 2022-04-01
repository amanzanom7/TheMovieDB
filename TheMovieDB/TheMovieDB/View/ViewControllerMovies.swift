	//
	//  ViewControllerMovies.swift
	//  TheMovieDB
	//
	//  Created by MANZANO MARTINEZ, ALAIN MARIANO on 31/03/22.
	//
import UIKit

class ViewControllerMovies: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {


	var viewModel = ViewModelCollection()
	var collectionView:UICollectionView?


	override func viewDidLoad() {
		super.viewDidLoad()

		self.setComponents()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)

	}

	
	func setComponents()
	{
		self.view.backgroundColor = UIColor().hexStringToUIColor("06161C")

		self.navigationController?.setNavigationBarHidden(true, animated: false)
		let nav = CustomNavBar()
		self.view.addSubview(nav)
		
		nav.translatesAutoresizingMaskIntoConstraints = false
		nav.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		nav.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		nav.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.maxX).isActive = true
		nav.heightAnchor.constraint(equalToConstant: 100).isActive = true
		

		segmentControl()

		viewModel.retrieveData(endpoint: "/trending/movie/week?api_key=")
	}
	
	
	func segmentControl()
	{
		
		let popular = NSLocalizedString("popular", comment: "1")
		let top = NSLocalizedString("toprated", comment: "2")
		let ontv = NSLocalizedString("ontv", comment: "3")
		let today = NSLocalizedString("airingtoday", comment: "4")
		
		let 		segmentedControl = UISegmentedControl (items: [popular,top,ontv,today])
		
		let xPostion:CGFloat = 30
		let yPostion:CGFloat = 130
		let elementWidth:CGFloat = 340
		let elementHeight:CGFloat = 40
		
		segmentedControl.frame = CGRect(x: xPostion, y: yPostion, width: elementWidth, height: elementHeight)
		
		segmentedControl.selectedSegmentIndex = 0
		
		segmentedControl.selectedSegmentTintColor = .darkGray

		let font = UIFont.systemFont(ofSize: 13)

		let textAttrs: [NSAttributedString.Key : Any] = [
			.foregroundColor: UIColor.white,
			.font: font
		]
		segmentedControl.setTitleTextAttributes(textAttrs, for: .normal)
		
		segmentedControl.backgroundColor = UIColor().hexStringToUIColor("17242B")
				
		self.view.addSubview(	segmentedControl)
		
		let xPostionCollection:CGFloat = 30
		let yPostionCollection:CGFloat = segmentedControl.frame.origin.y + segmentedControl.frame.size.height + 30
		let elementWidthCollection:CGFloat = 340
		let elementHeightCollection:CGFloat = self.view.frame.size.height / 1.4
				

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
		10
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionCell.identifier, for: indexPath) as! CustomCollectionCell
		let obj = viewModel.resultsResponse[indexPath.row]
		let date = "Premier: " +  obj.release_date
		let average = "Vote: " +  String.init(format:"%.1f",obj.vote_average)
		let img = obj.poster_path
		cell.configureImg(nameImg: img)
		cell.configureLbl(nameLbl: obj.original_title,description: obj.overview, date:date, average: average)
		return cell
	}

}



