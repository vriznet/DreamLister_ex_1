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
    
    var itemToEdit: Item!
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
        
//        let store1 = Store(context: context)
//        store1.name = "Amazon"
//        let store2 = Store(context: context)
//        store2.name = "K Mart"
//        let store3 = Store(context: context)
//        store3.name = "Target"
//        let store4 = Store(context: context)
//        store4.name = "Fry"
//
//        let type1 = ItemType(context: context)
//        type1.type = "Computer"
//        let type2 = ItemType(context: context)
//        type2.type = "Car"
//        let type3 = ItemType(context: context)
//        type3.type = "Audio"
//        let type4 = ItemType(context: context)
//        type4.type = "Camera"
//
//        ad.saveContext()
        getStores()
        getTypes()
        if itemToEdit != nil{
            loadItemData()
        }
        
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
    func loadItemData(){
        if let item = itemToEdit{
            titleLbl.text = item.title
            priceLbl.text = "\(item.price)"
            detailsLbl.text = item.details
            
            if let store = item.toStore{
                var index = 0
                repeat{
                    let s = stores[index]
                    if s.name == store.name{
                        storePicker.selectRow(index, inComponent: 0, animated: true)
                        break
                    }
                    index += 1
                }while(index < stores.count)
            }
            
            if let type = item.toItemType{
                var index = 0
                repeat{
                    let t = types[index]
                    if t.type == type.type{
                        typePicker.selectRow(index, inComponent: 0, animated: true)
                        break
                    }
                    index += 1
                }while(index < types.count)
            }
        }
    }
    
    @IBAction func savePressed(_ sender: UIButton){
        var item: Item!
        if itemToEdit != nil{
            item = itemToEdit
        }else{
            item = Item(context: context)
        }
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
    @IBAction func deletePressed(_ sender: Any) {
        if itemToEdit != nil{
            context.delete(itemToEdit!)
            ad.saveContext()
        }
        navigationController?.popViewController(animated: true)
    }
}
