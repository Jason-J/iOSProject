//
//  CellForPatient.m
//  tangYiSheng
//
//  Created by Jason on 14-9-11.
//  Copyright (c) 2014年 Jason. All rights reserved.
//

#import "CellForPatient.h"

@implementation CellForPatient
-(void)dealloc
{
    [_myImageView release];
    [_nickNameLabel release];
    [_genderLabel release];
    [_birthdayLabel release];
    [_userTypeLabel release];
    [_diagnosedDateLabel release];
    [super dealloc];
    
    
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.myImageView = [[UIImageView alloc] init];
        self.nickNameLabel = [[UILabel alloc] init];
        self.genderLabel = [[UILabel alloc] init];
        self.birthdayLabel = [[UILabel alloc] init];
        self.userTypeLabel = [[UILabel alloc] init];
        self.diagnosedDateLabel = [[UILabel alloc] init];
        
        [self.contentView addSubview:self.myImageView];
        [self.contentView addSubview:self.nickNameLabel];
        [self.contentView addSubview:self.genderLabel];
        [self.contentView addSubview:self.birthdayLabel];
        [self.contentView addSubview:self.userTypeLabel];
        [self.contentView addSubview:self.diagnosedDateLabel];
        
//        测试颜色
        self.myImageView.backgroundColor = [UIColor redColor];
        self.nickNameLabel.backgroundColor = [UIColor greenColor];
        self.genderLabel.backgroundColor = [UIColor yellowColor];
        self.birthdayLabel.backgroundColor = [UIColor orangeColor];
        self.userTypeLabel.backgroundColor = [UIColor blueColor];
        self.diagnosedDateLabel.backgroundColor = [UIColor grayColor];
        
    }
    return self;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    布局
    self.myImageView.frame = CGRectMake(7, 8, 67, 67);
    self.myImageView.layer.cornerRadius = self.myImageView.frame.size.width / 2;
    CGRect rect = CGRectMake(85, 8, 100, 18);
    self.nickNameLabel.frame = rect;
    rect.origin.y = rect.origin.y + 15;
    self.genderLabel.frame = rect;
    rect.origin.y += 15;
    self.birthdayLabel.frame = rect;
    rect.origin.y += 15;
    self.userTypeLabel.frame = rect;
    rect.origin.x += 100;
    self.diagnosedDateLabel.frame = rect;
    
//    字体
    self.nickNameLabel.font = [UIFont systemFontOfSize:15];
    self.genderLabel.font = [UIFont systemFontOfSize:14];
    self.birthdayLabel.font = [UIFont systemFontOfSize:14];
    self.userTypeLabel.font = [UIFont systemFontOfSize:14];
    self.diagnosedDateLabel.font = [UIFont systemFontOfSize:14];
    
//    测试数据
    [self setCellData:nil];
    
}
//数据接口
#warning 数据接口
- (void)setCellData:(BaseModel *)cellData
{
    [super setCellData:cellData];
    self.nickNameLabel.text = @"李洪志";
    self.genderLabel.text = @"性别：男";
    self.birthdayLabel.text = @"1923年4月5日";
    self.userTypeLabel.text = @"用户类型：2型";
    self.diagnosedDateLabel.text = @"确诊年份:2004";
    
}
@end
