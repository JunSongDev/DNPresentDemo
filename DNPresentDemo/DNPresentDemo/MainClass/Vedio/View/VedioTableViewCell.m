//
//  VedioTableViewCell.m
//  163Music
//
//  Created by zjs on 2018/10/10.
//  Copyright © 2018 zjs. All rights reserved.
//

#import "VedioTableViewCell.h"

@interface VedioTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UILabel *public_time;
@property (weak, nonatomic) IBOutlet UILabel *urlString;

@end

@implementation VedioTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(VedioModel *)model {
    _model = model;
    self.title_label.text = model.title;
    self.public_time.text = model.publishTime;
    self.urlString.text   = model.path;
}
@end
