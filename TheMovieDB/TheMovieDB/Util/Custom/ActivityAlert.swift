
import Foundation
import UIKit

class ActivityAlert: UIView
{
    override init (frame : CGRect)
    {
        super.init(frame : frame)
    }
    
    convenience init ()
    {
        self.init(frame:CGRect.zero)
    }
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("This class does not support NSCoding")
    }
    
    
    func crearControl()
    {
		self.endEditing(true)
        let screenSize: CGRect = UIScreen.main.bounds
        self.frame = CGRect.init(x: 0, y: 0, width:screenSize.width , height: screenSize.height)
        self.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.7)

        let wait = UIActivityIndicatorView(frame: CGRect(x: 0, y: (screenSize.height/2)-20, width: screenSize.width, height: 40))
        wait.color = UIColor.white
        wait.hidesWhenStopped = false
        wait.startAnimating()

        self.addSubview(wait);
        self.bringSubviewToFront(wait)

    }
}
