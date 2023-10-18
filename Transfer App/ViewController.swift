//
//  ViewController.swift
//  Transfer App
//
//  Created by van on 17.10.2023.
//

import UIKit

class ViewController: UIViewController, UpdatableDataTransferProtocol {

    @IBAction func unwindToFirstScreen(_ segue: UIStoryboardSegue){}
    
    
    @IBOutlet weak var dataLabel: UILabel!
    
    var updatedData: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLabel(withText: updatedData)
    }
    
    private func updateLabel(withText text: String){
        dataLabel.text = text
    }
    
    @IBAction func editDataWithProperty(_ sender: UIButton){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // Такой подход позволяет скрыть за протоколом внутреннюю реализацию и кон- кретный тип контроллера, а значит при необходимости использовать любой вью контроллер, соответствующий протоколу UpdatingDataController.
        let editscreen = storyboard.instantiateViewController(withIdentifier: "secondViewController") as! UpdatingDataTransferProtocol
        
        editscreen.updatingData = dataLabel.text ?? ""
        
        self.navigationController?.pushViewController(editscreen as! UIViewController, animated: true)
    }


}

extension ViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toEditScreen":
            prepareEditScreen(segue: segue)
        default:
            break
        }
    }
    
    func prepareEditScreen(segue: UIStoryboardSegue){
        guard let destination = segue.destination as? UpdatingDataTransferProtocol else {
            return
        }
        destination.updatingData = dataLabel.text ?? ""
    }
}


// MARK: Delegate Method
extension ViewController: DataUpdateProtocol {
    func onUpdateData(data: String) {
        self.updatedData = data
        updateLabel(withText: data)
    }
    
    @IBAction func editDataWithDelegate(_ sender: UIButton) {
    // получаем вью контроллер
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let editScreen = storyboard.instantiateViewController(withIdentifier:
    "secondViewController") as! SecondViewController
        
        // передаем данные
        editScreen.updatingData = dataLabel.text ?? ""
        // устанавливаем текущий класс в качестве делегата
        editScreen.handleUpdatedDataDelegate = self
        // открываем следующий экран
        self.navigationController?.pushViewController(editScreen, animated: true)
        }

}

// MARK: Closure Method
extension ViewController {
    @IBAction func editDataWithСlosure(_ sender: UIButton) {
    // получаем вью контроллер
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let editScreen = storyboard.instantiateViewController(withIdentifier:
    "secondViewController") as! SecondViewController
    // передаем данные
    editScreen.updatingData = dataLabel.text ?? ""
    // передаем необходимое замыкание
    editScreen.completionHandler = { [unowned self] updatedValue in
    updatedData = updatedValue
    updateLabel(withText: updatedValue) }
    // открываем следующий экран
    self.navigationController?.pushViewController(editScreen, animated: true)
    }

}




