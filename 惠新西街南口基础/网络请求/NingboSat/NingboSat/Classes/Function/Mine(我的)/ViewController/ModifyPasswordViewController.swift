//
//  ModifyPasswordViewController.swift
//  NingboSat
//
//  Created by 田广 on 2016/12/18.
//  Copyright © 2016年 YSYC. All rights reserved.
//


class ModifyPasswordViewController: UIViewController,UITextFieldDelegate {
    var commitButton = UIButton.init()
    
    //初始化view
    func initView() {
        let leftArray:[String] =  ["旧密码","新密码","确认新密码"]
        let rightArray:[String] =  ["请输入旧密码","请输入新密码","请重新输入新密码"]

        for index in 0 ..< leftArray.count{
            let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 105, height: 50))
            
            let leftLabel = UILabel(frame: CGRect(x: 15, y: 0, width: 90, height: 50))
            leftLabel.font = UIFont.systemFont(ofSize: 15)
            leftLabel.textColor = UIColor.init(red: 80/255, green: 80/255, blue: 80/255, alpha: 1)
            leftLabel.text = leftArray[index]
            leftView.addSubview(leftLabel)
            
            let inputTextField = UITextField()
            inputTextField.frame = CGRect(x:0,y:10 + (50 * index),width:Int(UIScreen.main.bounds.width),height:50)
            inputTextField.placeholder = rightArray[index]
            inputTextField.setValue(UIFont.systemFont(ofSize: 15), forKeyPath: "_placeholderLabel.font")
            
            inputTextField.backgroundColor = UIColor.white
            inputTextField.leftView = leftView
            inputTextField.leftViewMode = UITextFieldViewMode.always
            inputTextField.tag = index + 10;
            inputTextField.delegate = self;
            inputTextField.isSecureTextEntry = true
            inputTextField.layer.borderColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
            inputTextField.layer.borderWidth = 0.5
            
            inputTextField.addTarget(self, action:#selector(ModifyPasswordViewController.inputPasswordChange), for: UIControlEvents.editingChanged)
            self.view.addSubview(inputTextField)
            
        }
        let alertText = NSMutableAttributedString.init(string: "＊密码支持8-20位字符，且首字母大写，密码由数字及大小写英文字母组成")
        alertText .addAttribute(NSForegroundColorAttributeName, value:UIColor.init(red: 254/255, green: 91/255, blue: 52/255, alpha: 1), range: NSMakeRange(0, 1))
        let alertLabel = UILabel(frame: CGRect(x: 15, y: 10 + leftArray.count * 50, width: Int(UIScreen.main.bounds.width) - 30, height: 50))
        alertLabel.numberOfLines = 2
        alertLabel.font = UIFont.systemFont(ofSize: 13)
        alertLabel.textColor = UIColor.init(red: 136/255, green: 136/255, blue: 136/255, alpha: 1)
        
        alertLabel.attributedText = alertText;
        self.view.addSubview(alertLabel);
        
        commitButton = UIButton.init(type: UIButtonType.custom)
        commitButton.frame = CGRect(x:35,y:100 + (50 * leftArray.count),width:Int(UIScreen.main.bounds.width) - 70,height:44)
        commitButton.backgroundColor = UIColor.init(red: 75/255, green: 196/255, blue: 251/255, alpha: 1)
        commitButton.setTitle("提交", for: UIControlState.normal)
        commitButton.addTarget(self, action:#selector(ModifyPasswordViewController.commitButtonClicked), for: UIControlEvents.touchUpInside)
        commitButton.layer.cornerRadius = 5
        commitButton.layer.masksToBounds = true
        commitButton.isEnabled = false
        commitButton.setBackgroundColor(UIColor.init(red: 75/255, green: 196/255, blue: 251/255, alpha: 1), for: UIControlState.normal)
        commitButton.setBackgroundColor(UIColor.init(red: 210/255, green: 210/255, blue: 210/255, alpha: 1), for: UIControlState.disabled)

        self.view.addSubview(commitButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.init(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1.0)
        self.navigationItem.title = "修改密码"
        self.initView()
    }
    
    //MARK: - 点击事件
    func commitButtonClicked(){
        let oldTextField = self.view.viewWithTag(10) as! UITextField
        let newTextField = self.view.viewWithTag(11) as! UITextField
        let newSureTextField = self.view.viewWithTag(12) as! UITextField
    
        if newTextField.text != newSureTextField.text {
            YSProgressHUD.showShock(on: self.view, message: "两次新密码输入不一致")
            return
        }
        
//        if StringRuleManage.PasswordIsValidated(vStr: newTextField.text!) == false{
//            YSProgressHUD.showShock(on: self.view, message: "请输入符合规则的新密码")
//            return
//        }
//        
        let urlDic = NSDictionary.init(dictionary: ["taxpayer_code":NSObject.getTaxNumber(), "old_password":oldTextField.text ?? "", "new_password":newTextField.text ?? ""])
        
        let urlBaseDic = ["jsonParam":urlDic.jsonParamString()]
        
        RequestBase.request(with: APIType.userUpdatePassword, param: urlBaseDic, complete: { (staus, object) in
            if staus == YSResponseStatus.success{
               let ysAlert = YSAlertView.alert(withMessage: "密码修改成功", sureButtonTitle:"确定")
                ysAlert.show()
                ysAlert.alertButtonClick({ (index ) in
                   _ = self.navigationController?.popViewController(animated: true)
                    
                })
            }

        }, showOn: self.view)
        
    }
    
    //MARK:输入数据监听
    func inputPasswordChange(){
        let oldTextField = self.view.viewWithTag(10) as! UITextField
        let newTextField = self.view.viewWithTag(11) as! UITextField
        let newSureTextField = self.view.viewWithTag(12) as! UITextField
        
       let oldLength =  oldTextField.text?.lengthOfBytes(using: String.Encoding.utf8)
        let newLength =  newTextField.text?.lengthOfBytes(using: String.Encoding.utf8)
        let newSureLength =  newSureTextField.text?.lengthOfBytes(using: String.Encoding.utf8)

        if oldLength! >= 8 && newLength! >= 8 && newSureLength! >= 8 {
            commitButton.isEnabled = true
        }else{
            commitButton.isEnabled = false

        }
        
    }
    //MARK: - UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
         //输入数据格式监听
        if string.lengthOfBytes(using: String.Encoding.utf8) == 0{
            return true
        }
        if (textField.text?.lengthOfBytes(using: String.Encoding.utf8))! > 19{
            return false
        }else{
            return true
        }
//        if textField.tag == 10 {
//            return true
//        }
//        if StringRuleManage.EnbleInputRuleValidated(vStr: string){
//            return true
//        }else{
//            return false
//        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
