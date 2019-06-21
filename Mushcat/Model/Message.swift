//
//  Message.swift
//  Mushcat
//
//  Created by Hunter Xu on 6/20/19.
//  Copyright © 2019 Hunter Xu. All rights reserved.
//

import Foundation
import UIKit
import MessageKit

struct Member {
    let name: String
    let imageName: String
}

struct Message {
    let member: Member
    let text: String
    let messageId: String
}

extension Message: MessageType {
    var sender: Sender {
        return Sender(id: member.name, displayName: member.name)
    }
    
    var sentDate: Date {
        return Date()
    }
    
    var kind: MessageKind {
        return .text(text)
    }
}
