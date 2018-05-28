## Why do this?

&#8195;&#8195;距离毕业也有三、四个月的时间了，除了工作上的内容，改一改旧的Bug，做一做新的内容，还一直想着要做一个自己独立完成的应用。做即时通讯吧没有服务器，做音乐播放器吧没有数据库，所以就从最简单的只需要一个接口就能搞定的天气应用开始喽。这不，一款乱七八糟、随心所欲的Weather Application就出来了。感谢小伙伴Chaylau的协作完成。

## What's this？

&#8195;&#8195;“油条天气”是一款基于iOS平台的天气应用。YT能够做到显示基本的天气信息，包括城市、当前时间、实时天气情况、七天天气预报、当天24小时天气预报，也能够自由添加`国内`城市，只需要输入城市名即可。

![油条天气APP图标](https://user-gold-cdn.xitu.io/2017/12/13/1604eccb4b2a5693?w=200&h=198&f=png&s=43696)

## What're the features?

&#8195;&#8195;油条天气涵盖了城市信息、当前时间、七天天气预报、一天内24小时天气预报、广告位、当前详细天气信息、降水量信息、太阳和风速信息等基础天气咨询。还具有自定义添加国内城市、多城市切换的功能。一些界面截图如下：

![APP屏幕截图](https://user-gold-cdn.xitu.io/2017/12/13/1604eccc7cf7b1d6?w=1240&h=1653&f=jpeg&s=143389)

## What're the techniques?

- #### 接口

&#8195;&#8195;获取数据的接口选取的是 [和风天气](https://www.heweather.com/) ，针对普通开发者可以免费获取7天/24小时的天气预报，每天能够连接接口大约15000次。

&#8195;&#8195;只需要登录 [和风天气](https://www.heweather.com/) 官网注册成为开发者并稍作认证，即可获得Key在应用内使用，在官网控制台内还能查看每日接口被获取的详细数量。

&#8195;&#8195;当然，免费的接口只能获取一部分天气信息，并且只能支持国内的城市。想要体验更多的天气信息，则必须购买相应功能的接口。

![和风天气控制台](https://user-gold-cdn.xitu.io/2017/12/13/1604eccb361c416f?w=1240&h=852&f=png&s=133723)

- #### UI设计

&#8195;&#8195;程序员的工作是安安心心的写代码，总不能指望我们`Sketch`、`Axure`、`PhotoShop`样样精通吧......但是一款好看的App又很依赖于UI设计，所以我们偷懒将 [Yahoo天气](https://itunes.apple.com/cn/app/yahoo-tian-qi/id628677149?mt=8) 进行了解包，调取了他们的UI切图啥了的，界面设计也仿照了 [Yahoo天气](https://itunes.apple.com/cn/app/yahoo-tian-qi/id628677149?mt=8) 。所以UI方面的工作就比较轻松，直接拖入`Assets`包里就行。(不作商业用途，此处如被认定有侵权，将会立刻删除。)

&#8195;&#8195;解包操作：下载PP助手（之前可以直接在iTunes中下载`ipa`包的，但是苹果关闭了这项功能，所以用PP助手），在PP助手上将Yahoo天气的`ipa`包下载到`mac`中，再用 [Github：Cartool](https://github.com/steventroughtonsmith/cartool) 进行获取Assets操作，具体操作可参考 [提取assets.car中的图片 .car文件的解压](http://blog.csdn.net/Haikuotiankong11111/article/details/52549304) 。
![获取的UI文件](https://user-gold-cdn.xitu.io/2017/12/13/1604eccbee9fdf59?w=1240&h=831&f=png&s=445615)

- #### 框架搭建

&#8195;&#8195;开始动手码代码之前当然是对程序的框架进行搭建，参考公司其他项目的结构，选用了传统的MVC框架，思维导图如下：

![框架思维脑图.png](https://user-gold-cdn.xitu.io/2017/12/13/1604eccb42e2d8ae?w=1240&h=1331&f=png&s=279202)

&#8195;&#8195;APP复杂度并不高，也不依赖于`NavigationController`和`TabBarController`，所以一个主控制器负责所有界面的展示、子控制器的跳转。将视图的展示集合到`MainView`里，`MainController`只负责逻辑部分，减轻M-V-C中C的负担。

&#8195;&#8195;`MainView`从底往上依次是：`LeftSlideView`-`MaskView`-`ScrollView`-`TableView`-`CustomNavigationBar`。在处理`ScrollView`时花了不少功夫，既要保证当前城市所在`View`的滑动，还要保证其他`View`跟随滑动，在切换或搜索城市过后还要添加相应的索引。

- #### 项目中遇到的其他问题

>1. Q：Cell如何实现悬浮效果？  
      A：将Cell背景设为透明色，在每个Cell的上先加入一层BackgroudView，到左右两边同时设置约束，加圆角，改变BackgroundView的颜色和透明度，实现悬浮效果。

>2. Q：WeatherCode和CityCode都是以.txt形式给出，如何转为.plist？
      A：在网上看了许多博客和教程，最后决定用笨办法转换，由于不同txt中内容格式不固定，所以手动粘贴了txt文件中的项。今后准备将转换方法实现自动化，自动去判别txt中的内容，并根据内容完成转换，以下是转换方法的代码。

```
- (void)txtConvertToPlist
{
    // 将txt文件添加进项目文件中
    // 获取txt文件的路径
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"condition-code" ofType:@"txt"];
    // 将txt文件转换为String类型
    NSString *pathString = [[NSString alloc] initWithContentsOfFile:plistPath encoding:NSUTF8StringEncoding error:nil];

    // 将每行拆分，存入数组
    NSArray *bigArray = [pathString componentsSeparatedByString:@"\n"];

    NSMutableArray *resultArray = [NSMutableArray array];
    for (int i=1; i<ary.count-1; i++) {
        // 根据空格拆分每列，存入字典
        NSArray *smallAry = [bigArray[i] componentsSeparatedByString:@"    "];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:smallAry[0] forKey:@"cityCode"];
        [dic setObject:smallAry[1] forKey:@"cityEnglishName"];
        [dic setObject:smallAry[2] forKey:@"cityChineseName"];
        [resultArray addObject:dic];
    }
    
    // 存入.plist
    NSString *plistPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0];
    NSString *fileName = [plistPath stringByAppendingPathComponent:@"cityCode.plist"];
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm createFileAtPath:fileName contents:nil attributes:nil] ==YES) {
        [resultAry writeToFile:fileName atomically:YES];
        NSLog(@"文件写入完成");
    }
}
```

>3. Q：Cell如何实现悬浮效果？  
      A：一个Controller中置入多个页面的时候，必定要考虑清楚其之间的层级关系。LeftSlideView在最底层，能够让用户在点击菜单栏按钮时将ScrollView整体右移；MaskView是为了处理交互，在菜单栏未弹出时透明度为1，看上去ScrollView就像是最底层了，菜单栏弹出时，将透明度慢慢更改为0，使LeftSlideView浮现出来；ScrollView上的每个View表现形式都相同（今后会考虑View的复用问题），下图为层级关系示意图。
      
![层级关系.png](https://user-gold-cdn.xitu.io/2017/12/13/1604eccb33050777?w=1008&h=784&f=png&s=104637)

>4. Q：三方库的选择？  
      A：AFNetworking → 处理网络请求，数据获取；<br>
　　SDWebImage → 缓存天气图标；<br>
　　YYKit → 将JSON转为模型，比MJExtension更轻量级；<br>
　　MJRefresh → 下拉刷新的首选，在此基础上自定义了Gif方式的刷新。

## What will we do next?

&#8195;&#8195;“开发是小头、维护是大头”，来自一名弱鸡开发的真实感受，虽然在项目开始前已经搭建了大致的框架，想好了编码的思路，但是越往后越发现很多东西都可以用另一种更好的方法实现，所以作为一枚新手iOS，复盘+优化+重构的总结之路还有好长要走，接下来总结一下项目里能够优化、能够略去以及能够还存在Bug的地方吧~

`未完待续`

- 2018.1.24 发现clone很慢，删除了assets中很多无用的图片，重整了一下项目结构。
- 2018.3.10 适配iPhone X。
- 2018.3.15 添加定位功能，优化太阳和风速cell的动画效果。
