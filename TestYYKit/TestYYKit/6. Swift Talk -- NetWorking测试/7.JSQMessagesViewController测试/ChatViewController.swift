//
//  ChatViewController.swift
//  TestYYKit
//
//  Created by lieon on 16/8/8.
//  Copyright © 2016年 lieon. All rights reserved.
//
// swiftlint:disable colon
// swiftlint:disable trailing_whitespace

import UIKit
import JSQMessagesViewController

let bubbleEdgeInsets = UIEdgeInsets(top: 25, left: 5, bottom: 5, right: 10)
public let outbubbleImage = JSQMessagesBubbleImageFactory(bubbleImage: UIImage(named: "bubble_outgoing"), capInsets: bubbleEdgeInsets)

class ChatViewController: JSQMessagesViewController {

    private var messages: [JSQMessage] = []
    private var outgoingBubbleImageView:JSQMessagesBubbleImage!
    private var incomingBubbleImageView:JSQMessagesBubbleImage!
    private var outgoingAvatar: JSQMessagesAvatarImage!
    private var ingoingAvatar: JSQMessagesAvatarImage!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        
        senderId = "chat"
        senderDisplayName = "lieon"
        outgoingBubbleImageView = outbubbleImage.outgoingMessagesBubbleImageWithColor(UIColor.grayColor())
        incomingBubbleImageView = outbubbleImage.incomingMessagesBubbleImageWithColor(
            .whiteColor())
        let placeHolderImage = UIImage(named: "btn_avatar_default")
        outgoingAvatar = JSQMessagesAvatarImage(avatarImage: nil, highlightedImage: nil, placeholderImage: placeHolderImage)
        ingoingAvatar = JSQMessagesAvatarImage(avatarImage: nil, highlightedImage: nil, placeholderImage: placeHolderImage)
        
    }
}

extension ChatViewController {
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
        
    }
    
    override func didPressAccessoryButton(sender: UIButton!) {
        
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return messages.count
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        return nil
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        guard let cell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath) as? JSQMessagesCollectionViewCell else {
            return JSQMessagesCollectionViewCell()
        }
        let  message = messages[indexPath.item]
        if !message.isMediaMessage {
            if message.senderId == senderId {
                cell.textView.textColor = UIColor.whiteColor()

            } else {
                cell.textView!.textColor = UIColor.blackColor()
            }
        }
        return cell
    }
}
