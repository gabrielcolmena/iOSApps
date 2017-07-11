//
//  ItemDetailVC.swift
//  DreamLister
//
//  Created by Gabriel Colmenares on 7/8/17.
//  Copyright © 2017 Gabriel Colmenares. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var detailField: UITextField!
    @IBOutlet var thumbImage: UIImageView!
    
    var stores = [Store]()
    var itemToEdit: Item?
    var imagePicker: UIImagePickerController!
    var types = [ItemType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storePicker.delegate = self
        storePicker.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self

        if let topItem = self.navigationController?.navigationBar.topItem{
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        if itemToEdit != nil{
            loadItemData()
        }
        getStores()
        getItemTypes()
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0{
            let store = stores[row]
            return store.name
        }else{
            let type = types[row]
            return type.type
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
            return stores.count
        }
        else{
            return types.count
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        view.endEditing(true)
    }
    
    @IBAction func deletePressed(_ sender: UIBarButtonItem) {
        if itemToEdit != nil{
            context?.delete(itemToEdit!)
            ad?.saveContext()
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        
        var item: Item!
        
        let thumb = Image(context: context!)
        thumb.image = thumbImage.image
        
        
        if itemToEdit == nil{
            item = Item(context: context!)
        }else{
            item = itemToEdit!
        }
        
        item.toImage = thumb
        
        if let title = titleField.text{
            item.title = title
        }
        
        if let price = priceField.text{
            item.price = (price as NSString).doubleValue
        }
        
        if let details = detailField.text{
            item.details = details
        }
        
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]
        item.toItemType = types[storePicker.selectedRow(inComponent: 1)]

        ad?.saveContext()
        navigationController?.popViewController(animated: true)
        
    }
    
    func loadItemData(){
        
        if let item = itemToEdit{
            titleField.text = item.title
            priceField.text = "\(item.price)"
            detailField.text = item.details
            thumbImage.image = item.toImage?.image as? UIImage
            
            do{
                let storesFetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
                self.stores = try context!.fetch(storesFetchRequest)
                
                let typesFetchRequest: NSFetchRequest<ItemType> = ItemType.fetchRequest()
                self.types = try context!.fetch(typesFetchRequest)
                
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
                            storePicker.selectRow(index, inComponent: 1, animated: true)
                        }
                        index += 1
                    }while(index < types.count)
                }
            }catch{
                //error
            }
            
        }
        
    }
    
    @IBAction func addImage(_ sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            thumbImage.image = image
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func getStores(){
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        do{
            self.stores =  try context!.fetch(fetchRequest)
            
            if self.stores.count == 0{
                let store1 = Store(context: context!)
                store1.name = "Best buy"
                
                let store2 = Store(context: context!)
                store2.name = "Tesla Dealership"
                
                let store3 = Store(context: context!)
                store3.name = "Amazon"
                
                let store4 = Store(context: context!)
                store4.name = "Game Stop"
                
                let store5 = Store(context: context!)
                store5.name = "Ebuy"
                
                let store6 = Store(context: context!)
                store6.name = "Wallmart"
                ad?.saveContext()
                getStores()
            }else{
                self.storePicker.reloadAllComponents()
            }
        }catch{
            //Handle error
        }
    }
    
    
    func getItemTypes(){
        let fetchRequest: NSFetchRequest<ItemType> = ItemType.fetchRequest()
        do{
            self.types =  try context!.fetch(fetchRequest)
            
            if self.types.count == 0{
                let itemType1 = ItemType(context: context!)
                itemType1.type = "Travel"
                
                let itemType2 = ItemType(context: context!)
                itemType2.type = "Car"
                
                let itemType3 = ItemType(context: context!)
                itemType3.type = "Electronic"
                
                let itemType4 = ItemType(context: context!)
                itemType4.type = "Game"
                
                let itemType5 = ItemType(context: context!)
                itemType5.type = "Clothes"
                
                let itemType6 = ItemType(context: context!)
                itemType6.type = "Shoes"
                ad?.saveContext()
                
                getItemTypes()
            }else{
                self.storePicker.reloadAllComponents()
            }
        }catch{
            //Handle error
        }
    }
    

}
