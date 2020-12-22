//
//  CommentViewController.swift
//  Feedback Builder
//
//  Created by UTKARSH VARMA on 2020-11-23.
//

import UIKit


protocol commentDataDelegate{
    func thereIsComment(userComment:Comment)
}
class CommentViewController: UIViewController {
    var userComment = Comment()
    var commentDelegate:commentDataDelegate?
    //Force Unwrapping my delegate as this is the sender page and so im sure there will be some data sent from it so the object recieved wont be null
   
    @IBOutlet weak var commentData: UITextView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        commentData.delegate = self
        restoreState()
        
        // Do any additional setup after loading the view.
       
    }
    
    @IBAction func submitButton(_ sender: UIButton) {
        userComment.commentText = commentData.text
        
        commentDelegate?.thereIsComment(userComment: userComment)
        self.dismiss(animated: true, completion: nil)
    }
    func restoreState(){
        commentData.text = userComment.commentText
    }
    

}
extension CommentViewController:UITextViewDelegate{
    

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }


}

