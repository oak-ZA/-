//
//  HeadView.m
//  ProtocolTest
//
//  Created by 张奥 on 2020/4/4.
//  Copyright © 2020 张奥. All rights reserved.
//

#import "HeadView.h"
#import "CustomCollectionViewCell.h"
#import "Masonry.h"
#define SCREEN_Width [UIScreen mainScreen].bounds.size.width
#define SCREEN_Height [UIScreen mainScreen].bounds.size.height
@interface HeadView()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSMutableArray *dataSources;
@end
@implementation HeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        [self createCollectionView];
    }
    return self;
}

-(void)createCollectionView{
    self.dataSources = [NSMutableArray array];
    [self.dataSources addObject:@"bird"];
    [self.dataSources addObject:@"city"];
    [self.dataSources addObject:@"bird"];
    UICollectionViewFlowLayout *flowLay = [[UICollectionViewFlowLayout alloc] init];
    flowLay.itemSize = CGSizeMake(SCREEN_Width, 250.f);
    flowLay.minimumLineSpacing = 0;
    flowLay.minimumInteritemSpacing = 0;
    flowLay.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLay.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 250) collectionViewLayout:flowLay];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.pagingEnabled = YES;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView = collectionView;
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CustomCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"cell"];
    [self addSubview:collectionView];
    
    if (@available(iOS 11.0, *)) {
        collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
    } else {
        
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"timevalue_off"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"timevalue_on"] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    button.adjustsImageWhenHighlighted = NO;
    [self addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.mas_trailing).with.offset(-8);
        make.bottom.equalTo(self.mas_bottom).with.offset(-10);
    }];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSources.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.imageName = self.dataSources[indexPath.row];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了collectionView%ld=====%ld",indexPath.section,indexPath.row);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(scrollView.contentOffset.x > self.frame.size.width * (self.dataSources.count - 1)){
        self.collectionView.contentOffset = CGPointMake(scrollView.contentOffset.x - self.frame.size.width * (self.dataSources.count - 1) , 0);
    }else if (scrollView.contentOffset.x <0){
        self.collectionView.contentOffset = CGPointMake(scrollView.contentOffset.x + self.frame.size.width * (self.dataSources.count - 1) , 0);
    }
}

-(void)clickButton:(UIButton *)button{
    button.selected = !button.selected;
}

@end
