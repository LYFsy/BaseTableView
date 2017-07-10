/*********************************************************/
/*                                                       *
 *                                                       *
 *   Follow your heart, but take your brain with you.    *
 *                                                       *
 *                                                       *
 *********************************************************/
//
//  BaseTableView.h
//  LYFBaseTableView
//
//  Created by 刘一峰 on 2017/7/10.
//  Copyright © 2017年 刘一峰. All rights reserved.
//


#import "BaseEmptyTableView.h"

typedef UITableViewCell *(^CallbackCell)(UITableViewCell * cell,NSIndexPath * indexPath);

typedef void(^CallbackDidSelectedCell)(UITableViewCell * cell,NSIndexPath * indexPath);

@interface BaseTableView : BaseEmptyTableView
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)CallbackCell callbackCell;
@property(nonatomic,strong)CallbackDidSelectedCell callbackDidSelectedCell;
@end

