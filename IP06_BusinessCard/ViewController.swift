//
//  ViewController.swift
//  IP06_BusinessCard
//
//  Created by Rai, Rhea on 10/18/22.
//

import UIKit

class ViewController: UIViewController {

    
    //screen values/constants
    var screenWidth: Int = 0
    var screenHeight: Int = 0
    let xBuffer = 10
    let yBuffer = 100
    
    //info
    
    var personImgView = UIImageView()
    var nameLbl = UILabel()
    var roleLbl = UILabel()
    var contactShowButton = UIButton()
    var phoneButton = UIButton()
    var emailButton = UIButton()
    var shareButton = UIButton()
    
    //to toggle btwn alter egos
    var switchPerson = UISwitch()
    var showDay = true
    var personByDay: Person?
    var personByNight: Person?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //set up default screen constants
        let screenBounds: CGRect = UIScreen.main.bounds
        screenWidth = Int(screenBounds.width)
        screenHeight = Int(screenBounds.height)
        
        
        //declare values of personas
        personByDay = Person(firstName: "Rhea", LastName: "Rai", role: "Senior at LTHS", phone: "+1 123-456-7890", email: "rhea.rai.474@k12.friscoisd.org", imageName: "rhea.png") //TODO: fix the pngs
        personByNight = Person(firstName: "Friendly Neighborhood", LastName: "Spiderman", role: "NYC Superhero", phone: "+1 987-654-3210", email: "spiderman@avengers.com", imageName: "rhea.png")
        
        //set up frames/settings
        var currPerson: Person
        if(showDay) { currPerson = personByDay!}
        else { currPerson = personByNight! }
        
        //image view
        let imgCenterX = screenWidth/2
        let imgCenterY = screenHeight/4
        let imgRadius = (screenWidth-2*xBuffer)/3
        personImgView = UIImageView(image: UIImage(named:currPerson.imageName))
        personImgView.frame = CGRect(x: imgCenterX-imgRadius, y: imgCenterY-imgRadius, width: 2*imgRadius, height: 2*imgRadius)
        personImgView.contentMode = .scaleAspectFill
        personImgView.clipsToBounds = true
        personImgView.layer.cornerRadius = CGFloat(imgRadius)
        personImgView.layer.borderWidth = 5
        personImgView.layer.borderColor = UIColor.black.cgColor
        view.addSubview(personImgView)
        print("done")
//        let nameOrigin = CGPoint(x: screenWidth/2, y: 10)
//        nameLbl.frame = CGRect(origin: nameOrigin, size: <#T##CGSize#>)
        
        
    }


}

