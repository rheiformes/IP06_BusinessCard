//
//  ViewController.swift
//  IP06_BusinessCard
//
//  Created by Rai, Rhea on 10/18/22.
//

//TODO: Add share button, fix images (using person class and uploaidng images)


import UIKit
import MessageUI
import Contacts

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
        self.screenWidth = Int(screenBounds.width)
        self.screenHeight = Int(screenBounds.height)
        
        
        //declare values of personas
        self.personByDay = Person(firstName: "Rhea", LastName: "Rai", role: "Senior at LTHS", phone: "4696400634", email: "rhea.rai.474@k12.friscoisd.org", imageName: "spiderProfile.jpg")
        self.personByNight = Person(firstName: "Friendly Neighborhood", LastName: "Spiderman", role: "NYC Superhero", phone: "4696400634", email: "spiderman@avengers.com", imageName: "rheaSpider.jpg")
        self.currPerson = personByDay!
        
        //set up frames/settings
        self.setUI()
        
        //set alter ego switch
        self.switchPerson.frame = CGRect(x: screenWidth/2 - 10, y: Int(phoneButton.frame.maxY) + 20, width: 10, height: 10)
        self.switchPerson.addTarget(self, action: #selector(changePersona), for: .valueChanged)
        self.switchPerson.setOn(false, animated: false)
        self.switchPerson.backgroundColor = currButtonTextColor
        self.switchPerson.tintColor = currButtonTextColor
        self.switchPerson.layer.cornerRadius = 16.0
        view.addSubview(switchPerson)
        
    }
    
    //call phone number function, sourced from https://developer.apple.com/forums/thread/87997
    //this doesn't work in simulator bc there's no phone plan, so I haven't put it into the target for the phone button 
    @objc func callPhone() {
        let phoneNumber: String = currPerson!.phone
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
          }
    }
    
    //CNMutableContact documentation: https://developer.apple.com/documentation/contacts
    @objc func addContact() {
        let contact = CNMutableContact()
        contact.imageData = (personImgView.image)?.jpegData(compressionQuality: 1.0)
        contact.givenName = currPerson!.firstName
        contact.familyName = currPerson!.LastName
        
        
        let workEmail = CNLabeledValue(label: CNLabelHome, value: currPerson!.email as NSString)
        contact.emailAddresses = [workEmail]
        
        contact.phoneNumbers = [CNLabeledValue(
            label: CNLabelPhoneNumberiPhone,
            value: CNPhoneNumber(stringValue: currPerson!.phone))]
        
        
        // Save the newly created contact.
        let store = CNContactStore()
        let saveRequest = CNSaveRequest()
        saveRequest.add(contact, toContainerWithIdentifier: nil)

        do {
            try store.execute(saveRequest)
        } catch {
            print("Saving contact failed, error: \(error)")
            // Handle the error.
        }
    }
    
    //function that controls showing contact
    @objc func pressContactPrompt() {
        showContact = !showContact
        if(!showContact) {
            contactShowButton.setTitle("Tap to show contact info...", for: .normal)
            emailButton.removeFromSuperview()
            phoneButton.removeFromSuperview()
        }
        else {
            contactShowButton.setTitle("Tap buttons to add contact.\nTap prompt to hide contact info...", for: .normal)
            view.addSubview(emailButton)
            view.addSubview(phoneButton)
        }
        
    }
    
    //change to alter ego
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
        contactShowButton.titleLabel?.numberOfLines = 0
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
        emailButton.addTarget(self, action: #selector(addContact), for: .touchUpInside)
        
        //phone button
        phoneButton.setTitle(currPerson?.phone, for: .normal)
        phoneButton.setTitleColor(currButtonTextColor, for: .normal)
        phoneButton.backgroundColor = currTextColor
        phoneButton.frame = CGRect(x: emailButton.frame.minX, y: emailButton.frame.maxY + 5, width: emailButton.frame.width, height: emailButton.frame.height)
        phoneButton.layer.cornerRadius = emailButton.frame.height/2
        phoneButton.titleLabel?.font = UIFont(name: "Courier", size: 15)
        phoneButton.addTarget(self, action: #selector(addContact), for: .touchUpInside)
                              
    }
    
    
    
    


}

