//
//  PhotoCell.m
//  uicollectionView的基本使用
//
//  Created by Pottsmo on 16/4/21.
//  Copyright © 2016年 Pottsmo. All rights reserved.
//

#import "PhotoCell.h"
@interface PhotoCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;


@end
@implementation PhotoCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setImage:(UIImage *)image
{
    _image = image;
    self.imageV.image = image;
}
@end
