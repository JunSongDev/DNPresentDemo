//
//  VedioModel.h
//  163Music
//
//  Created by zjs on 2018/10/10.
//  Copyright © 2018 zjs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VedioModel : NSObject

@property (nonatomic, copy) NSString * cate;
@property (nonatomic, copy) NSString * filename;
@property (nonatomic, copy) NSString * ID;
@property (nonatomic, copy) NSString * link;
@property (nonatomic, copy) NSString * path;
@property (nonatomic, copy) NSString * publishTime;
@property (nonatomic, copy) NSString * sort;
@property (nonatomic, copy) NSString * title;
@end

NS_ASSUME_NONNULL_END
