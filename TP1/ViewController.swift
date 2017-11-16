//
//  ViewController.swift
//  TP1
//
//  Created by João Carlos Fernandes Neto on 17-11-01.
//  Copyright © 2017 João Carlos Fernandes Neto. All rights reserved.
//==========*\•/*=========\
import UIKit
//==========*\•/*=========\
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //==========*\•/*=========\\
    @IBOutlet weak var labelTranslationResult: UILabel!
    @IBOutlet weak var viewTranslationResult: UIView!
    @IBOutlet weak var labelFrench: UILabel!
    @IBOutlet weak var labelEnglish: UILabel!
    @IBOutlet weak var titleAddWord: UILabel!
    @IBOutlet weak var modalAddWords: UIView!
    @IBOutlet weak var addNewWord: UIButton!
    @IBOutlet weak var languageSelection: UISegmentedControl!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textFieldFrench: UITextField!
    @IBOutlet weak var textFieldEnglish: UITextField!
    @IBOutlet weak var tableListWords: UITableView!
    //==========*\•/*=========\\
    @IBOutlet weak var translationResult: UILabel!
    //==========*\•/*=========\\
    var dictionaryReverse = [String: String]()
    var wordFrench: [String]!
    var wordEnglish: [String]!
    var searchDisplay = String()
    //==========*\•/*=========\\
    var alertController = UIAlertController(title: "", message:
        "", preferredStyle: UIAlertControllerStyle.alert)
    //==========*\•/*=========\\
    override func viewDidLoad() {
        super.viewDidLoad()
        manegerUser()
        dictionaryReverse = Dictionary(uniqueKeysWithValues: zip(wordFrench, wordEnglish))
        tableListWords.reloadData()
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
        cell.textLabel?.text = "\(theKey)"
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let theValue = [String](dictionaryReverse.values)[indexPath.row]
        translationResult.text = "\(theValue)"
        if viewTranslationResult.isHidden == true {
            viewTranslationResult.isHidden = false
        } else {
            viewTranslationResult.isHidden = true
        }
    }
    //==========*\•/*=========\\
    //==========*\•/*=========\\
    @IBAction func saveNewWord(_ sender: UIButton) {
        wordFrench.append(textFieldFrench.text!)
        wordEnglish.append(textFieldEnglish.text!)
        UserDefaults.standard.set(wordFrench, forKey: "french")
        UserDefaults.standard.set(wordEnglish, forKey: "english")
        if languageSelection.selectedSegmentIndex==0 {
            dictionaryReverse = Dictionary(uniqueKeysWithValues: zip(wordFrench, wordEnglish))
            alertController = UIAlertController(title: "Succès!", message:
                "Les mots ont été sauvegardés", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        } else {
            dictionaryReverse = Dictionary(uniqueKeysWithValues: zip(wordEnglish, wordFrench))
            alertController = UIAlertController(title: "Success!", message:
                "Words have been saved", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        textFieldEnglish.text = ""
        textFieldFrench.text = ""
        tableListWords.reloadData()
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
    @IBAction func selectionLanguage(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex==0 {
            dictionaryReverse = Dictionary(uniqueKeysWithValues: zip(wordFrench, wordEnglish))
            textField.placeholder = "Chercher un mot"
            textFieldFrench.placeholder = "Mot français"
            textFieldEnglish.placeholder = "Mot anglais"
            titleAddWord.text = "Ajouter un mot"
            labelFrench.text = "Français"
            labelEnglish.text = "Anglais"
            labelTranslationResult.text = "Traduction"
            addNewWord.setTitle("Ajouter les mots", for: .normal)
        } else {
            dictionaryReverse = Dictionary(uniqueKeysWithValues: zip(wordEnglish, wordFrench))
            textField.placeholder = "Search for a word"
            textFieldFrench.placeholder = "French word"
            textFieldEnglish.placeholder = "English word"
            titleAddWord.text = "Add word"
            labelFrench.text = "French"
            labelEnglish.text = "English"
            labelTranslationResult.text = "Translation"
            addNewWord.setTitle("Add words", for: .normal)
        }
        tableListWords.reloadData()
    }
    //==========*\•/*=========\\
    @IBAction func clouseViewTranslationResult(_ sender: UIButton) {
        viewTranslationResult.isHidden = true
    }
    //==========*\•/*=========\\

}
//==========*\•/*=========\\
