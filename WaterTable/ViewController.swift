//
//  ViewController.swift
//  WaterTable
//
//  Created by Fedor Lvov on 28/08/2019.
//  Copyright © 2019 Fedor Lvov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //Text fields
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var priceTF: UITextField!
    @IBOutlet weak var numberTF: UITextField!
    
    //Table
    @IBOutlet weak var tableView: UITableView!
    //var tableView = UITableView.init(frame: CGRect.zero, style: .plain)
    var arrayTable: [[String]] = [];
    var arrayTotal: [String] = [];

    //Cells
    let idCell = "Water Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "WaterTableViewCell", bundle: nil), forCellReuseIdentifier: idCell) //создание ячейки кастомного класса
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { //чтобы удобно убрать клаву
        self.view.endEditing(true)
    }

    @IBAction func pressAddButton() { //Добавление строки
        if let nameText = nameTF.text, let priceText = priceTF.text, let numberText = numberTF.text {
            
            let discount = Int.random(in: 1 ... 10)
            let discountText = String(discount) // рандомайзер для скидок
            
            if let price = Double(priceText), let number = Int(numberText) {
                let totalText = String(price * Double(number) * (100-Double(discount))/100)
                
                arrayTable.append([nameText, priceText, numberText, discountText, totalText]) //генерится ячейка таблицы
                
                nameTF.text = "" //Очищаем text fields
                priceTF.text = ""
                numberTF.text = ""
                
                updateTotal();
                self.tableView.reloadData() //обновление таблицы
                
                let title = "Запись добавлена";
                let message = ""
                
                let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet);
                
                let actionYes = UIAlertAction(title: "ОК", style: .default, handler: nil)
                
                alert.addAction(actionYes);
                
                present(alert, animated: true, completion: nil);
                
            } else {
                let title = "Неверно введённые данные";
                let message = ""
                
                let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet);
                
                let actionYes = UIAlertAction(title: "ОК", style: .default, handler: nil)
                
                alert.addAction(actionYes);
                
                present(alert, animated: true, completion: nil);
            }
        }
    }
    
    @IBAction func updateDiscountsButton() {
        let title = "Обновление скидок";
        let message = "Вы уверены?"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        
        let actionYes = UIAlertAction(title: "Да", style: .destructive, handler: {
            action in
            self.updateDiscounts() // обновление скидок
            self.tableView.reloadData() //обновление таблицы
        });
        
        let actionNo = UIAlertAction(title: "Нет", style: .cancel, handler: nil);
        
        alert.addAction(actionYes);
        alert.addAction(actionNo);
        
        present(alert, animated: true, completion: nil);
    }
    
    func updateDiscounts() {
        for i in 0..<arrayTable.count {
            let price = Double(arrayTable[i][1])
            let number = Double(arrayTable[i][2])
            arrayTable[i][3] = String(Int.random(in: 1 ... 10))
            let discount = Double(arrayTable[i][3])
            let total = price! * number! * (100-discount!)/100
            arrayTable[i][4] = String(total)
        }
        updateTotal();
    }
    
    func updateTotal() {
        arrayTotal = Array(repeating: "0", count: 2)
        var averageDiscount: Double = 0, totalPrice: Double = 0;
        for i in arrayTable {
            averageDiscount += Double(i[3])!
            totalPrice += Double(i[4])!
        }
        averageDiscount /= Double(arrayTable.count) //средняя скидка
        arrayTotal[0] = String(Int(averageDiscount.rounded())); //округляем
        arrayTotal[1] = String(format: "%.2f", totalPrice);
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 //количество секций: общая корзина и итог
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 { // функция возврата количества ячеек
            return arrayTotal.count - 1; // 1
        } else {
            return arrayTable.count + 1; // заголовок + массив
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: idCell) as! WaterTableViewCell // Использование существующей ячейки        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.nameLabel.text = "Название"
                cell.priceLable.text = "Цена"
                cell.numberLabel.text = "Количество"
                cell.discountLabel.text = "Скидка"
                cell.totalLabel.text = "Всего"
            } else {
                if let array: [String] = arrayTable[indexPath.row - 1] {
                    cell.nameLabel.text = array[0]
                    cell.priceLable.text = array[1]
                    cell.numberLabel.text = array[2]
                    cell.discountLabel.text = array[3]
                    cell.totalLabel.text = array[4]
                }
            }
        }
        
        if indexPath.section == 1 {
            //print(arrayTotal);
            cell.nameLabel.text = ""
            cell.priceLable.text = ""
            cell.numberLabel.text = ""
            cell.discountLabel.text = arrayTotal[0]
            cell.totalLabel.text = arrayTotal[1]
        }
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 60
        } else {
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Cредняя скидка и общая цена"
        } else {
            return "Корзина"
        }
    }
    
}
