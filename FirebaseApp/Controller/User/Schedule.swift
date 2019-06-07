//
//  Schedule.swift
//  FirebaseApp
//
//  Created by George Heints on 08.06.2018.
//  Copyright © 2018 Robert Canton. All rights reserved.
//

import UIKit
import Firebase
import EventKit

class Schedule: UIViewController, UITextFieldDelegate{

    var isLeader: String?
    var currentHour: Int?
    var currentMin: Int?
    var flag = true
    var userr = [Users]()
    var isPickerVisible = false
    var data = ["Лекция", "Практика", "Лабораторная", "Факультатив", "Предмет по выбору"]

    @IBOutlet weak var viewFromScroll: UIView!
    @IBAction func weekAction(_ sender: Any) {

        fieldDisabled()
        LoadCalls()
    }
    @IBAction func daysAction(_ sender: Any) {

        fieldDisabled()
        LoadCalls()
    }

    @IBOutlet weak var weekSegmented: UISegmentedControl!
    @IBOutlet weak var daysSegmentedControll: UISegmentedControl!
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    //8:30
    @IBOutlet weak var firstClassTeacherName: UITextField!
    @IBOutlet weak var firstClassClassroomNumber: UITextField!
    @IBOutlet weak var firstClassSubject: UITextField!
    @IBOutlet weak var firstClassSubjectType: UITextField!

    //10:10
    @IBOutlet weak var secondClassTeacherName: UITextField!
    @IBOutlet weak var secondClassSubject: UITextField!
    @IBOutlet weak var secondClassSubjectType: UITextField!
    @IBOutlet weak var secondClassClassroomNumber: UITextField!

    //11:50
    @IBOutlet weak var thirdClassTeacherName: UITextField!
    @IBOutlet weak var thirdClassSubject: UITextField!
    @IBOutlet weak var thirdClassClassroomNumber: UITextField!
    @IBOutlet weak var thirdClassSubjectType: UITextField!
    //13:40
    @IBOutlet weak var fourthClassTeacherName: UITextField!
    @IBOutlet weak var fourthClassSubject: UITextField!
    @IBOutlet weak var fourthClassClassroomNumber: UITextField!
    @IBOutlet weak var fourthClassSubjectType: UITextField!

    //15:10
    @IBOutlet weak var fifthClassTeacherName: UITextField!
    @IBOutlet weak var fifthClassSubject: UITextField!
    @IBOutlet weak var fifthClassClassroomNumber: UITextField!
    @IBOutlet weak var fifthClassSubjectType: UITextField!

    //16:40
    @IBOutlet weak var sixthClassTeacherName: UITextField!
    @IBOutlet weak var sixthClassSubject: UITextField!
    @IBOutlet weak var sixthClassClassroomNumber: UITextField!
    @IBOutlet weak var sixthClassSubjectType: UITextField!

    var activeField: UITextField?

    @objc func tap(gestureReconizer: UITapGestureRecognizer) {

        picker.isHidden = false
    }
    var picker = UIPickerView()

    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        activeField = textField

        return true
    }

    func panelSetup(){
        //8:30
        firstClassTeacherName.attributedPlaceholder = NSAttributedString(string: "Имя преподавателя",attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        firstClassClassroomNumber.attributedPlaceholder = NSAttributedString(string: "Ауд.",attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        firstClassSubject.attributedPlaceholder = NSAttributedString(string: "Название предмета",attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])

        //
        secondClassTeacherName.attributedPlaceholder = NSAttributedString(string: "Имя преподавателя",attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        secondClassClassroomNumber.attributedPlaceholder = NSAttributedString(string: "Ауд.",attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        secondClassSubject.attributedPlaceholder = NSAttributedString(string: "Название предмета",attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])

        //
        thirdClassTeacherName.attributedPlaceholder = NSAttributedString(string: "Имя преподавателя",attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        thirdClassClassroomNumber.attributedPlaceholder = NSAttributedString(string: "Ауд.",attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        thirdClassSubject.attributedPlaceholder = NSAttributedString(string: "Название предмета",attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])

        //
        fourthClassTeacherName.attributedPlaceholder = NSAttributedString(string: "Имя преподавателя",attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        fourthClassClassroomNumber.attributedPlaceholder = NSAttributedString(string: "Ауд.",attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        fourthClassSubject.attributedPlaceholder = NSAttributedString(string: "Название предмета",attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])

        //
        fifthClassTeacherName.attributedPlaceholder = NSAttributedString(string: "Имя преподавателя",attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        fifthClassClassroomNumber.attributedPlaceholder = NSAttributedString(string: "Ауд.",attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        fifthClassSubject.attributedPlaceholder = NSAttributedString(string: "Название предмета",attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])

        //
        sixthClassTeacherName.attributedPlaceholder = NSAttributedString(string: "Имя преподавателя",attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        sixthClassClassroomNumber.attributedPlaceholder = NSAttributedString(string: "Ауд.",attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        sixthClassSubject.attributedPlaceholder = NSAttributedString(string: "Название предмета",attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
    }

    func panelClear(){
        //8:30
        firstClassTeacherName.attributedPlaceholder = NSAttributedString(string: "",attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        firstClassClassroomNumber.attributedPlaceholder = NSAttributedString(string: "",attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        firstClassSubject.attributedPlaceholder = NSAttributedString(string: "",attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])

        //
        secondClassTeacherName.attributedPlaceholder = NSAttributedString(string: "",attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        secondClassClassroomNumber.attributedPlaceholder = NSAttributedString(string: "",attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        secondClassSubject.attributedPlaceholder = NSAttributedString(string: "",attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])

        //
        thirdClassTeacherName.attributedPlaceholder = NSAttributedString(string: "",attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        thirdClassClassroomNumber.attributedPlaceholder = NSAttributedString(string: "",attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        thirdClassSubject.attributedPlaceholder = NSAttributedString(string: "",attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])

        //
        fourthClassTeacherName.attributedPlaceholder = NSAttributedString(string: "",attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        fourthClassClassroomNumber.attributedPlaceholder = NSAttributedString(string: "",attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        fourthClassSubject.attributedPlaceholder = NSAttributedString(string: "",attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])

        //
        fifthClassTeacherName.attributedPlaceholder = NSAttributedString(string: "",attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        fifthClassClassroomNumber.attributedPlaceholder = NSAttributedString(string: "",attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        fifthClassSubject.attributedPlaceholder = NSAttributedString(string: "",attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])

        //
        sixthClassTeacherName.attributedPlaceholder = NSAttributedString(string: "",attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        sixthClassClassroomNumber.attributedPlaceholder = NSAttributedString(string: "",attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        sixthClassSubject.attributedPlaceholder = NSAttributedString(string: "",attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])

    }
    override func viewWillAppear(_ animated: Bool) {

        fieldDisabled()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.panelClear()
            self.getCurrentTime()
            self.highlightCurrentLesson()
            self.LoadCalls()
        })


    }
    override func viewDidLoad() {
        super.viewDidLoad()

        picker.delegate = self
        picker.dataSource = self
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.userUpdate()
            self.viewFromScroll.backgroundColor = UIColor(red: 24.0/255.0, green: 34.0/255.0, blue: 45.0/255.0, alpha: 1.0)
            self.hideKeyboard()
        })
        addPicker()

        firstClassSubjectType.delegate = self
        secondClassSubjectType.delegate = self

    }

    func hidePicker(){

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self.viewFromScroll,
            action: #selector(hidePickerAction))

        self.view.addGestureRecognizer(tap)
        self.view.isUserInteractionEnabled = true
    }

    @objc func hidePickerAction(){

        view.endEditing(true)
    }
    
    override func viewDidLayoutSubviews() {
        UserSetup()
    }

    func userUpdate(){

        userr.removeAll()
        func UserSetup() {
            guard let uid = Auth.auth().currentUser?.uid else {
                //for some reason uid = nil
                return
            }

            Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in

                if let dictionary = snapshot.value as? [String: AnyObject] {
                    let user = Users(dictionary: dictionary)
                    self.userr.append(user)
                }

            }, withCancel: nil)


        }
    }

    func UserSetup() {
        userr.removeAll()
        guard let uid = Auth.auth().currentUser?.uid else {
            //for some reason uid = nil
            return
        }

        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in

            if let dictionary = snapshot.value as? [String: AnyObject] {
                let user = Users(dictionary: dictionary)
                self.userr.append(user)

                self.topBarSetup(user: user)
            }

        }, withCancel: nil)

        
    }

    func topBarSetup(user: Users){

        let uID : String = (Auth.auth().currentUser?.uid)!
        isLeader = user.isLeader
        if isLeader == "true"{
            let testUIBarButtonItem = UIBarButtonItem(title: "Изменить", style: .plain, target: self, action: #selector(scheduleSetup))
            self.navigationItem.rightBarButtonItem  = testUIBarButtonItem
        }
        else{
            
            //is not leader of group
            let testUIBarButtonItem = UIBarButtonItem(title: "Обновить", style: .plain, target: self, action: #selector(scheduleSetup))
            self.navigationItem.rightBarButtonItem  = testUIBarButtonItem
        }

    }

    func fieldEnabled(){

        // 1 - 8.30
        firstClassTeacherName.isEnabled = true
        firstClassClassroomNumber.isEnabled = true
        firstClassSubject.isEnabled = true
        firstClassSubjectType.isEnabled = true

        // 2 - 10:10
        secondClassTeacherName.isEnabled = true
        secondClassClassroomNumber.isEnabled = true
        secondClassSubject.isEnabled = true
        secondClassSubjectType.isEnabled = true

        // 3 - 11:50
        thirdClassTeacherName.isEnabled = true
        thirdClassClassroomNumber.isEnabled = true
        thirdClassSubject.isEnabled = true
        thirdClassSubjectType.isEnabled = true

        // 4 - 13:40
        fourthClassTeacherName.isEnabled = true
        fourthClassClassroomNumber.isEnabled = true
        fourthClassSubject.isEnabled = true
        fourthClassSubjectType.isEnabled = true

        // 5 - 15:10
        fifthClassTeacherName.isEnabled = true
        fifthClassClassroomNumber.isEnabled = true
        fifthClassSubject.isEnabled = true
        fifthClassSubjectType.isEnabled = true

        // 6 - 16:40
        sixthClassTeacherName.isEnabled = true
        sixthClassClassroomNumber.isEnabled = true
        sixthClassSubject.isEnabled = true
        sixthClassSubjectType.isEnabled = true
    }

    func fieldDisabled(){

        // 1 - 8.30
        firstClassTeacherName.isEnabled = false
        firstClassClassroomNumber.isEnabled = false
        firstClassSubject.isEnabled = false
        firstClassSubjectType.isEnabled = false

        // 2 - 10:10
        secondClassTeacherName.isEnabled = false
        secondClassClassroomNumber.isEnabled = false
        secondClassSubject.isEnabled = false
        secondClassSubjectType.isEnabled = false

        // 3 - 11:50
        thirdClassTeacherName.isEnabled = false
        thirdClassClassroomNumber.isEnabled = false
        thirdClassSubject.isEnabled = false
        thirdClassSubjectType.isEnabled = false

        // 4 - 13:40
        fourthClassTeacherName.isEnabled = false
        fourthClassClassroomNumber.isEnabled = false
        fourthClassSubject.isEnabled = false
        fourthClassSubjectType.isEnabled = false

        // 5 - 15:10
        fifthClassTeacherName.isEnabled = false
        fifthClassClassroomNumber.isEnabled = false
        fifthClassSubject.isEnabled = false
        fifthClassSubjectType.isEnabled = false

        // 6 - 16:40
        sixthClassTeacherName.isEnabled = false
        sixthClassClassroomNumber.isEnabled = false
        sixthClassSubject.isEnabled = false
        sixthClassSubjectType.isEnabled = false
    }

    func fieldClear(){

        // 1 - 8.30

        firstClassSubject.fadeTransition(1)
        firstClassSubjectType.fadeTransition(1)
        firstClassTeacherName.fadeTransition(1)
        firstClassClassroomNumber.fadeTransition(1)

        firstClassTeacherName.text = ""
        firstClassClassroomNumber.text = ""
        firstClassSubject.text = ""
        firstClassSubjectType.text = ""

        // 2 - 10:10
        secondClassTeacherName.fadeTransition(1)
        secondClassClassroomNumber.fadeTransition(1)
        secondClassSubjectType.fadeTransition(1)
        secondClassSubject.fadeTransition(1)

        secondClassTeacherName.text = ""
        secondClassClassroomNumber.text = ""
        secondClassSubject.text = ""
        secondClassSubjectType.text = ""

        // 3 - 11:50
        thirdClassTeacherName.fadeTransition(1)
        thirdClassClassroomNumber.fadeTransition(1)
        thirdClassSubjectType.fadeTransition(1)
        thirdClassSubject.fadeTransition(1)

        thirdClassTeacherName.text = ""
        thirdClassClassroomNumber.text = ""
        thirdClassSubject.text = ""
        thirdClassSubjectType.text = ""

        // 4 - 13:40
        fourthClassSubject.fadeTransition(1)
        fourthClassTeacherName.fadeTransition(1)
        fourthClassClassroomNumber.fadeTransition(1)
        fourthClassSubjectType.fadeTransition(1)

        fourthClassTeacherName.text = ""
        fourthClassClassroomNumber.text = ""
        fourthClassSubject.text = ""
        fourthClassSubjectType.text = ""

        // 5 - 15:10
        fifthClassSubject.fadeTransition(1)
        fifthClassTeacherName.fadeTransition(1)
        fifthClassClassroomNumber.fadeTransition(1)
        fifthClassSubjectType.fadeTransition(1)

        fifthClassTeacherName.text = ""
        fifthClassClassroomNumber.text = ""
        fifthClassSubject.text = ""
        fifthClassSubjectType.text = ""

        // 6 - 16:40
        sixthClassTeacherName.fadeTransition(1)
        sixthClassClassroomNumber.fadeTransition(1)
        sixthClassSubjectType.fadeTransition(1)
        sixthClassSubject.fadeTransition(1)
        
        sixthClassTeacherName.text = ""
        sixthClassClassroomNumber.text = ""
        sixthClassSubject.text = ""
        sixthClassSubjectType.text = ""
    }


    //Get Time
    func getCurrentTime(){
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        currentHour = hour
        currentMin = minutes
    }

    func highlightCurrentLesson(){
        if (currentHour! >= 8 && currentHour! < 10){

            self.view.viewWithTag(1)?.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            self.view.viewWithTag(2)?.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.2352941176, blue: 0.2823529412, alpha: 1)
            self.view.viewWithTag(3)?.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.2352941176, blue: 0.2823529412, alpha: 1)
            self.view.viewWithTag(4)?.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.2352941176, blue: 0.2823529412, alpha: 1)
            self.view.viewWithTag(5)?.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.2352941176, blue: 0.2823529412, alpha: 1)
            self.view.viewWithTag(6)?.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.2352941176, blue: 0.2823529412, alpha: 1)


        }else if (currentHour! >= 10 && currentHour! < 11){

            self.view.viewWithTag(2)?.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            self.view.viewWithTag(1)?.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.2352941176, blue: 0.2823529412, alpha: 1)
            self.view.viewWithTag(3)?.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.2352941176, blue: 0.2823529412, alpha: 1)
            self.view.viewWithTag(4)?.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.2352941176, blue: 0.2823529412, alpha: 1)
            self.view.viewWithTag(5)?.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.2352941176, blue: 0.2823529412, alpha: 1)
            self.view.viewWithTag(6)?.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.2352941176, blue: 0.2823529412, alpha: 1)


        }else if (currentHour! >= 11 && currentHour! < 13){

            self.view.viewWithTag(3)?.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            self.view.viewWithTag(1)?.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.2352941176, blue: 0.2823529412, alpha: 1)
            self.view.viewWithTag(2)?.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.2352941176, blue: 0.2823529412, alpha: 1)
            self.view.viewWithTag(4)?.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.2352941176, blue: 0.2823529412, alpha: 1)
            self.view.viewWithTag(5)?.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.2352941176, blue: 0.2823529412, alpha: 1)
            self.view.viewWithTag(6)?.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.2352941176, blue: 0.2823529412, alpha: 1)


        }else if (currentHour! >= 13 && currentHour! < 15){

            self.view.viewWithTag(4)?.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            self.view.viewWithTag(1)?.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.2352941176, blue: 0.2823529412, alpha: 1)
            self.view.viewWithTag(2)?.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.2352941176, blue: 0.2823529412, alpha: 1)
            self.view.viewWithTag(3)?.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.2352941176, blue: 0.2823529412, alpha: 1)
            self.view.viewWithTag(5)?.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.2352941176, blue: 0.2823529412, alpha: 1)
            self.view.viewWithTag(6)?.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.2352941176, blue: 0.2823529412, alpha: 1)


        }else if (currentHour! >= 15 && currentHour! < 16){

            self.view.viewWithTag(5)?.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            self.view.viewWithTag(1)?.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.2352941176, blue: 0.2823529412, alpha: 1)
            self.view.viewWithTag(2)?.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.2352941176, blue: 0.2823529412, alpha: 1)
            self.view.viewWithTag(3)?.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.2352941176, blue: 0.2823529412, alpha: 1)
            self.view.viewWithTag(4)?.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.2352941176, blue: 0.2823529412, alpha: 1)
            self.view.viewWithTag(6)?.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.2352941176, blue: 0.2823529412, alpha: 1)


        }else if (currentHour! >= 16 && currentHour! < 18){

            self.view.viewWithTag(6)?.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            self.view.viewWithTag(1)?.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.2352941176, blue: 0.2823529412, alpha: 1)
            self.view.viewWithTag(2)?.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.2352941176, blue: 0.2823529412, alpha: 1)
            self.view.viewWithTag(3)?.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.2352941176, blue: 0.2823529412, alpha: 1)
            self.view.viewWithTag(4)?.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.2352941176, blue: 0.2823529412, alpha: 1)
            self.view.viewWithTag(5)?.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.2352941176, blue: 0.2823529412, alpha: 1)


        }else if (currentHour! >= 18){

            self.view.viewWithTag(1)?.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.2352941176, blue: 0.2823529412, alpha: 1)
            self.view.viewWithTag(2)?.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.2352941176, blue: 0.2823529412, alpha: 1)
            self.view.viewWithTag(3)?.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.2352941176, blue: 0.2823529412, alpha: 1)
            self.view.viewWithTag(4)?.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.2352941176, blue: 0.2823529412, alpha: 1)
            self.view.viewWithTag(5)?.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.2352941176, blue: 0.2823529412, alpha: 1)
            self.view.viewWithTag(6)?.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.2352941176, blue: 0.2823529412, alpha: 1)


        }
    }

    //Chedule
    @objc func scheduleSetup() {
        let eventStore : EKEventStore = EKEventStore()

        // 'EKEntityTypeReminder' or 'EKEntityTypeEvent'

        ///Setup current start and end date!!!
        //let date = Calendar.current.date(bySettingHour: 12, minute: 30, second: 0, of: Date())!
        eventStore.requestAccess(to: .event) { (granted, error) in

            if (granted) && (error == nil) {
                print("granted \(granted)")
                print("error \(error)")

                let event:EKEvent = EKEvent(eventStore: eventStore)

                event.title = "Мат. анализ (511)"
                event.startDate = Date()
                event.endDate = Date()
                event.notes = "Тоточенко"
                event.calendar = eventStore.defaultCalendarForNewEvents
                do {
                    try eventStore.save(event, span: .thisEvent)
                } catch let error as NSError {
                    print("failed to save event with error : \(error)")
                }
                print("Saved Event")
            }
            else{

                print("failed to save event with error : \(error) or access not granted")
            }
        }

        if isLeader == "true"{

            if flag == true{

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                    self.navigationItem.rightBarButtonItem!.title = "Сохранить"
                })
                flag = false

            }else{
                if isLeader == "true"{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                        self.navigationItem.rightBarButtonItem!.title = "Изменить"
                    })

                    flag = true
                }
            }

        }else{

            return
        }

        print(flag)


        isPickerVisible = true
        if isPickerVisible == true{

            addPicker()
            isPickerVisible = false
        }else{

            hidePickerAction()
        }
        if sixthClassTeacherName.isEnabled == false{

            fieldEnabled()
        }else{

            fieldDisabled()
        }


        guard let uid = Auth.auth().currentUser?.uid else {
            //for some reason uid = nil
            return
        }

        let group = userr.map { $0.group as! String}
        let _group = group[0]

        var week = ""
        if weekSegmented.selectedSegmentIndex == 0{
            week = "weekA"
        }else{
            week = "weekB"
        }

        var dayOfWeek: String?
        if daysSegmentedControll.selectedSegmentIndex == 0{

            dayOfWeek = "Понедельник"

        }else if daysSegmentedControll.selectedSegmentIndex == 1{

            dayOfWeek = "Вторник"
        }else if daysSegmentedControll.selectedSegmentIndex == 2{
        

            dayOfWeek = "Среда"
        }else if daysSegmentedControll.selectedSegmentIndex == 3{


            dayOfWeek = "Четверг"
        }else if daysSegmentedControll.selectedSegmentIndex == 4{


            dayOfWeek = "Пятница"
        }else if daysSegmentedControll.selectedSegmentIndex == 5{


            dayOfWeek = "Суббота"
        }

        let root = Database.database().reference().child("schedule")

        let post = ["Преподаватель": "\(firstClassTeacherName.text!)",
                    "Тип": "\(firstClassSubjectType.text!)",
                    "Название предмета": "\(firstClassSubject.text!)",
                    "Аудитория": "\(firstClassClassroomNumber.text!)"
        ]
        let post2 = ["Преподаватель": "\(secondClassTeacherName.text!)",
            "Тип": "\(secondClassSubjectType.text!)",
            "Название предмета": "\(secondClassSubject.text!)",
            "Аудитория": "\(secondClassClassroomNumber.text!)"
        ]
        let post3 = ["Преподаватель": "\(thirdClassTeacherName.text!)",
            "Тип": "\(thirdClassSubjectType.text!)",
            "Название предмета": "\(thirdClassSubject.text!)",
            "Аудитория": "\(thirdClassClassroomNumber.text!)"
        ]
        let post4 = ["Преподаватель": "\(fourthClassTeacherName.text!)",
            "Тип": "\(fourthClassSubjectType.text!)",
            "Название предмета": "\(fourthClassSubject.text!)",
            "Аудитория": "\(fourthClassClassroomNumber.text!)"
        ]
        let post5 = ["Преподаватель": "\(fifthClassTeacherName.text!)",
            "Тип": "\(fifthClassSubjectType.text!)",
            "Название предмета": "\(fifthClassSubject.text!)",
            "Аудитория": "\(fifthClassClassroomNumber.text!)"
        ]
        let post6 = ["Преподаватель": "\(sixthClassTeacherName.text!)",
            "Тип": "\(sixthClassSubjectType.text!)",
            "Название предмета": "\(firstClassSubject.text!)",
            "Аудитория": "\(sixthClassClassroomNumber.text!)"
        ]
        let childUpdates = ["/\(_group)/\(week)/\(dayOfWeek!)/1/": post,
                            "/\(_group)/\(week)/\(dayOfWeek!)/2/": post2,
                            "/\(_group)/\(week)/\(dayOfWeek!)/3/": post3,
                            "/\(_group)/\(week)/\(dayOfWeek!)/4/": post4,
                            "/\(_group)/\(week)/\(dayOfWeek!)/5/": post5,
                            "/\(_group)/\(week)/\(dayOfWeek!)/6/": post6
        ]
        root.updateChildValues(childUpdates)
    }

    func addPicker(){

        let picker: UIPickerView
        picker = UIPickerView(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: 200))
        picker.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.85)

        picker.showsSelectionIndicator = true
        picker.delegate = self
        picker.dataSource = self

        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.blackTranslucent
        toolBar.isTranslucent = true
        toolBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Выбрать", style: UIBarButtonItemStyle.plain, target: self, action: "donePicker")
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Отменить", style: UIBarButtonItemStyle.plain, target: self, action: #selector(hidePickerAction))

        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        firstClassSubjectType.inputView = picker
        firstClassSubjectType.inputAccessoryView = toolBar

        secondClassSubjectType.inputView = picker
        secondClassSubjectType.inputAccessoryView = toolBar

        thirdClassSubjectType.inputView = picker
        thirdClassSubjectType.inputAccessoryView = toolBar

        fourthClassSubjectType.inputView = picker
        fourthClassSubjectType.inputAccessoryView = toolBar

        fifthClassSubjectType.inputView = picker
        fifthClassSubjectType.inputAccessoryView = toolBar

        sixthClassSubjectType.inputView = picker
        sixthClassSubjectType.inputAccessoryView = toolBar

    }

    var snusBrandsArray = [[String:AnyObject]]()
    func LoadCalls() {

//        let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.alert)
//        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
//        self.present(alert, animated: true, completion: nil)

        let sv = UIViewController.displaySpinner(onView: self.view)
        fieldClear()
        let ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid


        let group = userr.map { $0.group as! String}
        let _group = "141"

        var week = ""
        if weekSegmented.selectedSegmentIndex == 0{
            week = "weekA"
        }else{
            week = "weekB"
        }

        var dayOfWeek: String?
        if daysSegmentedControll.selectedSegmentIndex == 0{

            dayOfWeek = "Понедельник"

        }else if daysSegmentedControll.selectedSegmentIndex == 1{

            dayOfWeek = "Вторник"

        }else if daysSegmentedControll.selectedSegmentIndex == 2{

            dayOfWeek = "Среда"

        }else if daysSegmentedControll.selectedSegmentIndex == 3{

            dayOfWeek = "Четверг"

        }else if daysSegmentedControll.selectedSegmentIndex == 4{

            dayOfWeek = "Пятница"

        }else if daysSegmentedControll.selectedSegmentIndex == 5{

            dayOfWeek = "Суббота"
        }

        //ПОНЕДЕЛЬНИК
        //1
        ref.child("schedule").child("\(_group)").child("\(week)").child("\(dayOfWeek!)").child("1").observe(.childAdded, with: { (snapshot) in

            if snapshot.key == "Тип"{

                self.firstClassSubjectType.fadeTransition(1)
                self.firstClassSubjectType.text = snapshot.value as! String

            }else if snapshot.key == "Аудитория"{

                self.fifthClassClassroomNumber.fadeTransition(1)
                self.firstClassClassroomNumber.text = snapshot.value as! String

            }else if snapshot.key == "Преподаватель"{

                self.fifthClassTeacherName.fadeTransition(1)
                self.firstClassTeacherName.text = snapshot.value as! String

            }else if snapshot.key == "Название предмета"{

                self.firstClassSubject.fadeTransition(1)
                self.firstClassSubject.text = snapshot.value as! String
            }else{

                return

            }

        })

        //2
        ref.child("schedule").child("\(_group)").child("\(week)").child("\(dayOfWeek!)").child("2").observe(.childAdded, with: { (snapshot) in

            if snapshot.key == "Тип"{

                self.secondClassSubjectType.fadeTransition(1)
                self.secondClassSubjectType.text = snapshot.value as! String

            }else if snapshot.key == "Аудитория"{

                self.secondClassClassroomNumber.fadeTransition(1)
                self.secondClassClassroomNumber.text = snapshot.value as! String

            }else if snapshot.key == "Преподаватель"{

                self.secondClassTeacherName.fadeTransition(1)
                self.secondClassTeacherName.text = snapshot.value as! String

            }else if snapshot.key == "Название предмета"{

                self.secondClassSubject.fadeTransition(1)
                self.secondClassSubject.text = snapshot.value as! String
            }else{

                return

            }

        })

        //3
        ref.child("schedule").child("\(_group)").child("\(week)").child("\(dayOfWeek!)").child("3").observe(.childAdded, with: { (snapshot) in

            if snapshot.key == "Тип"{

                self.thirdClassSubjectType.fadeTransition(1)
                self.thirdClassSubjectType.text = snapshot.value as! String

            }else if snapshot.key == "Аудитория"{

                self.thirdClassClassroomNumber.fadeTransition(1)
                self.thirdClassClassroomNumber.text = snapshot.value as! String

            }else if snapshot.key == "Преподаватель"{

                self.thirdClassTeacherName.fadeTransition(1)
                self.thirdClassTeacherName.text = snapshot.value as! String

            }else if snapshot.key == "Название предмета"{

                self.thirdClassSubjectType.fadeTransition(1)
                self.thirdClassSubject.text = snapshot.value as! String
            }else{

                return

            }

        })

        //4
        ref.child("schedule").child("\(_group)").child("\(week)").child("\(dayOfWeek!)").child("4").observe(.childAdded, with: { (snapshot) in

            if snapshot.key == "Тип"{

                self.fourthClassSubjectType.fadeTransition(1)
                self.fourthClassSubjectType.text = snapshot.value as! String

            }else if snapshot.key == "Аудитория"{

                self.fourthClassClassroomNumber.fadeTransition(1)
                self.fourthClassClassroomNumber.text = snapshot.value as! String

            }else if snapshot.key == "Преподаватель"{

                self.fourthClassTeacherName.fadeTransition(1)
                self.fourthClassTeacherName.text = snapshot.value as! String

            }else if snapshot.key == "Название предмета"{

                self.fourthClassSubject.fadeTransition(1)
                self.fourthClassSubject.text = snapshot.value as! String
            }else{

                return

            }

        })

        //5
        ref.child("schedule").child("\(_group)").child("\(week)").child("\(dayOfWeek!)").child("5").observe(.childAdded, with: { (snapshot) in

            if snapshot.key == "Тип"{

                self.firstClassSubjectType.fadeTransition(1)
                self.fifthClassSubjectType.text = snapshot.value as! String

            }else if snapshot.key == "Аудитория"{

                self.fifthClassClassroomNumber.fadeTransition(1)
                self.fifthClassClassroomNumber.text = snapshot.value as! String

            }else if snapshot.key == "Преподаватель"{

                self.fifthClassTeacherName.fadeTransition(1)
                self.fifthClassTeacherName.text = snapshot.value as! String

            }else if snapshot.key == "Название предмета"{

                self.fifthClassSubject.fadeTransition(1)
                self.fifthClassSubject.text = snapshot.value as! String
            }else{

                return

            }

        })

        //6
        ref.child("schedule").child("\(_group)").child("\(week)").child("\(dayOfWeek!)").child("6").observe(.childAdded, with: { (snapshot) in

            if snapshot.key == "Тип"{

                self.sixthClassSubjectType.fadeTransition(1)
                self.sixthClassSubjectType.text = snapshot.value as! String

            }else if snapshot.key == "Аудитория"{

                self.sixthClassClassroomNumber.fadeTransition(1)
                self.sixthClassClassroomNumber.text = snapshot.value as! String

            }else if snapshot.key == "Преподаватель"{

                self.sixthClassTeacherName.fadeTransition(1)
                self.sixthClassTeacherName.text = snapshot.value as! String

            }else if snapshot.key == "Название предмета"{

                self.sixthClassSubjectType.fadeTransition(1)
                self.sixthClassSubject.text = snapshot.value as! String
            }else{

                return

            }

        })

        //ВТОРНИК
        //1
        ref.child("schedule").child("\(_group)").child("\(week)").child("\(dayOfWeek!)").child("1").observe(.childAdded, with: { (snapshot) in

            if snapshot.key == "Тип"{

                self.firstClassSubjectType.fadeTransition(1)
                self.firstClassSubjectType.text = snapshot.value as! String

            }else if snapshot.key == "Аудитория"{

                self.fifthClassClassroomNumber.fadeTransition(1)
                self.firstClassClassroomNumber.text = snapshot.value as! String

            }else if snapshot.key == "Преподаватель"{

                self.fifthClassTeacherName.fadeTransition(1)
                self.firstClassTeacherName.text = snapshot.value as! String

            }else if snapshot.key == "Название предмета"{

                self.firstClassSubject.fadeTransition(1)
                self.firstClassSubject.text = snapshot.value as! String
            }else{

                return

            }

        })

        //2
        ref.child("schedule").child("\(_group)").child("\(week)").child("\(dayOfWeek!)").child("2").observe(.childAdded, with: { (snapshot) in

            if snapshot.key == "Тип"{

                self.secondClassSubjectType.fadeTransition(1)
                self.secondClassSubjectType.text = snapshot.value as! String

            }else if snapshot.key == "Аудитория"{

                self.secondClassClassroomNumber.fadeTransition(1)
                self.secondClassClassroomNumber.text = snapshot.value as! String

            }else if snapshot.key == "Преподаватель"{

                self.secondClassTeacherName.fadeTransition(1)
                self.secondClassTeacherName.text = snapshot.value as! String

            }else if snapshot.key == "Название предмета"{

                self.secondClassSubject.fadeTransition(1)
                self.secondClassSubject.text = snapshot.value as! String
            }else{

                return

            }

        })

        //3
        ref.child("schedule").child("\(_group)").child("\(week)").child("\(dayOfWeek!)").child("3").observe(.childAdded, with: { (snapshot) in

            if snapshot.key == "Тип"{

                self.thirdClassSubjectType.fadeTransition(1)
                self.thirdClassSubjectType.text = snapshot.value as! String

            }else if snapshot.key == "Аудитория"{

                self.thirdClassClassroomNumber.fadeTransition(1)
                self.thirdClassClassroomNumber.text = snapshot.value as! String

            }else if snapshot.key == "Преподаватель"{

                self.thirdClassTeacherName.fadeTransition(1)
                self.thirdClassTeacherName.text = snapshot.value as! String

            }else if snapshot.key == "Название предмета"{

                self.thirdClassSubjectType.fadeTransition(1)
                self.thirdClassSubject.text = snapshot.value as! String
            }else{

                return

            }

        })

        //4
        ref.child("schedule").child("\(_group)").child("\(week)").child("\(dayOfWeek!)").child("4").observe(.childAdded, with: { (snapshot) in

            if snapshot.key == "Тип"{

                self.fourthClassSubjectType.fadeTransition(1)
                self.fourthClassSubjectType.text = snapshot.value as! String

            }else if snapshot.key == "Аудитория"{

                self.fourthClassClassroomNumber.fadeTransition(1)
                self.fourthClassClassroomNumber.text = snapshot.value as! String

            }else if snapshot.key == "Преподаватель"{

                self.fourthClassTeacherName.fadeTransition(1)
                self.fourthClassTeacherName.text = snapshot.value as! String

            }else if snapshot.key == "Название предмета"{

                self.fourthClassSubject.fadeTransition(1)
                self.fourthClassSubject.text = snapshot.value as! String
            }else{

                return

            }

        })

        //5
        ref.child("schedule").child("\(_group)").child("\(week)").child("\(dayOfWeek!)").child("5").observe(.childAdded, with: { (snapshot) in

            if snapshot.key == "Тип"{

                self.firstClassSubjectType.fadeTransition(1)
                self.fifthClassSubjectType.text = snapshot.value as! String

            }else if snapshot.key == "Аудитория"{

                self.fifthClassClassroomNumber.fadeTransition(1)
                self.fifthClassClassroomNumber.text = snapshot.value as! String

            }else if snapshot.key == "Преподаватель"{

                self.fifthClassTeacherName.fadeTransition(1)
                self.fifthClassTeacherName.text = snapshot.value as! String

            }else if snapshot.key == "Название предмета"{

                self.fifthClassSubject.fadeTransition(1)
                self.fifthClassSubject.text = snapshot.value as! String
            }else{

                return

            }

        })

        //6
        ref.child("schedule").child("\(_group)").child("\(week)").child("\(dayOfWeek!)").child("6").observe(.childAdded, with: { (snapshot) in

            if snapshot.key == "Тип"{

                self.sixthClassSubjectType.fadeTransition(1)
                self.sixthClassSubjectType.text = snapshot.value as! String

            }else if snapshot.key == "Аудитория"{

                self.sixthClassClassroomNumber.fadeTransition(1)
                self.sixthClassClassroomNumber.text = snapshot.value as! String

            }else if snapshot.key == "Преподаватель"{

                self.sixthClassTeacherName.fadeTransition(1)
                self.sixthClassTeacherName.text = snapshot.value as! String

            }else if snapshot.key == "Название предмета"{

                self.sixthClassSubjectType.fadeTransition(1)
                self.sixthClassSubject.text = snapshot.value as! String
            }else{

                return

            }

        })

        //СРЕДА
        //1
        ref.child("schedule").child("\(_group)").child("\(week)").child("\(dayOfWeek!)").child("1").observe(.childAdded, with: { (snapshot) in

            if snapshot.key == "Тип"{

                self.firstClassSubjectType.fadeTransition(1)
                self.firstClassSubjectType.text = snapshot.value as! String

            }else if snapshot.key == "Аудитория"{

                self.fifthClassClassroomNumber.fadeTransition(1)
                self.firstClassClassroomNumber.text = snapshot.value as! String

            }else if snapshot.key == "Преподаватель"{

                self.fifthClassTeacherName.fadeTransition(1)
                self.firstClassTeacherName.text = snapshot.value as! String

            }else if snapshot.key == "Название предмета"{

                self.firstClassSubject.fadeTransition(1)
                self.firstClassSubject.text = snapshot.value as! String
            }else{

                return

            }

        })

        //2
        ref.child("schedule").child("\(_group)").child("\(week)").child("\(dayOfWeek!)").child("2").observe(.childAdded, with: { (snapshot) in

            if snapshot.key == "Тип"{

                self.secondClassSubjectType.fadeTransition(1)
                self.secondClassSubjectType.text = snapshot.value as! String

            }else if snapshot.key == "Аудитория"{

                self.secondClassClassroomNumber.fadeTransition(1)
                self.secondClassClassroomNumber.text = snapshot.value as! String

            }else if snapshot.key == "Преподаватель"{

                self.secondClassTeacherName.fadeTransition(1)
                self.secondClassTeacherName.text = snapshot.value as! String

            }else if snapshot.key == "Название предмета"{

                self.secondClassSubject.fadeTransition(1)
                self.secondClassSubject.text = snapshot.value as! String
            }else{

                return

            }

        })

        //3
        ref.child("schedule").child("\(_group)").child("\(week)").child("\(dayOfWeek!)").child("3").observe(.childAdded, with: { (snapshot) in

            if snapshot.key == "Тип"{

                self.thirdClassSubjectType.fadeTransition(1)
                self.thirdClassSubjectType.text = snapshot.value as! String

            }else if snapshot.key == "Аудитория"{

                self.thirdClassClassroomNumber.fadeTransition(1)
                self.thirdClassClassroomNumber.text = snapshot.value as! String

            }else if snapshot.key == "Преподаватель"{

                self.thirdClassTeacherName.fadeTransition(1)
                self.thirdClassTeacherName.text = snapshot.value as! String

            }else if snapshot.key == "Название предмета"{

                self.thirdClassSubjectType.fadeTransition(1)
                self.thirdClassSubject.text = snapshot.value as! String
            }else{

                return

            }

        })

        //4
        ref.child("schedule").child("\(_group)").child("\(week)").child("\(dayOfWeek!)").child("4").observe(.childAdded, with: { (snapshot) in

            if snapshot.key == "Тип"{

                self.fourthClassSubjectType.fadeTransition(1)
                self.fourthClassSubjectType.text = snapshot.value as! String

            }else if snapshot.key == "Аудитория"{

                self.fourthClassClassroomNumber.fadeTransition(1)
                self.fourthClassClassroomNumber.text = snapshot.value as! String

            }else if snapshot.key == "Преподаватель"{

                self.fourthClassTeacherName.fadeTransition(1)
                self.fourthClassTeacherName.text = snapshot.value as! String

            }else if snapshot.key == "Название предмета"{

                self.fourthClassSubject.fadeTransition(1)
                self.fourthClassSubject.text = snapshot.value as! String
            }else{

                return

            }

        })

        //5
        ref.child("schedule").child("\(_group)").child("\(week)").child("\(dayOfWeek!)").child("5").observe(.childAdded, with: { (snapshot) in

            if snapshot.key == "Тип"{

                self.firstClassSubjectType.fadeTransition(1)
                self.fifthClassSubjectType.text = snapshot.value as! String

            }else if snapshot.key == "Аудитория"{

                self.fifthClassClassroomNumber.fadeTransition(1)
                self.fifthClassClassroomNumber.text = snapshot.value as! String

            }else if snapshot.key == "Преподаватель"{

                self.fifthClassTeacherName.fadeTransition(1)
                self.fifthClassTeacherName.text = snapshot.value as! String

            }else if snapshot.key == "Название предмета"{

                self.fifthClassSubject.fadeTransition(1)
                self.fifthClassSubject.text = snapshot.value as! String
            }else{

                return

            }

        })

        //6
        ref.child("schedule").child("\(_group)").child("\(week)").child("\(dayOfWeek!)").child("6").observe(.childAdded, with: { (snapshot) in

            if snapshot.key == "Тип"{

                self.sixthClassSubjectType.fadeTransition(1)
                self.sixthClassSubjectType.text = snapshot.value as! String

            }else if snapshot.key == "Аудитория"{

                self.sixthClassClassroomNumber.fadeTransition(1)
                self.sixthClassClassroomNumber.text = snapshot.value as! String

            }else if snapshot.key == "Преподаватель"{

                self.sixthClassTeacherName.fadeTransition(1)
                self.sixthClassTeacherName.text = snapshot.value as! String

            }else if snapshot.key == "Название предмета"{

                self.sixthClassSubjectType.fadeTransition(1)
                self.sixthClassSubject.text = snapshot.value as! String
            }else{

                return

            }

        })

        //ЧЕТВЕРГ
        //1
        ref.child("schedule").child("\(_group)").child("\(week)").child("\(dayOfWeek!)").child("1").observe(.childAdded, with: { (snapshot) in

            if snapshot.key == "Тип"{

                self.firstClassSubjectType.fadeTransition(1)
                self.firstClassSubjectType.text = snapshot.value as! String

            }else if snapshot.key == "Аудитория"{

                self.fifthClassClassroomNumber.fadeTransition(1)
                self.firstClassClassroomNumber.text = snapshot.value as! String

            }else if snapshot.key == "Преподаватель"{

                self.fifthClassTeacherName.fadeTransition(1)
                self.firstClassTeacherName.text = snapshot.value as! String

            }else if snapshot.key == "Название предмета"{

                self.firstClassSubject.fadeTransition(1)
                self.firstClassSubject.text = snapshot.value as! String
            }else{

                return

            }

        })

        //2
        ref.child("schedule").child("\(_group)").child("\(week)").child("\(dayOfWeek!)").child("2").observe(.childAdded, with: { (snapshot) in

            if snapshot.key == "Тип"{

                self.secondClassSubjectType.fadeTransition(1)
                self.secondClassSubjectType.text = snapshot.value as! String

            }else if snapshot.key == "Аудитория"{

                self.secondClassClassroomNumber.fadeTransition(1)
                self.secondClassClassroomNumber.text = snapshot.value as! String

            }else if snapshot.key == "Преподаватель"{

                self.secondClassTeacherName.fadeTransition(1)
                self.secondClassTeacherName.text = snapshot.value as! String

            }else if snapshot.key == "Название предмета"{

                self.secondClassSubject.fadeTransition(1)
                self.secondClassSubject.text = snapshot.value as! String
            }else{

                return

            }

        })

        //3
        ref.child("schedule").child("\(_group)").child("\(week)").child("\(dayOfWeek!)").child("3").observe(.childAdded, with: { (snapshot) in

            if snapshot.key == "Тип"{

                self.thirdClassSubjectType.fadeTransition(1)
                self.thirdClassSubjectType.text = snapshot.value as! String

            }else if snapshot.key == "Аудитория"{

                self.thirdClassClassroomNumber.fadeTransition(1)
                self.thirdClassClassroomNumber.text = snapshot.value as! String

            }else if snapshot.key == "Преподаватель"{

                self.thirdClassTeacherName.fadeTransition(1)
                self.thirdClassTeacherName.text = snapshot.value as! String

            }else if snapshot.key == "Название предмета"{

                self.thirdClassSubjectType.fadeTransition(1)
                self.thirdClassSubject.text = snapshot.value as! String
            }else{

                return

            }

        })

        //4
        ref.child("schedule").child("\(_group)").child("\(week)").child("\(dayOfWeek!)").child("4").observe(.childAdded, with: { (snapshot) in

            if snapshot.key == "Тип"{

                self.fourthClassSubjectType.fadeTransition(1)
                self.fourthClassSubjectType.text = snapshot.value as! String

            }else if snapshot.key == "Аудитория"{

                self.fourthClassClassroomNumber.fadeTransition(1)
                self.fourthClassClassroomNumber.text = snapshot.value as! String

            }else if snapshot.key == "Преподаватель"{

                self.fourthClassTeacherName.fadeTransition(1)
                self.fourthClassTeacherName.text = snapshot.value as! String

            }else if snapshot.key == "Название предмета"{

                self.fourthClassSubject.fadeTransition(1)
                self.fourthClassSubject.text = snapshot.value as! String
            }else{

                return

            }

        })

        //5
        ref.child("schedule").child("\(_group)").child("\(week)").child("\(dayOfWeek!)").child("5").observe(.childAdded, with: { (snapshot) in

            if snapshot.key == "Тип"{

                self.firstClassSubjectType.fadeTransition(1)
                self.fifthClassSubjectType.text = snapshot.value as! String

            }else if snapshot.key == "Аудитория"{

                self.fifthClassClassroomNumber.fadeTransition(1)
                self.fifthClassClassroomNumber.text = snapshot.value as! String

            }else if snapshot.key == "Преподаватель"{

                self.fifthClassTeacherName.fadeTransition(1)
                self.fifthClassTeacherName.text = snapshot.value as! String

            }else if snapshot.key == "Название предмета"{

                self.fifthClassSubject.fadeTransition(1)
                self.fifthClassSubject.text = snapshot.value as! String
            }else{

                return

            }

        })

        //6
        ref.child("schedule").child("\(_group)").child("\(week)").child("\(dayOfWeek!)").child("6").observe(.childAdded, with: { (snapshot) in

            if snapshot.key == "Тип"{

                self.sixthClassSubjectType.fadeTransition(1)
                self.sixthClassSubjectType.text = snapshot.value as! String

            }else if snapshot.key == "Аудитория"{

                self.sixthClassClassroomNumber.fadeTransition(1)
                self.sixthClassClassroomNumber.text = snapshot.value as! String

            }else if snapshot.key == "Преподаватель"{

                self.sixthClassTeacherName.fadeTransition(1)
                self.sixthClassTeacherName.text = snapshot.value as! String

            }else if snapshot.key == "Название предмета"{

                self.sixthClassSubjectType.fadeTransition(1)
                self.sixthClassSubject.text = snapshot.value as! String
            }else{

                return

            }

        })

        //ПЯТНИЦА
        //1
        ref.child("schedule").child("\(_group)").child("\(week)").child("\(dayOfWeek!)").child("1").observe(.childAdded, with: { (snapshot) in

            if snapshot.key == "Тип"{

                self.firstClassSubjectType.fadeTransition(1)
                self.firstClassSubjectType.text = snapshot.value as! String

            }else if snapshot.key == "Аудитория"{

                self.fifthClassClassroomNumber.fadeTransition(1)
                self.firstClassClassroomNumber.text = snapshot.value as! String

            }else if snapshot.key == "Преподаватель"{

                self.fifthClassTeacherName.fadeTransition(1)
                self.firstClassTeacherName.text = snapshot.value as! String

            }else if snapshot.key == "Название предмета"{

                self.firstClassSubject.fadeTransition(1)
                self.firstClassSubject.text = snapshot.value as! String
            }else{

                return

            }

        })

        //2
        ref.child("schedule").child("\(_group)").child("\(week)").child("\(dayOfWeek!)").child("2").observe(.childAdded, with: { (snapshot) in

            if snapshot.key == "Тип"{

                self.secondClassSubjectType.fadeTransition(1)
                self.secondClassSubjectType.text = snapshot.value as! String

            }else if snapshot.key == "Аудитория"{

                self.secondClassClassroomNumber.fadeTransition(1)
                self.secondClassClassroomNumber.text = snapshot.value as! String

            }else if snapshot.key == "Преподаватель"{

                self.secondClassTeacherName.fadeTransition(1)
                self.secondClassTeacherName.text = snapshot.value as! String

            }else if snapshot.key == "Название предмета"{

                self.secondClassSubject.fadeTransition(1)
                self.secondClassSubject.text = snapshot.value as! String
            }else{

                return

            }

        })

        //3
        ref.child("schedule").child("\(_group)").child("\(week)").child("\(dayOfWeek!)").child("3").observe(.childAdded, with: { (snapshot) in

            if snapshot.key == "Тип"{

                self.thirdClassSubjectType.fadeTransition(1)
                self.thirdClassSubjectType.text = snapshot.value as! String

            }else if snapshot.key == "Аудитория"{

                self.thirdClassClassroomNumber.fadeTransition(1)
                self.thirdClassClassroomNumber.text = snapshot.value as! String

            }else if snapshot.key == "Преподаватель"{

                self.thirdClassTeacherName.fadeTransition(1)
                self.thirdClassTeacherName.text = snapshot.value as! String

            }else if snapshot.key == "Название предмета"{

                self.thirdClassSubjectType.fadeTransition(1)
                self.thirdClassSubject.text = snapshot.value as! String
            }else{

                return

            }

        })

        //4
        ref.child("schedule").child("\(_group)").child("\(week)").child("\(dayOfWeek!)").child("4").observe(.childAdded, with: { (snapshot) in

            if snapshot.key == "Тип"{

                self.fourthClassSubjectType.fadeTransition(1)
                self.fourthClassSubjectType.text = snapshot.value as! String

            }else if snapshot.key == "Аудитория"{

                self.fourthClassClassroomNumber.fadeTransition(1)
                self.fourthClassClassroomNumber.text = snapshot.value as! String

            }else if snapshot.key == "Преподаватель"{

                self.fourthClassTeacherName.fadeTransition(1)
                self.fourthClassTeacherName.text = snapshot.value as! String

            }else if snapshot.key == "Название предмета"{

                self.fourthClassSubject.fadeTransition(1)
                self.fourthClassSubject.text = snapshot.value as! String
            }else{

                return

            }

        })

        //5
        ref.child("schedule").child("\(_group)").child("\(week)").child("\(dayOfWeek!)").child("5").observe(.childAdded, with: { (snapshot) in

            if snapshot.key == "Тип"{

                self.firstClassSubjectType.fadeTransition(1)
                self.fifthClassSubjectType.text = snapshot.value as! String

            }else if snapshot.key == "Аудитория"{

                self.fifthClassClassroomNumber.fadeTransition(1)
                self.fifthClassClassroomNumber.text = snapshot.value as! String

            }else if snapshot.key == "Преподаватель"{

                self.fifthClassTeacherName.fadeTransition(1)
                self.fifthClassTeacherName.text = snapshot.value as! String

            }else if snapshot.key == "Название предмета"{

                self.fifthClassSubject.fadeTransition(1)
                self.fifthClassSubject.text = snapshot.value as! String
            }else{

                return

            }

        })

        //6
        ref.child("schedule").child("\(_group)").child("\(week)").child("\(dayOfWeek!)").child("6").observe(.childAdded, with: { (snapshot) in

            if snapshot.key == "Тип"{

                self.sixthClassSubjectType.fadeTransition(1)
                self.sixthClassSubjectType.text = snapshot.value as! String

            }else if snapshot.key == "Аудитория"{

                self.sixthClassClassroomNumber.fadeTransition(1)
                self.sixthClassClassroomNumber.text = snapshot.value as! String

            }else if snapshot.key == "Преподаватель"{

                self.sixthClassTeacherName.fadeTransition(1)
                self.sixthClassTeacherName.text = snapshot.value as! String

            }else if snapshot.key == "Название предмета"{

                self.sixthClassSubjectType.fadeTransition(1)
                self.sixthClassSubject.text = snapshot.value as! String
            }else{

                return

            }

        })

        //СУББОТА
        //1
        ref.child("schedule").child("\(_group)").child("\(week)").child("\(dayOfWeek!)").child("1").observe(.childAdded, with: { (snapshot) in

            if snapshot.key == "Тип"{

                self.firstClassSubjectType.fadeTransition(1)
                self.firstClassSubjectType.text = snapshot.value as! String

            }else if snapshot.key == "Аудитория"{

                self.fifthClassClassroomNumber.fadeTransition(1)
                self.firstClassClassroomNumber.text = snapshot.value as! String

            }else if snapshot.key == "Преподаватель"{

                self.fifthClassTeacherName.fadeTransition(1)
                self.firstClassTeacherName.text = snapshot.value as! String

            }else if snapshot.key == "Название предмета"{

                self.firstClassSubject.fadeTransition(1)
                self.firstClassSubject.text = snapshot.value as! String
            }else{

                return

            }

        })

        //2
        ref.child("schedule").child("\(_group)").child("\(week)").child("\(dayOfWeek!)").child("2").observe(.childAdded, with: { (snapshot) in

            if snapshot.key == "Тип"{

                self.secondClassSubjectType.fadeTransition(1)
                self.secondClassSubjectType.text = snapshot.value as! String

            }else if snapshot.key == "Аудитория"{

                self.secondClassClassroomNumber.fadeTransition(1)
                self.secondClassClassroomNumber.text = snapshot.value as! String

            }else if snapshot.key == "Преподаватель"{

                self.secondClassTeacherName.fadeTransition(1)
                self.secondClassTeacherName.text = snapshot.value as! String

            }else if snapshot.key == "Название предмета"{

                self.secondClassSubject.fadeTransition(1)
                self.secondClassSubject.text = snapshot.value as! String
            }else{

                return

            }

        })

        //3
        ref.child("schedule").child("\(_group)").child("\(week)").child("\(dayOfWeek!)").child("3").observe(.childAdded, with: { (snapshot) in

            if snapshot.key == "Тип"{

                self.thirdClassSubjectType.fadeTransition(1)
                self.thirdClassSubjectType.text = snapshot.value as! String

            }else if snapshot.key == "Аудитория"{

                self.thirdClassClassroomNumber.fadeTransition(1)
                self.thirdClassClassroomNumber.text = snapshot.value as! String

            }else if snapshot.key == "Преподаватель"{

                self.thirdClassTeacherName.fadeTransition(1)
                self.thirdClassTeacherName.text = snapshot.value as! String

            }else if snapshot.key == "Название предмета"{

                self.thirdClassSubjectType.fadeTransition(1)
                self.thirdClassSubject.text = snapshot.value as! String
            }else{

                return

            }

        })

        //4
        ref.child("schedule").child("\(_group)").child("\(week)").child("\(dayOfWeek!)").child("4").observe(.childAdded, with: { (snapshot) in

            if snapshot.key == "Тип"{

                self.fourthClassSubjectType.fadeTransition(1)
                self.fourthClassSubjectType.text = snapshot.value as! String

            }else if snapshot.key == "Аудитория"{

                self.fourthClassClassroomNumber.fadeTransition(1)
                self.fourthClassClassroomNumber.text = snapshot.value as! String

            }else if snapshot.key == "Преподаватель"{

                self.fourthClassTeacherName.fadeTransition(1)
                self.fourthClassTeacherName.text = snapshot.value as! String

            }else if snapshot.key == "Название предмета"{

                self.fourthClassSubject.fadeTransition(1)
                self.fourthClassSubject.text = snapshot.value as! String
            }else{

                return

            }

        })

        //5
        ref.child("schedule").child("\(_group)").child("\(week)").child("\(dayOfWeek!)").child("5").observe(.childAdded, with: { (snapshot) in

            if snapshot.key == "Тип"{

                self.firstClassSubjectType.fadeTransition(1)
                self.fifthClassSubjectType.text = snapshot.value as! String

            }else if snapshot.key == "Аудитория"{

                self.fifthClassClassroomNumber.fadeTransition(1)
                self.fifthClassClassroomNumber.text = snapshot.value as! String

            }else if snapshot.key == "Преподаватель"{

                self.fifthClassTeacherName.fadeTransition(1)
                self.fifthClassTeacherName.text = snapshot.value as! String

            }else if snapshot.key == "Название предмета"{

                self.fifthClassSubject.fadeTransition(1)
                self.fifthClassSubject.text = snapshot.value as! String
            }else{

                return

            }

        })

        //6
        ref.child("schedule").child("\(_group)").child("\(week)").child("\(dayOfWeek!)").child("6").observe(.childAdded, with: { (snapshot) in

            if snapshot.key == "Тип"{

                self.sixthClassSubjectType.fadeTransition(1)
                self.sixthClassSubjectType.text = snapshot.value as! String

            }else if snapshot.key == "Аудитория"{

                self.sixthClassClassroomNumber.fadeTransition(1)
                self.sixthClassClassroomNumber.text = snapshot.value as! String

            }else if snapshot.key == "Преподаватель"{

                self.sixthClassTeacherName.fadeTransition(1)
                self.sixthClassTeacherName.text = snapshot.value as! String

            }else if snapshot.key == "Название предмета"{

                self.sixthClassSubjectType.fadeTransition(1)
                self.sixthClassSubject.text = snapshot.value as! String
            }else{

                return

            }

        })


        UIViewController.removeSpinner(spinner: sv)
    }

    //

//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//
//        return data.count
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//
//        firstClassSubjectType.text = data[row]
//        self.view.endEditing(true)
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//
//        return data[row]
//    }
//
//    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
//        let attributedString = NSAttributedString(string: data[row], attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
//        return attributedString
//    }


}

extension Schedule: UIPickerViewDelegate, UIPickerViewDataSource {


    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        return data.count
    }
    // fix me
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        return data[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        print(activeField)
        self.activeField?.text = data[row]
        self.view.endEditing(true)

    }

    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: data[row], attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        return attributedString
    }
}
