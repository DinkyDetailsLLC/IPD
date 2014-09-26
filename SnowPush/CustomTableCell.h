//
//  CustomTableCell.h
//  SnowPush
//
//  Created by Dannis on 9/22/14.
//  Copyright (c) 2014 Dannis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *NameLab;
@property (weak, nonatomic) IBOutlet UIImageView *minusImage;
@property (weak, nonatomic) IBOutlet UIImageView *IceImage;
@property (weak, nonatomic) IBOutlet UIImageView *CatePortImage;
@property (weak, nonatomic) IBOutlet UIImageView *BoxImage;
@property (weak, nonatomic) IBOutlet UIButton *CircleButton;
@property (weak, nonatomic) IBOutlet UILabel *InvoiceLab;
@property (weak, nonatomic) IBOutlet UILabel *DateLab;
@property (weak, nonatomic) IBOutlet UILabel *PriseLab;
@property (weak, nonatomic) IBOutlet UILabel *InvoiceLab2;
@property (weak, nonatomic) IBOutlet UIImageView *OPTCircleImageView;

@end
