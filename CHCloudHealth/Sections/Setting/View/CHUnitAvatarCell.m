//
//   /\_/\
//   \_ _/
//    / \ not
//    \_/
//
//  Created by __无邪_ on 4/5/16.
//  Copyright © 2016 fqah. All rights reserved.
//

#import "CHUnitAvatarCell.h"

@interface CHUnitAvatarCell ()

@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UIImageView *ivAvatar;


@end

@implementation CHUnitAvatarCell

- (void)setTitle:(NSString *)title avatar:(NSString *)avatar{
    [self.labTitle setText:title];
    [self.ivAvatar sd_setImageWithURL:avatar.url];
}

@end
