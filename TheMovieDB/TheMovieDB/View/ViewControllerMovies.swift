	//
	//  ViewControllerMovies.swift
	//  TheMovieDB
	//
	//  Created by MANZANO MARTINEZ, ALAIN MARIANO on 31/03/22.
	//
import UIKit

class ViewControllerMovies: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
	
	enum CardState {
		case expanded
		case collapsed
	}
	
	var viewModel = ViewModelCollection()
	var collectionView:UICollectionView?
	var  segmentedControl:UISegmentedControl?
	var containerView: ViewDetail?
	var btnCerrarDetail:UIButton?
	var controller:ViewController?
	var cardViewController:ViewControllerProfile  = ViewControllerProfile()
	var visualEffectView:UIVisualEffectView!
	
	let cardHeight:CGFloat = 700
	let cardHandleAreaHeight:CGFloat = 0
	
	var cardVisible = false
	var nextState:CardState {
		return cardVisible ? .collapsed : .expanded
	}
	
	var runningAnimations = [UIViewPropertyAnimator]()
	var animationProgressWhenInterrupted:CGFloat = 0
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		getCategoria()
		self.setComponents()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
		self.guardaFavorito()
	}
	
	
	func setComponents()
	{
		self.view.backgroundColor = UIColor().hexStringToUIColor("06161C")
		
		self.navigationController?.setNavigationBarHidden(true, animated: false)
		let nav = CustomNavBar()
		nav.controller = self
		self.view.addSubview(nav)
		
		nav.translatesAutoresizingMaskIntoConstraints = false
		nav.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		nav.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		nav.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.maxX).isActive = true
		nav.heightAnchor.constraint(equalToConstant: 100).isActive = true
		
		segmentControl()
		collectionControl()
		
		viewModel.retrieveData(endpoint: "/trending/movie/week?api_key=")
	}
	
	@objc func actionAlert()
	{
		let alertaSeleccione = UIAlertController(title: NSLocalizedString("tittlePerfil", comment: ""), message: "", preferredStyle: .actionSheet)
		
		alertaSeleccione.addAction(UIAlertAction(title: NSLocalizedString("profile", comment: ""), style: .default, handler: { (_) in
			self.viewProfile()
		}))
		alertaSeleccione.addAction(UIAlertAction(title: NSLocalizedString("logout", comment: ""), style: .destructive, handler: { (_) in
			self.controller?.logout()
		}))
		
		alertaSeleccione.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: UIAlertAction.Style.cancel, handler: nil))
		present(alertaSeleccione, animated: true, completion:nil)
	}
	
	func segmentControl()
	{
		let popular = NSLocalizedString("popular", comment: "1")
		let top = NSLocalizedString("toprated", comment: "2")
		let ontv = NSLocalizedString("ontv", comment: "3")
		let today = NSLocalizedString("airingtoday", comment: "4")
		segmentedControl = UISegmentedControl (items: [popular,top,ontv,today])
		
		let xPostion:CGFloat = 30
		let yPostion:CGFloat = 130
		let elementWidth:CGFloat = 340
		let elementHeight:CGFloat = 40
		
		segmentedControl!.frame = CGRect(x: xPostion, y: yPostion, width: elementWidth, height: elementHeight)
		
		segmentedControl!.selectedSegmentIndex = 0
		
		segmentedControl!.selectedSegmentTintColor = .darkGray
		
		let font = UIFont.systemFont(ofSize: 13)
		
		let textAttrs: [NSAttributedString.Key : Any] = [
			.foregroundColor: UIColor.white,
			.font: font
		]
		segmentedControl!.setTitleTextAttributes(textAttrs, for: .normal)
		
		segmentedControl!.backgroundColor = UIColor().hexStringToUIColor("17242B")
		
		self.view.addSubview(	segmentedControl!)
		
	}
	
	func setupCard() {
		visualEffectView = UIVisualEffectView()
		visualEffectView.frame = self.view.frame
		self.view.addSubview(visualEffectView)
		
		self.add(asChildViewController: self.cardViewController)
		
		cardViewController.view.frame = CGRect(x: 0, y: self.view.frame.height - cardHandleAreaHeight, width: self.view.bounds.width, height: cardHeight)
		
		cardViewController.view.clipsToBounds = true
		
		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleCardTap(recognzier:)))
		let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.handleCardPan(recognizer:)))
		
		cardViewController.view.addGestureRecognizer(tapGestureRecognizer)
		cardViewController.view.addGestureRecognizer(panGestureRecognizer)
	}
	
	func guardaFavorito()
	{
		var categoriasMovies:Array<CategoriaMovies> = Array<CategoriaMovies>()

		categoriasMovies = Singleton.sharedInstance.categoriasMovies
		
		for obj in Singleton.sharedInstance.resultsResponse
		{
				let cat = CategoriaMovies()
				cat.backdrop_path = obj.backdrop_path
				cat.original_language = obj.original_language
				cat.original_title = obj.original_title
				cat.poster_path = obj.poster_path
				cat.vote_average = obj.vote_average
				cat.vote_count = obj.vote_count
				cat.overview = obj.overview
				cat.release_date = obj.release_date
				cat.title = obj.title
				cat.id = obj.id
				cat.popularity = obj.popularity
				cat.media_type = obj.media_type
				categoriasMovies.append(cat)
		}
		if let dir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first {
			let usr = Singleton.sharedInstance.userLogin + ".txt"
			let path = URL(fileURLWithPath: dir).appendingPathComponent(usr)
			
			do {
				let archiver = try NSKeyedArchiver.archivedData(withRootObject:  categoriasMovies, requiringSecureCoding: false)
				try archiver.write(to: path)
				
			}catch let error{
				print("\(error.localizedDescription)")
			}
		}

	}

	func getCategoria()
	{
		var categoriasMovies:Array<CategoriaMovies> = Array<CategoriaMovies>()
		let usr = Singleton.sharedInstance.userLogin + ".txt"
		let checkValidation = FileManager.default
		let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(usr)
		let pathURL = path
		let pathString = pathURL.path
		if (checkValidation.fileExists(atPath: pathString))
		{
			
			do {
				let fileContent =  try Data(contentsOf: path)
				guard let objetoArray = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(fileContent) as? [CategoriaMovies] else { return  }
				var resultsResponse: Array<ResultsVO> =  Array<ResultsVO>()
				for obj in objetoArray {
					categoriasMovies.append(obj)
					let cat = ResultsVO()
					cat.backdrop_path = obj.backdrop_path
					cat.original_language = obj.original_language
					cat.original_title = obj.original_title
					cat.poster_path = obj.poster_path
					cat.vote_average = obj.vote_average
					cat.vote_count = obj.vote_count
					cat.overview = obj.overview
					cat.release_date = obj.release_date
					cat.title = obj.title
					cat.id = obj.id
					cat.popularity = obj.popularity
					cat.media_type = obj.media_type
					resultsResponse.append(cat)
				}
				Singleton.sharedInstance.resultsResponse = resultsResponse

			
			} catch {
			}
		}
		
	}
	
		//MARK: collectionControl delegates
	func collectionControl()
	{
		let xPostionCollection:CGFloat = 30
		let yPostionCollection:CGFloat = segmentedControl!.frame.origin.y + segmentedControl!.frame.size.height + 30
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
		viewModel.resultsResponse.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionCell.identifier, for: indexPath) as! CustomCollectionCell
		let obj = viewModel.resultsResponse[indexPath.row]
		let date = "Premier: " +  obj.release_date
		let average = "Vote: " +  String.init(format:"%.1f",obj.vote_average)
		let img = obj.poster_path
		cell.configureImg(nameImg: img!)
		cell.configureLbl(nameLbl: obj.original_title,description: obj.overview, date:date, average: average)
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		let obj = viewModel.resultsResponse[indexPath.row]
		let idmovie = obj.id
		let endpoint = "/movie/" + String.init(format: "%i",idmovie!) + "?api_key="
		viewModel.retrieveDataDetail(endpoint: endpoint,parameter: true, stringParameter: "&language=es-MX")
		
		let xPostion:CGFloat = self.segmentedControl?.frame.origin.x ?? 0
		let yPostion:CGFloat = self.segmentedControl?.frame.origin.y ?? 0
		let elementWidth:CGFloat = self.collectionView?.frame.size.width ?? 0
		let elementHeight:CGFloat = (self.collectionView?.frame.size.height)! + 70
		
		containerView = ViewDetail(frame: CGRect(x: xPostion, y: yPostion, width: elementWidth, height: elementHeight))
		containerView!.translatesAutoresizingMaskIntoConstraints = false
		containerView!.detail = viewModel.detail
		containerView!.resultsResponse = obj
		containerView?.controller = self
		self.addElementView(obj: containerView!)
		containerView!.configureCollection()
		
		let image = UIImage(named: "close")
		let xPostionBtn:CGFloat = (containerView?.frame.size.width)! - 10
		
		btnCerrarDetail = Util.createButton(posX:  xPostionBtn, posY: yPostion, width: 40, height: 40, tittle: "", actionSelector:  #selector(self.cerrarVentana), colorBackground: UIColor().hexStringToUIColor("d9d6d2"))
		btnCerrarDetail!.setBackgroundImage(image, for: UIControl.State.normal)
		btnCerrarDetail!.backgroundColor = .clear
		self.addElementView(obj: btnCerrarDetail!)
		
	}
	
	func viewProfile()
	{
		cardViewController = ViewControllerProfile()
		setupCard()
		animateTransitionIfNeeded(state: nextState, duration: 0.9)
	}
	
	@objc func cerrarVentana()
	{
		btnCerrarDetail?.removeFromSuperview()
		containerView?.removeFromSuperview()
		
	}
	
	
		//MARK: Profile Card
	@objc
	func handleCardTap(recognzier:UITapGestureRecognizer) {
		switch recognzier.state {
			case .ended:
				animateTransitionIfNeeded(state: nextState, duration: 0.9)
			default:
				break
		}
	}
	
	@objc
	func handleCardPan (recognizer:UIPanGestureRecognizer) {
		switch recognizer.state {
			case .began:
				startInteractiveTransition(state: nextState, duration: 0.9)
			case .changed:
				let translation = recognizer.translation(in: self.cardViewController.view)
				var fractionComplete = translation.y / cardHeight
				fractionComplete = cardVisible ? fractionComplete : -fractionComplete
				updateInteractiveTransition(fractionCompleted: fractionComplete)
			case .ended:
				continueInteractiveTransition()
			default:
				break
		}
		
	}
	
	func animateTransitionIfNeeded (state:CardState, duration:TimeInterval) {
		if runningAnimations.isEmpty {
			let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
				switch state {
					case .expanded:
						self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardHeight
					case .collapsed:
						self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardHandleAreaHeight
				}
			}
			
			frameAnimator.addCompletion { _ in
				self.cardVisible = !self.cardVisible
				self.runningAnimations.removeAll()
				if !self.cardVisible
				{
					self.reloadView()
				}
			}
			
			frameAnimator.startAnimation()
			runningAnimations.append(frameAnimator)
			
			
			let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
				switch state {
					case .expanded:
						self.cardViewController.view.layer.cornerRadius = 12
					case .collapsed:
						self.cardViewController.view.layer.cornerRadius = 0
				}
			}
			
			cornerRadiusAnimator.startAnimation()
			runningAnimations.append(cornerRadiusAnimator)
			
			let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
				switch state {
					case .expanded:
						self.visualEffectView.effect = UIBlurEffect(style: .dark)
					case .collapsed:
						self.visualEffectView.effect = nil
		
				}
			}
			
			blurAnimator.startAnimation()
			runningAnimations.append(blurAnimator)

		}
		
	}
	
	func startInteractiveTransition(state:CardState, duration:TimeInterval) {
		if runningAnimations.isEmpty {
			animateTransitionIfNeeded(state: state, duration: duration)
		}
		for animator in runningAnimations {
			animator.pauseAnimation()
			animationProgressWhenInterrupted = animator.fractionComplete
		}
	}
	
	func updateInteractiveTransition(fractionCompleted:CGFloat) {
		for animator in runningAnimations {
			animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
		}
	}
	
	func continueInteractiveTransition (){
		for animator in runningAnimations {
			animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
		}
	}
	func reloadView()
	{

			self.cardViewController.willMove(toParent: nil)
			self.cardViewController.view.removeFromSuperview()
			self.cardViewController.removeFromParent()
			self.visualEffectView.removeFromSuperview()
		
	}
}



