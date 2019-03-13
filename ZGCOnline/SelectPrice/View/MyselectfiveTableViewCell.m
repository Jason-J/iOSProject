//
//  MyselectfiveTableViewCell.m
//  ZGCOnline
//
//  Created by Maxwell on 14-7-12.
//  Copyright (c) 2014年 l@yout.com 雷鸥科技. All rights reserved.
//

#import "MyselectfiveTableViewCell.h"

@implementation MyselectfiveTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.myImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.myImageView];
        [self.myImageView release];
        
        self.myLabel1 = [[UILabel alloc] init];
        [self.contentView addSubview:self.myLabel1];
        [self.myLabel1 release];
        
        self.myLabel2 = [[UILabel alloc] init];
        [self.contentView addSubview:self.myLabel2];
        [self.myLabel2 release];
        
        self.myLabel3 = [[UILabel alloc] init];
        [self.contentView addSubview:self.myLabel3];
        [self.myLabel3 release];
        
        self.myLabel4 = [[UILabel alloc] init];
        [self.contentView addSubview:self.myLabel4];
        [self.myLabel4 release];
        
        self.myLabel5 = [[UILabel alloc]init];
        [self.contentView addSubview:self.myLabel5];
        [self.myLabel5 release];
//
//        self.myLabel6 = [[UILabel alloc]init];
//        [self.contentView addSubview:self.myLabel6];
//        [self.myLabel6 release];
//        
//        self.myLabel7 = [[UILabel alloc]init];
//        [self.contentView addSubview:self.myLabel7];
//        [self.myLabel7 release];
//        
//        self.myLabel8 = [[UILabel alloc]init];
//        [self.contentView addSubview:self.myLabel8];
//        [self.myLabel8 release];
//        
//        self.myLabel9 = [[UILabel alloc]init];
//        [self.contentView addSubview:self.myLabel9];
//        [self.myLabel9 release];
//        
        
        
        
        
        
        
    }
    return self;
}


-(void)dealloc
{
    [_myImageView release];
    [_myLabel1 release];
    [_myLabel2 release];
    [_myLabel3 release];
    [_myLabel4 release];
    [_myLabel5 release];
    [super dealloc];
}


-(void)layoutSubviews
{
    [super layoutSubviews];
//    self.myLabel1.frame = CGRectMake(0, 0, self.frame.size.width * 7 / 5, self.frame.size.height / 6);
//    self.myLabel1.backgroundColor =[UIColor blueColor];
//    self.myLabel1.text = @"sss";
    
//    self.myImageView.frame = CGRectMake(10, self.frame.size.height / 4, self.frame.size.width / 3, self.frame.size.height * 3 / 4.5);
//    self.myImageView.backgroundColor = [UIColor redColor];
    
//    self.myLabel2.frame = CGRectMake(self.frame.size.width * 7 / 10, 10, self.frame.size.width / 3, self.frame.size.height / 4);
//    self.myLabel2.backgroundColor = [UIColor brownColor];
    
//    self.myLabel3.frame = CGRectMake(self.frame.size.width / 3 + 10, self.frame.size.height / 4 + 10 , self.frame.size.width * 3 / 5 - 20, self.frame.size.height / 2);
//    self.myLabel3.backgroundColor = [UIColor redColor];
//    
    self.myLabel4.frame = CGRectMake(self.frame.size.width / 20 + 10, self.frame.size.height / 20 + self.frame.size.height / 10, self.frame.size.width * 3 / 5 + 20, self.frame.size.height / 3);
    self.myLabel4.backgroundColor = [UIColor greenColor];
      self.myLabel4.text = @"苹果Imac";
    
    self.myLabel5.frame = CGRectMake(self.frame.size.width / 20 + 10, self.frame.size.height / 5 + (self.frame.size.height / 5) * 2, self.frame.size.width * 3 / 5 + 20, self.frame.size.height / 4);
   self.myLabel5.backgroundColor = [UIColor purpleColor];
      self.myLabel5.text = @"4933";

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
