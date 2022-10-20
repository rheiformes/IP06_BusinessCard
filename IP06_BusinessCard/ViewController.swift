//
//  ViewController.swift
//  IP06_BusinessCard
//
//  Created by Rai, Rhea on 10/18/22.
//

//TODO: Add share button, fix images (using person class and uploaidng images)


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
    var showContact = false
    
    //to toggle btwn alter egos
    var switchPerson = UISwitch()
    var showDay = true
    var currTextColor = UIColor.black
    var currButtonTextColor = UIColor.white
    var personByDay: Person?
    var personByNight: Person?
    var currPerson: Person?
    
    
    
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
        currPerson = personByDay!
        //set up frames/settings
        setUI()
        
        //set alter ego switch
        switchPerson.frame = CGRect(x: screenWidth/2 - 10, y: Int(phoneButton.frame.maxY) + 20, width: 10, height: 10)
        switchPerson.addTarget(self, action: #selector(changePersona), for: .valueChanged)
        switchPerson.setOn(false, animated: false)
        switchPerson.backgroundColor = currButtonTextColor
        switchPerson.tintColor = currButtonTextColor
        switchPerson.layer.cornerRadius = 16.0
        view.addSubview(switchPerson)
        
    }
    
    @objc func pressContactPrompt() {
        showContact = !showContact
        if(!showContact) {
            contactShowButton.setTitle("Tap to show contact info...", for: .normal)
            emailButton.removeFromSuperview()
            phoneButton.removeFromSuperview()
        }
        else {
            contactShowButton.setTitle("Tap to hide contact info...", for: .normal)
            view.addSubview(emailButton)
            view.addSubview(phoneButton)
        }
        
    }
    
    @objc func changePersona() {
        showDay = !showDay
        emailButton.removeFromSuperview()
        phoneButton.removeFromSuperview()
        
        if(showDay) {
            currPerson = personByDay!
            currTextColor = UIColor.black
            currButtonTextColor = UIColor.white
            
        }
        else {
            currPerson = personByNight!
            currTextColor = UIColor.white
            currButtonTextColor = UIColor.black
        }
        setUI()
        switchPerson.backgroundColor = currButtonTextColor
        switchPerson.tintColor = currButtonTextColor
        switchPerson.layer.cornerRadius = 16.0
    }
    
//    func updateUIColor() {
//        personImgView.layer.borderColor = currTextColor.cgColor
//        nameLbl.textColor = currTextColor
//        roleLbl.textColor = currTextColor
//        contactShowButton.setTitleColor(currTextColor, for: .normal)
//        emailButton.setTitleColor(currButtonTextColor, for: .normal)
//        emailButton.backgroundColor = currTextColor
//        phoneButton.setTitleColor(currButtonTextColor, for: .normal)
//        phoneButton.backgroundColor = currTextColor
//    }
    
    func setUI() {
        //background
        self.view.backgroundColor = currButtonTextColor
        showContact = false
        
        //image view
        let imgCenterX = screenWidth/2
        let imgCenterY = screenHeight/4
        let imgRadius = (screenWidth-2*xBuffer)/3
        personImgView = UIImageView(image: UIImage(named:currPerson!.imageName))
        personImgView.frame = CGRect(x: imgCenterX-imgRadius, y: imgCenterY-imgRadius, width: 2*imgRadius, height: 2*imgRadius)
        personImgView.contentMode = .scaleAspectFill
        personImgView.clipsToBounds = true
        personImgView.layer.cornerRadius = CGFloat(imgRadius)
        personImgView.layer.borderWidth = 5
        personImgView.layer.borderColor = currTextColor.cgColor
        view.addSubview(personImgView)
        print("done")
        
        //setting up text labels
        
        //name
        nameLbl.text = currPerson!.firstName + "\n" + currPerson!.LastName
        nameLbl.numberOfLines = 0
        nameLbl.textAlignment = .center
        nameLbl.frame = CGRect(x: 2*xBuffer, y: Int(personImgView.frame.maxY)+15, width: screenWidth - 4*xBuffer, height: screenHeight/8)
        nameLbl.font = UIFont(name: "Courier-Bold", size: 50)
        nameLbl.adjustsFontSizeToFitWidth = true
        nameLbl.textColor = currTextColor
        view.addSubview(nameLbl)
        
        //role
        roleLbl.text = currPerson?.role
        roleLbl.numberOfLines = 0
        roleLbl.textAlignment = .center
        roleLbl.frame = CGRect(x: CGFloat(2*xBuffer), y: nameLbl.frame.maxY, width: nameLbl.frame.width, height: nameLbl.frame.height/4)
        roleLbl.font = UIFont(name: "Courier", size: 20)
        roleLbl.adjustsFontSizeToFitWidth = true
        roleLbl.textColor = currTextColor
        view.addSubview(roleLbl)
        
        //show contact prompt button
        contactShowButton.setTitle("Tap to show contact info...", for: .normal)
        contactShowButton.setTitleColor(currTextColor, for: .normal)
        contactShowButton.frame = CGRect(x: roleLbl.frame.minX, y: roleLbl.frame.maxY + 20, width: roleLbl.frame.width, height: roleLbl.frame.height)
        contactShowButton.titleLabel?.font = UIFont(name: "Courier", size: 15)
        contactShowButton.addTarget(self, action: #selector(pressContactPrompt), for: .touchUpInside)
        view.addSubview(contactShowButton)
        
        //email button
        emailButton.setTitle(currPerson?.email, for: .normal)
        emailButton.setTitleColor(currButtonTextColor, for: .normal)
        emailButton.backgroundColor = currTextColor
        emailButton.frame = CGRect(x: 3*xBuffer, y: Int(contactShowButton.frame.maxY) + 20, width: screenWidth - 6*xBuffer, height: Int(contactShowButton.frame.height))
        emailButton.layer.cornerRadius = emailButton.frame.height/2
        emailButton.titleLabel?.font = UIFont(name: "Courier", size: 15)
        
        //phone button
        phoneButton.setTitle(currPerson?.phone, for: .normal)
        phoneButton.setTitleColor(currButtonTextColor, for: .normal)
        phoneButton.backgroundColor = currTextColor
        phoneButton.frame = CGRect(x: emailButton.frame.minX, y: emailButton.frame.maxY + 5, width: emailButton.frame.width, height: emailButton.frame.height)
        phoneButton.layer.cornerRadius = emailButton.frame.height/2
        phoneButton.titleLabel?.font = UIFont(name: "Courier", size: 15)
        
    }
    
    


}

