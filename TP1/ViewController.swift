//
//  ViewController.swift
//  TP1
//
//  Created by João Carlos Fernandes Neto on 17-11-01.
//  Copyright © 2017 João Carlos Fernandes Neto. All rights reserved.
//
//
//
//
//
//
//
//
//
//
//==========*\•/*=========\
import UIKit
//==========*\•/*=========\
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //==========*\•/*=========\\
    @IBOutlet weak var modalAddWords: UIView!
    @IBOutlet weak var addNewWord: UIButton!
    @IBOutlet weak var languageSelection: UISegmentedControl!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textFieldFrench: UITextField!
    @IBOutlet weak var textFieldEnglish: UITextField!
    @IBOutlet weak var tableListWords: UITableView!
    @IBOutlet weak var tableSearchResult: UITableView!
    //==========*\•/*=========\\
    @IBOutlet weak var translationResult: UILabel!
    //==========*\•/*=========\\
    var dictionaryReverse = [String:String]()
    var wordFrench: [String]!
    var wordEnglish: [String]!
    //==========*\•/*=========\\
    let saveUserDefaults = UserDefaultsManager()
    //==========*\•/*=========\\
    override func viewDidLoad() {
        super.viewDidLoad()
        manegerUser()
        dictionaryReverse = Dictionary(uniqueKeysWithValues: zip(wordFrench, wordEnglish))
    }
    //==========*\•/*=========\\
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dictionaryReverse.count
    }
    //==========*\•/*=========\\
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style:
            UITableViewCellStyle.default, reuseIdentifier: nil)
        let theKey = [String](dictionaryReverse.keys)[indexPath.row]
        let theValue = [String](dictionaryReverse.values)[indexPath.row]
        cell.textLabel?.text = "\(theKey) = \(theValue)"
        return cell
    }
    //==========*\•/*=========\\
    func manegerUser() {
        if UserDefaults.standard.object(forKey: "french") != nil {
            wordFrench = UserDefaults.standard.object(forKey: "french") as! [String]
            wordEnglish = UserDefaults.standard.object(forKey: "english") as! [String]
        } else {
            wordFrench = [String]()
            wordEnglish = [String]()
        }
    }
    //==========*\•/*=========\\
    @IBAction func saveNewWord(_ sender: UIButton) {
        wordFrench.append(textFieldFrench.text!)
        wordEnglish.append(textFieldEnglish.text!)
        UserDefaults.standard.set(wordFrench, forKey: "french")
        UserDefaults.standard.set(wordEnglish, forKey: "english")
    }
    //==========*\•/*=========\\
    @IBAction func actionModalWord(_ sender: UIButton) {
        if modalAddWords.alpha == 0 {
            modalAddWords.alpha = 1
        } else {
            modalAddWords.alpha = 0
        }
        
    }
    //==========*\•/*=========\\

}
//==========*\•/*=========\\
