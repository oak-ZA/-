//
//  CustomCollectionViewCell.m
//  DetailInfo
//
//  Created by 张奥 on 2020/4/4.
//  Copyright © 2020 张奥. All rights reserved.
//

#import "CustomCollectionViewCell.h"

@interface CustomCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end
@implementation CustomCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setImageName:(NSString *)imageName{
    _imageName = imageName;
    self.imageView.image = [UIImage imageNamed:imageName];
}

@end
