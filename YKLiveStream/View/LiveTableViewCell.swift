//
//  LiveTableViewCell.swift
//  YKLiveStream
//
//  Created by walker on 2017/10/19.
//  Copyright © 2017年 walker. All rights reserved.
//

import UIKit

class LiveTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgPor: UIImageView!
    @IBOutlet weak var labelNick: UILabel!
    @IBOutlet weak var labelAddr: UILabel!
    @IBOutlet weak var labelViews: UILabel!
    @IBOutlet weak var imgBigPor: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
