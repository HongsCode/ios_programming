//
//  headerView.swift
//  customView
//
//  Created by HongYeol on 2020/10/28.
//

import UIKit

protocol headerDelegate {
    func onSwitch(isOn:Bool)
}
class headerView: UIView {

    @IBOutlet weak var switchView: UIButton!
    var delegate:headerDelegate?
    
    @IBAction func switchAction(_ sender: Any) {
        let btn = sender as! UIButton
        switchView.isSelected = !switchView.isSelected
        print("btn.isSelected = \(btn.isSelected), switchView.isSelected =\(switchView.isSelected)")
        delegate?.onSwitch(isOn: switchView.isSelected)
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        makeView()
    }
    
    override init(frame:CGRect){
        super.init(frame:frame)
        makeView()
    }
   
    public func makeView(){
       let l_bundle = Bundle(for:type(of:self))
       let l_nib = UINib(nibName: String(describing: type(of:self)), bundle: l_bundle)
       let view = l_nib.instantiate(withOwner:self, options:nil).first as? UIView
       view!.frame = bounds
       view!.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
       addSubview(view!)
   }


}
