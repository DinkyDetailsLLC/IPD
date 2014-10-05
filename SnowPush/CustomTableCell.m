//
//  CustomTableCell.m
//  SnowPush
//
//  Created by Dannis on 9/22/14.
//  Copyright (c) 2014 Dannis. All rights reserved.
//

#import "CustomTableCell.h"

@implementation CustomTableCell
@synthesize NameLab,IceImage,minusImage,CatePortImage,BoxImage;
@synthesize CircleButton,InvoiceLab,DateLab,PriseLab,InvoiceLab2;
@synthesize OPTCircleImageView;
@synthesize Celcias,farenhite,Weekday,wetherImage;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
