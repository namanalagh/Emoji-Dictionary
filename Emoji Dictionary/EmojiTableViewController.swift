//
//  EmojiTableViewController.swift
//  Emoji Dictionary
//
//  Created by Naman Alagh on 11/01/23.
//

import UIKit

class EmojiTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    var emojis: [Emoji] = [
       Emoji(symbol: "π", name: "Grinning Face", description: "A typical smiley face.", usage: "happiness"),
       Emoji(symbol: "π", name: "Confused Face", description: "A confused, puzzled face.", usage: "unsure what to think; displeasure"),
       Emoji(symbol: "π", name: "Heart Eyes", description: "A smiley face with hearts for eyes.", usage: "love of something; attractive"),
       Emoji(symbol: "π§βπ»", name: "Developer", description: "A person working on a MacBook (probably using Xcode to write iOS apps in Swift).", usage: "apps, software, programming"),
       Emoji(symbol: "π’", name: "Turtle", description: "A cute turtle.", usage: "something slow"),
       Emoji(symbol: "π", name: "Elephant", description: "A gray elephant.", usage: "good memory"),
       Emoji(symbol: "π", name: "Spaghetti", description: "A plate of spaghetti.", usage: "spaghetti"),
       Emoji(symbol: "π²", name: "Die", description: "A single die.", usage: "taking a risk, chance; game"),
       Emoji(symbol: "βΊοΈ", name: "Tent", description: "A small tent.", usage: "camping"),
       Emoji(symbol: "π", name: "Stack of Books", description: "Three colored books stacked on each other.", usage: "homework, studying"),
       Emoji(symbol: "π", name: "Broken Heart", description: "A red, broken heart.", usage: "extreme sadness"), Emoji(symbol: "π€", name: "Snore", description: "Three blue \'z\'s.", usage: "tired, sleepiness"),
       Emoji(symbol: "π", name: "Checkered Flag", description: "A black-and-white checkered flag.", usage: "completion"),
       Emoji(symbol: "π", name: "Skull", description: "A human skull.", usage: "when you forgor"),
       Emoji(symbol: "πΏ", name: "Moai", description: "An ancient Moai statue.", usage: "bruh moments"),
       Emoji(symbol: "π­", name: "Crying Face", description: "A face with tears running down.", usage: "sad or funny"),
       Emoji(symbol: "π", name: "Thumbs Up", description: "A hand with a thumbs up", usage: "okay")
    ] 

    // MARK: - Table view data source

    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        let tableViewEditingMode = tableView.isEditing
        tableView.setEditing(!tableViewEditingMode, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojis.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiCell", for: indexPath) as! EmojiTableViewCell

        let emoji = emojis[indexPath.row]
        
//        var content = cell.defaultContentConfiguration()
//        content.text = "\(emoji.symbol) - \(emoji.name)"
//        content.secondaryText = emoji.description
//        cell.contentConfiguration = content
        cell.update(with: emoji)
        cell.showsReorderControl = true

        return cell
    }

//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let emoji = emojis[indexPath.row]
//        print("\(emoji.symbol) \(indexPath)")
//    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return.delete
    }
    
    @IBAction func unwindToEmojiTableView(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind", let sourceViewController = segue.source as? AddEditEmojiTableViewController, let emoji = sourceViewController.emoji else {
                return
        }
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            emojis[selectedIndexPath.row] = emoji
            tableView.reloadRows(at: [selectedIndexPath], with: .none)
        } else {
            let newIndexPath = IndexPath(row: emojis.count, section: 0)
            emojis.append(emoji)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    @IBSegueAction func addEditEmoji(_ coder: NSCoder, sender: Any?) -> AddEditEmojiTableViewController? {
        if let cell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell) {
            let emojiToEdit = emojis[indexPath.row]
            return AddEditEmojiTableViewController(coder: coder, emoji: emojiToEdit)
        } else {
            return AddEditEmojiTableViewController(coder: coder, emoji: nil)
        }
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            emojis.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedEmoji = emojis.remove(at: fromIndexPath.row)
        emojis.insert(movedEmoji, at: to.row)
    }

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
