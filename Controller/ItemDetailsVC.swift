//
//  ItemDetailsVC.swift
//  DreamLister_ex_1
//
//  Created by vriz on 2018. 6. 26..
//  Copyright © 2018년 vriz. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UINavigationControllerDelegate, NSFetchedResultsControllerDelegate {
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var titleLbl: CustomTextField!
    @IBOutlet weak var priceLbl: CustomTextField!
    @IBOutlet weak var detailsLbl: CustomTextField!
    
    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var typePicker: UIPickerView!
    
    var stores = [Store]()
    var types = [ItemType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let topItem = self.navigationController?.navigationBar.topItem{
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        storePicker.delegate = self
        typePicker.delegate = self
        storePicker.dataSource = self
        typePicker.dataSource = self
        
//        let store3 = Store(context: context)
//        store3.name = "Target"
//        let store4 = Store(context: context)
//        store4.name = "Fry"
//
//        let type3 = ItemType(context: context)
//        type3.type = "Audio"
//        let type4 = ItemType(context: context)
//        type4.type = "Camera"
//
//        ad.saveContext()
        
        getStores()
        getTypes()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == storePicker{
            return stores.count
        }else if pickerView == typePicker{
            return types.count
        }
        return 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == storePicker{
            return stores[row].name
        }else if pickerView == typePicker{
            return types[row].type
        }
        return ""
    }
    
    func getStores(){
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        do{
            self.stores = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
        }catch{
            let error = error as NSError
            print(error)
        }
    }
    func getTypes(){
        let fetchRequest: NSFetchRequest<ItemType> = ItemType.fetchRequest()
        do{
            self.types = try context.fetch(fetchRequest)
            self.typePicker.reloadAllComponents()
        }catch{
            let error = error as NSError
            print(error)
        }
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        let item = Item(context: context)
        if let title = titleLbl.text{
            item.title = title
        }
        if let price = priceLbl.text{
            item.price = (price as NSString).doubleValue
        }
        if let details = detailsLbl.text{
            item.details = details
        }
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]
        item.toItemType = types[typePicker.selectedRow(inComponent: 0)]
        ad.saveContext()
        navigationController?.popViewController(animated: true)
    }
}
