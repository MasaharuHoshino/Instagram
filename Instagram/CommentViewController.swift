//
//  CommentViewController.swift
//  Instagram
//
//  Created by Masaharu Hoshino (Work) on 2022/11/19.
//

import UIKit
import Firebase
import SVProgressHUD

class CommentViewController: UIViewController {
    
    @IBOutlet weak var commentTextField: UITextField!
    
    var userDisplayName = ""
    var id = ""
    var comments: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // 現在のユーザ表示名取得
        self.userDisplayName = (Auth.auth().currentUser?.displayName)!
        
        // DEBUG
        print ("現在のユーザ表示名です: \(userDisplayName)")
        print ("ホーム画面から受け取ったドキュメントのDです: \(id)")
        print ("ホーム画面から受け取った既存コメント群です: \(comments)")
    }
    
    // コメント送信ボタンをタップしたときに呼ばれるメソッド
    @IBAction func handleCommentSendingButton(_ sender: Any) {
        // 投稿データの保存場所を定義する
        let postRef = Firestore.firestore().collection(Const.PostPath).document(id)

        // 入力されたコメントを取得
        if self.commentTextField.text != nil {
            self.comments.append("\(self.userDisplayName): \(self.commentTextField.text!)")
            
            // DEBUG
            print ("新規コメント群です: \(comments)")
        }
        
        // HUDで投稿処理中の表示を開始
        SVProgressHUD.show()
        // Firestoreにコメントを投稿する
//        postRef.updateData([
//            "comments": self.comments
//        ], merge: true)
        postRef.updateData([
            "comments": self.comments
        ])
        { error in
            if error != nil {
                // コメントのアップロード失敗
//                print("DEBUG_PRINT: コメントのアップロード失敗　\(error.localizedDescription)")
                print("DEBUG_PRINT: コメントのアップロード失敗　\(error!)")
                SVProgressHUD.showError(withStatus: "コメントの投稿が失敗しました")
                return
            } else {
                // HUDで投稿完了を表示する
                SVProgressHUD.showSuccess(withStatus: "投稿しました")
                // 投稿処理が完了したのでホーム画面に戻る
                self.dismiss(animated: true, completion: nil)
            }
        }
        
//        let name = Auth.auth().currentUser?.displayName
//        let postDic = [
//            "comments": ["Test1", "Test2"],
//        ] as [String : Any]
//        postRef.setData(postDic)
//        // HUDで投稿完了を表示する
//        SVProgressHUD.showSuccess(withStatus: "投稿しました")
//        // 投稿処理が完了したのでホーム画面に戻る
//        self.dismiss(animated: true, completion: nil)
//        
//        let metadata = StorageMetadata()
//        metadata.contentType = "image/jpeg"
//        imageRef.putData(imageData!, metadata: metadata) { (metadata, error) in
//            if error != nil {
//                // 画像のアップロード失敗
//                print(error!)
//                SVProgressHUD.showError(withStatus: "画像のアップロードが失敗しました")
//                // 投稿処理をキャンセルし、先頭画面に戻る
//                self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
//                return
//            }
//            // FireStoreに投稿データを保存する
//            let name = Auth.auth().currentUser?.displayName
//            let postDic = [
//                "name": name!,
//                "caption": self.textField.text!,
//                "comments": ["Test1", "Test2"],
//                "date": FieldValue.serverTimestamp(),
//            ] as [String : Any]
//            postRef.setData(postDic)
//            // HUDで投稿完了を表示する
//            SVProgressHUD.showSuccess(withStatus: "投稿しました")
//            // 投稿処理が完了したので先頭画面に戻る
//            self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
//        }
    }
    
    // キャンセルボタンをタップしたときに呼ばれるメソッド
    @IBAction func handleCommentCancelButton(_ sender: Any) {
        // ホーム画面に戻る
        self.dismiss(animated: true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
