//
//  ViewController.m
//  NSthread
//
//  Created by 大碗豆 on 17/5/11.
//  Copyright © 2017年 大碗豆. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,strong)NSThread *thr1;
@property (nonatomic,strong)NSThread *thr2;
@property (nonatomic,strong)NSThread *thr3;

@property (nonatomic,assign)NSInteger ticks;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [UIButton new];
    btn.frame = CGRectMake(100, 100, 100, 30);
    [btn setTitle:@"点我" forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    
    [self syThread];
    
    
}

- (void)btnAction:(id)btn{
    NSLog(@"~~~~~~按钮被点了");
    [self.thr1 start];
    [self.thr2 start];
    [self.thr3 start];
}

//线程安全（互斥锁）
- (void)syThread{
    
    self.ticks = 1000;
    self.thr1 = [[NSThread alloc] initWithTarget:self selector:@selector(sellTicks) object:nil];
    self.thr1.name = @"小芳";
    
    self.thr2 = [[NSThread alloc] initWithTarget:self selector:@selector(sellTicks) object:nil];
    self.thr2.name = @"小兰";
    
    self.thr3 = [[NSThread alloc] initWithTarget:self selector:@selector(sellTicks) object:nil];
    self.thr3.name = @"小菲";
}


- (void)sellTicks{
    
    while (self.ticks > 0) {
        
        @synchronized (self) {
            NSInteger currentTicks = self.ticks;
            
            if (currentTicks > 0) {
                NSLog(@"%@卖了一张票，还剩%ld张票",[NSThread currentThread].name,--self.ticks);
            }else{
                NSLog(@"票卖光了");
            }
        }
    }
    
}


//线程休眠
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [NSThread detachNewThreadSelector:@selector(threadRun1:) toTarget:self withObject:@"123"];
//}

- (void)threadRun1:(id)obj{
    NSLog(@"%@~~~%@",[NSThread currentThread],obj);
    
    [NSThread sleepForTimeInterval:4];
//    [NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:5]];
    
    //强制退出线程
//    [NSThread exit];
    
    NSLog(@"~~~~~~~~再次执行~~~~~");
    
    
    
}




- (void)creatThread{
    //创建线程的三种方式
    //    [self creatThread1];
    //    [self creatThread2];
    //    [self creatThread3];
}

- (void)creatThread3{
    [self performSelectorInBackground:@selector(threadRun:) withObject:@"creat3"];
}
- (void)creatThread2{
    [NSThread detachNewThreadSelector:@selector(threadRun:) toTarget:self withObject:@"123"];
}
- (void)creatThread1{
    //1、创建一个线程
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(threadRun:) object:@"123"];
    thread.name = @"name1";
    [thread start];
}
- (void)threadRun:(id)obj{
    
    NSLog(@"%@~~~%@",[NSThread currentThread],obj);
    
//    for (NSInteger i = 0; i < 1000000; i ++) {
//        NSLog(@">>>>>>>>>>%ld",i);
//    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
