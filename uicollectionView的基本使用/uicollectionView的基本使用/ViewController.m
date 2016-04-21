//
//  ViewController.m
//  uicollectionView的基本使用
//
//  Created by Pottsmo on 16/4/21.
//  Copyright © 2016年 Pottsmo. All rights reserved.
//
#import "MyFlowLayoout.h"
#import "PhotoCell.h"
#import "ViewController.h"
#define ScreenW  [UIScreen mainScreen].bounds.size.width
static NSString *const ID = @"cell";
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.view setBackgroundColor:[UIColor grayColor]];
    // 流水布局:用于控件创建
    UICollectionViewFlowLayout *layout =({
        layout = [[MyFlowLayoout alloc]init];
        layout.itemSize = CGSizeMake(180, 180);
        layout.minimumLineSpacing = 40;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        CGFloat margin = (ScreenW - layout.itemSize.width) * 0.5;
        layout.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin);
        
        layout;
    });
 
    
    
    // 添加collectionView,黑色
    UICollectionView *collectionV= ({
    collectionV =[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        collectionV.backgroundColor = [UIColor brownColor];
        collectionV.bounds = CGRectMake(0, 0, ScreenW, 200);
        collectionV.center = self.view.center;
        [self.view addSubview:collectionV];
        
        // 设置collectionView数据源
//        collectionV.delegate = self;
        collectionV.dataSource =self;
        collectionV.showsHorizontalScrollIndicator = NO;
        collectionV;
        });
    
    [collectionV registerNib:[UINib nibWithNibName:@"PhotoCell" bundle:nil] forCellWithReuseIdentifier:ID];
 
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    // 只要使用forIndexPath,必须要注册
    // 1.从缓存池取
    NSString *imageName = [NSString stringWithFormat:@"%zd",indexPath.row+1];
    UIImage *image = [UIImage imageNamed:imageName];
    cell.image = image;
    

    
    
    return cell;
}


@end
