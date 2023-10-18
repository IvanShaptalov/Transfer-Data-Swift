//
//  SecondViewController.swift
//  Transfer App
//
//  Created by van on 17.10.2023.
//

import UIKit

class SecondViewController: UIViewController, UpdatingDataTransferProtocol {

    @IBOutlet weak var dataField: UITextField!
    
    var completionHandler: ((String) -> Void)?
    
    // MARK: Delegate method
    var handleUpdatedDataDelegate: DataUpdateProtocol?
    
    // Переход от Б к А
    // Передача данных с помощью делегата
    @IBAction func saveDataWithDelegate (_ sender: UIButton) {
    // получаем обновленные данные
        let updatedData = dataField.text ?? ""
        // вызываем метод делегата
        
        handleUpdatedDataDelegate?.onUpdateData(data: updatedData) // возвращаемся на предыдущий экран navigationController?.popViewController(animated: true)
    }
    
    //@IBAction
    //func handle
    
    public var updatingData: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViewData(withText: updatingData)
        
    }
    
    func updateViewData(withText text: String){
        dataField.text = text
    }
    
    @IBAction func saveDataWithProperty(_ sender: UIButton){
        self.navigationController?.viewControllers.forEach { viewController in
        (viewController as? UpdatableDataTransferProtocol)?.updatedData = dataField.text ?? ""
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SecondViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toFirstScreen":
            prepareFirstScreen(segue)
        default:
            break
        }
    }
    
    func prepareFirstScreen(_ segue: UIStoryboardSegue){
        guard let destination = segue.destination as? UpdatableDataTransferProtocol else {
            return
        }
        
        destination.updatedData = dataField.text ?? ""
    }
}


// MARK: closure method
extension SecondViewController{
    @IBAction func saveDataWithClosure(_ sender: UIButton) { // получаем обновленные данные
    let updatedData = dataField.text ?? ""
    // вызваем замыкание
    completionHandler?(updatedData)
    // возвращаемся на предыдущий экран
        navigationController?.popViewController(animated: true)
    }
}
