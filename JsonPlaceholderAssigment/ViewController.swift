//
//  ViewController.swift
//  JsonPlaceholderAssigment
//
//  Created by Macintosh on 20/12/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var todosTableView: UITableView!
    
    var todos : [Todos] = []
    private let tableViewCellIdentifier = "TableViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
       fatchData()
        initializeTableView()
        registerXIBWithTableView()
    }
    func initializeTableView(){
        todosTableView.delegate = self
        todosTableView.dataSource = self
    }
    func registerXIBWithTableView(){
        let uiNib = UINib(nibName: tableViewCellIdentifier, bundle: nil)
        self.todosTableView.register(uiNib,forCellReuseIdentifier: tableViewCellIdentifier)
    }

func fatchData(){
    let todosUrlString = "https://jsonplaceholder.typicode.com/todos"
    let todosUrl = URL(string: todosUrlString)
    
    var todosUrlRequest = URLRequest(url: todosUrl!)
    todosUrlRequest.httpMethod = "GET"
    
    let todosUrlSession = URLSession(configuration:.default)

    var datatask = todosUrlSession.dataTask(with: todosUrlRequest){ todosData, todosUrlResponse, todosError in
        print(todosUrlResponse)
        print(todosData)
        print(todosError)
        
        let todosResponse = try! JSONSerialization.jsonObject(with: todosData!) as! [[String:Any]]
        print(todosResponse)
        
        for eachtodosResponse in todosResponse{
            let todoDictionary = eachtodosResponse as! [String:Any]
            let todosId = todoDictionary["id"] as! Int
            let todoUserId = todoDictionary["userId"] as! Int
            let todotitle = todoDictionary["title"] as! String
            let todocompleted = todoDictionary["completed"] as! Bool
            
            let  todoObject = Todos(userId: todoUserId,
                                    id: todosId,
                                    title: todotitle,
                                    completed: todocompleted)
            self.todos.append(todoObject)
            
        }
        DispatchQueue.main.async {
            self.todosTableView.reloadData()
        }
        
    }
    datatask.resume()
}

}
extension ViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todos.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = self.todosTableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath) as! TableViewCell
        tableViewCell.userIdLabel.text = String(todos[indexPath.row].userId)
        tableViewCell.idLabel.text = String(todos[indexPath.row].id)
        tableViewCell.titleLabel.text = todos[indexPath.row].title
        tableViewCell.ComletedLabel.text = String(todos[indexPath.row].completed)
        return tableViewCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
}
