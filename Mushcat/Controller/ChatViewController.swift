//
//  ChatViewController.swift
//  Mushcat
//
//  Created by Hunter Xu on 6/20/19.
//  Copyright © 2019 Hunter Xu. All rights reserved.
//

import UIKit
import MessageKit
import Firebase

class ChatViewController: MessagesViewController {
    //TODO: Declare Constants Here
    var messages: [Message] = []
    var member: Member!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true;
        navigationItem.title = "Chat";
        
        
        var image: String = "";
        if (Auth.auth().currentUser?.displayName == "Cat") {
            image = "cat";
        } else {
            image = "mushroom1";
        }
        
        member = Member(name: Auth.auth().currentUser?.displayName ?? "user", imageName: image)
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self

        // Do any additional setup after loading the view.
        getDataFromBase()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func sendDataToBase(memberInstance: Member, textInstance: String, messageIdInstance: String) {
        let messageDB = Database.database().reference().child("Messages");
        let messageDictionary: [String : String] = ["MemberName" : memberInstance.name, "MemberImage" : memberInstance.imageName, "TextContent" : textInstance, "MessageID" : messageIdInstance];
        messageDB.childByAutoId().setValue(messageDictionary) {
            (error, reference) in
            if (error != nil) {
                print(error!.localizedDescription);
            } else {
                print("Message Upload Success!");
            }
        }
    }
    
    func getDataFromBase() {
        let messageDB = Database.database().reference().child("Messages");
        //And it remains active after viewDidLoad() is called
        messageDB.observe(.childAdded, with: { (snap) in
            let snapValue = snap.value as! Dictionary<String, String>;
            let putInText = snapValue["TextContent"]!;
            let putInUser = snapValue["MemberName"]!;
            let putInImage = snapValue["MemberImage"]!;
            let putInID = snapValue["MessageID"]!;
            let memberObj: Member = Member(name: putInUser, imageName: putInImage);
            let messageObj = Message(member: memberObj, text: putInText, messageId: putInID);
            self.messages.append(messageObj);
            self.messagesCollectionView.reloadData();
            self.messagesCollectionView.scrollToBottom(animated: true);
            print(self.messages[0]);
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    @IBAction func logOutButton(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true);
        } catch {
            ProgressHUD.showError("Error");
            print("Error: Problem signing out");
        }
    }
    
}

//MARK: - Implement the Protocols

extension ChatViewController: MessagesDataSource {
    
    func numberOfSections(
        in messagesCollectionView: MessagesCollectionView) -> Int {
        print("\n count is \(messages.count)");
        return messages.count
    }
    
    func currentSender() -> Sender {
        return Sender(id: member.name, displayName: member.name)
    }
    
    func messageForItem(
        at indexPath: IndexPath,
        in messagesCollectionView: MessagesCollectionView) -> MessageType {
        print("\n count is \(messages[indexPath.section])");
        return messages[indexPath.section]
    }
    
    func messageTopLabelHeight(
        for message: MessageType,
        at indexPath: IndexPath,
        in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        
        return 12
    }
    
    func messageTopLabelAttributedText(
        for message: MessageType,
        at indexPath: IndexPath) -> NSAttributedString? {
        
        return NSAttributedString(
            string: message.sender.displayName,
            attributes: [.font: UIFont.systemFont(ofSize: 12)])
    }
    
}

extension ChatViewController: MessagesLayoutDelegate {
    func heightForLocation(message: MessageType,
                           at indexPath: IndexPath,
                           with maxWidth: CGFloat,
                           in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        
        return 0
    }
}

extension ChatViewController: MessagesDisplayDelegate {
    func configureAvatarView(
        _ avatarView: AvatarView,
        for message: MessageType,
        at indexPath: IndexPath,
        in messagesCollectionView: MessagesCollectionView) {
        
        let message = messages[indexPath.section]
        let image = message.member.imageName
        
        /////////////
        
        avatarView.image = UIImage(named: image);
    }
}

extension ChatViewController: MessageInputBarDelegate {
    func messageInputBar(
        _ inputBar: MessageInputBar,
        didPressSendButtonWith text: String) {
        
        /////////Upload your info to Firebase here
        sendDataToBase(memberInstance: member, textInstance: text, messageIdInstance: UUID().uuidString)
        
        inputBar.inputTextView.text = ""
        messagesCollectionView.reloadData()
        messagesCollectionView.scrollToBottom(animated: true)
    }
}



