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
    //=*\/*=\\
    @IBOutlet weak var labelTranslationResult: UILabel!
    @IBOutlet weak var viewTranslationResult: UIView!
    @IBOutlet weak var labelFrench: UILabel!
    @IBOutlet weak var labelEnglish: UILabel!
    @IBOutlet weak var titleAddWord: UILabel!
    @IBOutlet weak var modalAddWords: UIView!
    @IBOutlet weak var addNewWord: UIButton!
    @IBOutlet weak var languageSelection: UISegmentedControl!
    @IBOutlet weak var textFieldFrench: UITextField!
    @IBOutlet weak var textFieldEnglish: UITextField!
    @IBOutlet weak var tableListWords: UITableView!
    @IBOutlet weak var translationResult: UILabel!
    //=*\ Variable avec le dictioner e les tables qui contiene les mots /*=\\
    var dictionaryReverse = [String: String]()
    var wordFrench: [String]!
    var wordEnglish: [String]!
    //=*\ Variable pour afficher les alerts /*=\\
    var alertController = UIAlertController(title: "", message:
        "", preferredStyle: UIAlertControllerStyle.alert)
    //=*\/*=\\
    override func viewDidLoad() {
        super.viewDidLoad()
        //---Inicialize la function manegerUser()
        manegerUser()
        //---Inicialize le tableau dictionaryReverse comme key wordFrench et valeur wordEnglish
        dictionaryReverse = Dictionary(uniqueKeysWithValues: zip(wordFrench, wordEnglish))
        //---Recherger le tableView tableListWords
        tableListWords.reloadData()
    }
    //=*\ Controller la contité des ligners dans le tablaView /*=\\
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Ajuter les cellules à le tableListWords égal à les numero d'element dans le dictionar dictionaryReverse
        return dictionaryReverse.count
    }
    //=*\/*=\\
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        let cell: UITableViewCell = UITableViewCell(style:
            UITableViewCellStyle.default, reuseIdentifier: nil)
        //
        let theKey = [String](dictionaryReverse.keys)[indexPath.row]
        //
        cell.textLabel?.text = "\(theKey)"
        //
        return cell
    }
    //=*\ Function qui controlle la sauvegarder de donner UserDefaults /*=\\
    func manegerUser() {
        //Veriffier si le donners sont sauvegardé
        if UserDefaults.standard.object(forKey: "french") != nil {
            wordFrench = UserDefaults.standard.object(forKey: "french") as! [String]
            wordEnglish = UserDefaults.standard.object(forKey: "english") as! [String]
        } else {
            //
            wordFrench = [String]()
            //
            wordEnglish = [String]()
        }
    }
    //=*\ Controlle les function de selection dans le tableauView /*=\\
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Créer un tableau avec touts les valeurs du dictionaryReverse et distribuer aux lignes
        let theValue = [String](dictionaryReverse.values)[indexPath.row]
        //Achiffer theValue dans translationResult
        translationResult.text = "\(theValue)"
        //Veriffier la affichage de la View viewTranslationResult
        if viewTranslationResult.isHidden == true {
            //Fair apparetre la UIView viewTranslationResult
            viewTranslationResult.isHidden = false
        } else {
            //Fair deapparetre la UIView viewTranslationResult
            viewTranslationResult.isHidden = true
        }
    }
    //=*\ Function qui sauvegarder les neuvoux mots /*=\\
    @IBAction func saveNewWord(_ sender: UIButton) {
        //Ajuter le mot qu'ulitisateur a tappe sur le champ textFieldFrench dans le tableau wordFrench
        wordFrench.append(textFieldFrench.text!)
        //Ajuter le mot qu'ulitisateur a tappe sur le champ textFieldEnglish dans le tableau wordEnglish
        wordEnglish.append(textFieldEnglish.text!)
        //Sauvegarder le tableau wordFrench dans le UserDefaults "french"
        UserDefaults.standard.set(wordFrench, forKey: "french")
        //Sauvegarder le tableau wordEnglish dans le UserDefaults "english"
        UserDefaults.standard.set(wordEnglish, forKey: "english")
        //Conttroler la selection de langue du languageSelection
        if languageSelection.selectedSegmentIndex==0 {
            //---Inicialize le tableau dictionaryReverse comme key wordFrench et valeur wordEnglish
            dictionaryReverse = Dictionary(uniqueKeysWithValues: zip(wordFrench, wordEnglish))
            //Cahnger la variable alertController pour qu'elle acchife un message de success en français
            alertController = UIAlertController(title: "Succès!", message:
                "Les mots ont été sauvegardés", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        } else {
            //---Inicialize le tableau dictionaryReverse comme key wordEnglish et valeur wordFrench
            dictionaryReverse = Dictionary(uniqueKeysWithValues: zip(wordEnglish, wordFrench))
            //Cahnger la variable alertController pour qu'elle acchife un message de success en anglais
            alertController = UIAlertController(title: "Success!", message:
                "Words have been saved", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        //Vider le champ textFieldFrench
        textFieldEnglish.text = ""
        //Vider le champ textFieldFrench
        textFieldFrench.text = ""
        //---Recherger le tableView tableListWords
        tableListWords.reloadData()
    }
    //=*\ Function que fair apparetre le modalAddWords /*=\\
    @IBAction func actionModalWord(_ sender: UIButton) {
        if modalAddWords.alpha == 0 {
            //Chager la protrieté alpha du modalAddWords
            modalAddWords.alpha = 1
        } else {
            //Chager la protrieté alpha du modalAddWords
            modalAddWords.alpha = 0
        }
    }
    //=*\ Funcition qui controlle le UISegmentedControl selectionLanguage /*=\\
    @IBAction func selectionLanguage(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex==0 {
            //---Inicialize le tableau dictionaryReverse comme key wordEnglish et valeur wordEnglish
            dictionaryReverse = Dictionary(uniqueKeysWithValues: zip(wordFrench, wordEnglish))
            //Changer le placeholder du textFieldFrench
            textFieldFrench.placeholder = "Mot français"
            //Changer le placeholder du textFieldEnglish
            textFieldEnglish.placeholder = "Mot anglais"
            //Changer le texte du titleAddWord
            titleAddWord.text = "Ajouter un mot"
            //Changer le texte du labelFrench
            labelFrench.text = "Français"
            //Changer le texte du labelEnglish
            labelEnglish.text = "Anglais"
            //Changer le texte du labelTranslationResult
            labelTranslationResult.text = "Traduction"
            //Changer le titre du addNewWord
            addNewWord.setTitle("Ajouter les mots", for: .normal)
        } else {
            //---Inicialize le tableau dictionaryReverse comme key wordEnglish et valeur wordFrench
            dictionaryReverse = Dictionary(uniqueKeysWithValues: zip(wordEnglish, wordFrench))
            //Changer le placeholder du textFieldFrench
            textFieldFrench.placeholder = "French word"
            //Changer le placeholder du textFieldEnglish
            textFieldEnglish.placeholder = "English word"
            //Changer le texte du titleAddWord
            titleAddWord.text = "Add word"
            //Changer le texte du labelFrench
            labelFrench.text = "French"
            //Changer le texte du labelEnglish
            labelEnglish.text = "English"
            //Changer le texte du labelTranslationResult
            labelTranslationResult.text = "Translation"
            //Changer le titre du addNewWord
            addNewWord.setTitle("Add words", for: .normal)
        }
        //---Recherger le tableView tableListWords
        tableListWords.reloadData()
    }
    //=*\ Function pour "fermer" la UIView viewTranslationResult /*=\\
    @IBAction func clouseViewTranslationResult(_ sender: UIButton) {
        //Fair apparetre la UIView viewTranslationResult
        viewTranslationResult.isHidden = true
    }

}
//=*\/*=\\
