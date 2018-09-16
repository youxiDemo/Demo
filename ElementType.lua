--表示器件为空
ElementTypeNone = 0 
CircuitElementType =
{
	None = ElementTypeNone,
	Power = 1114112,
	Resistor = 1245184,
	Wire = 1572864,
	SwitchSPST = 1179648,
	VoltMeter = 1257472,
	Ammeter = 1253376,
	SlideResistor = 1269760,
	Lamp = 1249280,
	FoilElectriscope = 2097167,
	DaiJueYuanBingDeJinShuXiaoQiu = 1638410,
	XieMianElement = 3145748,
	DaiHuaLunDeZhangMuBan = 4195,
	DaiKeDuDeXieMian = 3145785 ,
	DaiXieMianDeFangXingTai = 3145762,
	GanYingQiDianJi = 1638411,
	KongXinJinShuQiu = 1638407,	
	TiejiataiDDCT = 2097412,
	DaXianQuan = 2162694,
	TiaoXingCiTie = 2097153,   --条形磁铁
	UMagnetElement = 4126,  --U性磁铁
	MetalStickElement = 4129, --金属棒
	JinShuDaoGui = 1310720, --金属导轨
	Galvanometer = 1290240,
	DianCiDaDianJiShiQi = 3145778,
	TieJiaTai = 2097408,
	TieJia = 3145792,
	StudentPower = 1273856,    --学生电源
	ZhiZhenShiWanYongBiao = 4108,
	ShiZhiJinGuanElement = 4257,
	ShiGuan = 4162,
	MianHua = 560,
	DaiDaoGuanXiangJiaoS = 7340033,
	BoLiPian = 4831,
	JiQiPing = 4342,
	ShuiCao = 7340037,
	JiuJingDeng = 4160,
	JiuJingDengMao = 4161,
	ShengJiangTai = 561,
	YaoChi = 4122,
	GuangKouPing = 4379,
	GuangKouPingGai = 4380,
	FengMingQiElement = 1638660,
	BaoXianSiZuoYongYanShiQi = 1314816,
	JingDianJi = 1638400,
	DianZuXiang = 1336064,     --电阻箱
	Silk = 2097164,            --丝绸手帕
	FaGuangErJiGuan = 1302529, --发光二极管
	ErJiGuan = 1302528,    --二极管
	DoubleThrowSwitch = 1183744,  --单刀双掷开关
	DianRongQi = 1638418,      --电容器
	JiaoErDingLvShiYanQi = 1335296, --焦耳定律实验器
	DianZuDingLvShiYanQi = 1335808,  --电阻定律实验器
	DianChuiFeng = 4168,           --电吹风
	DaiJueYuanBingDeJinShuBang = 1638401,       --带绝缘柄的金属棒
	JiaTingDianLuYanShiBanElement = 1638663,  --家庭电路演示板
	LuoXianGuanCiGanXianYanShiQi = 1638413,   --螺线管磁感线演示
	LuoXuanCeWeiQi = 3145730,   --螺旋测微器 
	JieNengDeng = 1638659,--节能灯
	LuoXianGuan = 1638403, --螺线管
	XiaoCiZhen = 2097156,  --小磁针
	ShiCiXiaoYingYinJiSheXianGuan = 2097168,  --阴极射线管(磁效应管)
	DetachableTransformer = 1507329,   --可拆变压器
	GlassStick = 2097161,      --玻璃棒
	ShuiGuoDianChi = 1336577,  --水果电池
	SimpleEM = 1306624, --简易电动机
	PingXingZhiDaoXianZuoYongYanShiQi = 4272,  --平行直导线作用演示器
	XiaoXianQuan = 2162695,--小线圈
	RubberStick = 2097160, --橡胶棒
	InsulatorBracket = 2097165, --绝缘支架
	HandGenerator = 1286144,--手摇发电机
	DianGanXianQuan = 4258,--电感线圈
	Fur = 2097163, --毛皮
	JueYuanGanTieJia = 2097409, --绝缘挂杆
	DianZiGanYingQuan = 1323008, -- 电子感应圈
    DianCiQuDongYanShiQi = 2097410,  -- 电磁驱动演示器
	ZhenXingDaoTi = 2097264,--枕型导体
	JinShuWangZhao = 1336576, 	--金属网罩
	WaiPiShunHuiDeDianZhu = 1638404, --外皮受损的电阻 
	ReMinDianZu = 1638409, --热敏电阻
	IncandescentLampNDElement = 1638662,  --白炽灯
	IncandescentLampElement = 1638661,   --带底座的白炽灯
	FlashlightElement = 4118,    --手电筒	
	QiSiLSYiSiElement = 1638658, --74LS14集成块
	XiaoGangQiu = 3145749,
	XieMianElement = 3145748,--斜面

	--**********************电学  10001 - 19999*************************
	HeiBiaoBi = 4110,-- 黑表笔
	HongBiaoBi = 4109,-- 红表笔
	ShiBoQi = 4277,  -- 示波器
	ShiBoQiTanTouXian = 10001 ,  --示波器线
	DaiDaoXianDeGanDianChi = 2097232,    -- 带导线的干电池
	QiuXingDaoTi = 1638412,    -- 球形导体
	IncandescentLampElement = 10003,    --带底座的白炽灯
	PingXingBanDianRongQi = 1638402,   --平行板电容器
	TiaoYaQi = 1336579,       --调压器
	GanHuangGuan = 2097297,       --干簧管
	GanHuangGuanYanShiHeElement = 2097298,
	UXingGuanYaQiangJi = 4291, --U型管压强计
	ShuZiWanYongBiao=1335552,--数字万用表
	TaiDeng = 1336320,        --台灯

	GuangMinDianZu = 1638405,--光敏电阻
	DanLu2ShuRuYuMenElement = 1638657 ,--与门
	DanLu2ShuRuHuoMenElement = 1638656,		--单路2输入或门
	ElectricFieldDisplay = 1302530,  --电场线演示器
	--**********************磁学  20001 - 29999*************************    TableElement = 2018915,  -- 桌子

    DaiCiTieDeTieJiaTaiElement = 1327104,  -- 带磁铁的铁架台


	WireFrame=1638414,      --线框
	CoilNail=2097157,       --带线圈的铁钉
	ShouYinJi = 2097216,    --收音机
	DianHeJianZuoYongLiYanShiQi = 1638406,	--电荷间作用力演示器
	ZhenKongZhaoDiZuo = 2097248, -- 真空罩底座
	ShouJi = 2097280, -- 手机
	LuoLunZiLiYanShiYi = 2097184, --洛伦兹力演示仪
	  

	--**********************力学  30001 - 39999*************************
    ChangShengElement = 4296,  -- 长绳
    XiangPiElement = 4149,  --橡皮
	ErLiPingHengDeShiYanZhuangZhi = 4164,  -- 二力平衡的实验装置
	ZhuoZi = 33333,--桌子

	WanQuDeGuiDao = 4301,  -- 弯曲的轨道

	YangShengQi=4304, --扬声器
	XiaoTieZhuoElement=4166,   --小铁桌
	ShenTongBei = 4292,     --深筒杯
	YouBiaoKaChi = 4200, -- 游标卡尺
	JinShuGuan = 4202, -- 金属管
	JiXieTingBiaoElement = 4141,--机械停表
	MiaoBiaoElement = 4144,--秒表
	TuoLiChaiLiShiYanQi = 4293,  --托里拆利实验器
	DianHuoHuaDaDianJiShiQi = 3145779, 		--电火花打点计时器
	MaoQianGuan = 4298,		--毛钱管
	XiXian = 3145780,    --细线
	ZhiJiaShangDeZhiZhang = 4436, 
	ShouPoZhenDongZhuangZhiElement = 3145766,   --受迫振动装置
	AlCubeBlock = 3145750,    --正方体铝块
	XiaoChe = 3145731,    --小车
	FaMaHe = 3145776,		--砝码盒
	FaMa = 3145769,		--砝码
	TuoPanTianPing = 4147, --托盘天平
	QiDianDaoGui = 4188 , --气垫导轨
	GuangDianJiShiQi = 4189 , -- 光电计时器
	HuaKuai = 4190 , -- 滑块
	XiaoShiKuai = 3145777, --小石块
	HongLaKuaiYunDongYanShiQi = 4303,	--红蜡块运动演示器
	ZhuSheQiBaiDongZhuangZhi = 4294,  --注射器摆动装置
	TanHuangCeLijiElement = 4157,             -- 弹簧测力计
	HaiMian = 4165,		--海绵
	GangGanPingHengZhuangZhi = 4174,   --杠杆平衡装置
	WoodBlock = 3145746,	--木块
	XieCao = 4173, -- 斜槽
	FaBoShuiCao = 4297, -- 发波水槽
	HuaLunElement = 4176,  --滑轮
	YiYuanYingBiElement = 3145747, -- 一元硬币
	JiaZhongFaMa = 4192, -- 加重砝码
	GouMaElement = 3145782, -- 钩码
	DanBai = 30002,		--单摆
	DaiXieMianDeFangXingTai = 3145762,	 --带刻度的方形台
	YinYueXiaoRen = 4306,	--音乐小人
	ZhiHe = 4305,	--纸盒 
	FaMaPan = 4155,  -- 砝码盘
	YinLiaoPing = 30001, --饮料瓶
	ShouPoZhenDongYanShiQi = 30003, --受迫振动演示器
	--**********************光学  40001 - 49999*************************
    PianZhenQi = 4326,  -- 偏振器

	ShuangFengGanSheShiYanYi = 4219,  -- 双缝干涉实验仪
    DaiBaiZhiDeMuBan = 40004,  -- 带白纸的木板
    ShuiLiuDaoGuangZhuangZhi = 4330,  --水流导光装置
	SanLengJing = 4317,  -- 三棱镜
	LaZhu = 5242883,    --蜡烛

	WeiXiaoXingBianYanShiQiElement = 4299,
	PingMianJing = 40001, --平面镜
	XinBan = 40002, --锌板
    BaiZhiElement = 4194308,  -- 白纸
    TuDingElement = 4182,  -- 图钉
	MuBan = 3145764,   --木板
    ChangFangXingBoLiZhuan = 4180,  -- 长方形玻璃砖
	JiGuangBi = 4179, --激光笔
	ZheDieZhiBan = 4213, --折叠纸板
	WanQuDeYouJiBoLiBang = 4324, --弯曲的有机玻璃棒
	ChangFangXingBoLiShuiCao = 5211,  -- 长方形玻璃水槽
	BanYuanXingBoLiZhuan = 4323,  --半圆形玻璃砖
	TouYingYiElement = 4322,     --投影仪
	PingXingXianJiGuangQi = 4318,   --平行线激光器
	ZiWaiXianDeng = 4329,  -- 紫外线灯
	LiangJiaoQiElement = 3145795,	--量角器
	JiGuangGuangXueYanShiYi = 4325, --激光光学演示仪
	TouYingPianElement = 4321,   --投影片
	DanMianAoTouJing = 4320, --单面凹透镜
	PingXingGuangYuan = 4316, --平行光源
	DanMianTuTouJing = 40003, --单面凹透镜
	ZuoBiaoZhi = 40005, --坐标纸
	TieSiQuan = 40006,
	QuanXiZhaoXiangYanShiQi = 40007, --全息照相演示器
	YeTiBiaoMianZhangLiYanShiQiYi = 4231,	--液体表面张力演示器1
	YeTiBiaoMianZhangLiYanShiQiEr = 40008,	--液体表面张力演示器2
	--**********************化学  50001 - 59999*************************    JieTiZhuangLvPian = 1357,  -- 阶梯状铝片

	ErYangHuaTanPingGai = 51048, 
	ErYangHuaTanPing = 51047,
    HuangTongPian = 51046,  -- 黄铜片
    TongPian = 51045,  -- 铜片

	YingZhiQuan = 51043,
	LiangTong10ml = 51042, --10ml量筒
	LiangTong50ml = 51041,	--50ml量筒
	YuanDiShaoPing = 51040,--圆底烧瓶
	JianZuiDaoGuan = 51039, -- 尖嘴导管
	BoLiWanGuan = 51038, 	-- 玻璃弯管
	ZhiDaoGuan = 51037, 	-- 直导管
	DaoGuan_120 = 51036, 	-- 120°DaoGuan
    DaoGuan_90 = 51035,  	-- 90°DaoGuan
    DaoGuan_60 = 51034,  	-- 60°DaoGuan

	ShaoBei_500ml = 51033,  -- 500ml烧杯
    ShaoBei_250ml = 51032,  -- 250ml烧杯
    ShaoBei_200ml = 51031,  -- 200ml烧杯
    ShaoBei_100ml = 51030,  -- 100ml烧杯
    ShaoBei_50ml = 51029,  -- 50ml烧杯
    ShaoBei_25ml = 51028,  -- 25ml烧杯

	BiaoMianMin = 680,  -- 表面皿
	GanGuoGai = 50028,  -- 坩埚盖
	PeiYangMin = 50030,		--培养皿
	PeiYangMinGai = 50031,	--培养皿盖

	RanShaoShiElement = 55004,  -- 燃烧匙
	HuaXueZhuSheQiElement = 55005,   --化学注射器
	JiuJingPenDengElement = 55006,   --酒精喷灯

	PingDiShaoPing = 50027,
    JuZhiShiGuan = 50026,  -- 具支试管
    ShiGuanShua = 50025,  -- 试管刷
	NiSanJiao = 50024, -- 泥三角
    GanGuo = 50023, --坩埚
    XiaoDao = 50022,  -- 小刀
    ZhiShuiJia = 50021,  -- 止水夹
    QiuXingFenYeLouDouGai = 50020,  -- 球型分液漏斗盖
    QiuXingFenYeLouDou = 50019,  -- 球型分液漏斗
    ChangJingLouDou = 50018,  -- 长颈漏斗
    LiXingFenYeLouDouGai = 50017,  -- 梨形分液漏斗盖
    LiXingFenYeLouDou = 50016,  -- 梨形分液漏斗
    ChengLiangZhi = 50015,  -- 称量纸

	BoLiShuiCao = 4211,
	ZhuiXingPing100ml = 4212,
	ZhuiXingPing250ml = 4214,
	ShiGuanTieJia=50001,--试管铁夹
	ShaoBei = 4116,
	JiaoTouDiGuan = 4201,	--胶头滴管
	ZhengFaMin = 573,	--蒸发皿
	ShengXiuDeTieDing = 50004, --生锈的铁钉
	NieZi = 50005,
	MuTiao = 548,

	ShiGuanJia = 553,
	GanGuoQian = 563,
	XiKouPing= 862,		--细口瓶
	BoLiSai = 50029,	--玻璃塞
	WangZhao= 567,
	ZhiCao = 50007,
	XiangPiSai = 545,
	BoLiDaoGuan = 4146,

	PHShiZhiHe = 50008,
	PHShiZhi = 50009,
	--GanGuoQian = 563,
	DiPing = 50010,
	DiPingDiGuan = 50011,
	BoLiBang = 50012,
	BianMianMin = 50013,
	XiangJiaoGuan = 50014,
	YingZhiBoLiGuan = 50038,
	LouDou = 4363,
	ShiMianWang = 4163,
	TieQuan = 50077,
	HuaXueTieJiaTai = 50078,
	MeiTiao = 50079,
	TieSi = 50089,
	ShiGuanShell = 50099,
	LvZhi = 55000,
	ShaZhi = 55001,
	TongSi = 55002,
	XinLi = 55003,
	
	ShaoBeiTest=4116, --宇翔测试专用
	--**********************组合  60001 - 69999*************************

	--**********************工具  70001 - 79999*************************

	--**********************声学  80001 - 89999*************************
    GangChiElement = 4209,  -- 钢尺

   
	DaiPingPangQiuDeTieJiaTai = 80001,--带乒乓球的铁架台
	YinChaElement = 4308,  --音叉 
	GangQin = 4311,  -- 钢琴
	ChangDiElement = 4312,  --长笛
	NaoZhongElement = 4307,   --闹钟
	HuaTongElement = 4309, --话筒
	PaoMoSuLiaoKuaiElement = 4313,  -- 泡沫塑料块
	BoLiBan = 4210, --玻璃板
	XuanZhuanXiaoRen=4315,  --蜂鸣器音调的变化  
	ZhuGan=4314,   --竹竿
	--**********************热学  90001 - 99999*************************
	XianWeiJing = 4224, -- 显微镜
    XiaoCiTi = 4344,  -- 小磁体
    GanWenTieYangTi = 4343,  -- 感温铁氧体
    RiGuangDengQiDongQi = 4234, --日光灯启动器
	ZaiWuBoLi = 4225, -- 载物玻璃
	GaiBoPian = 4226, -- 盖玻片
    TuFengLaDeBoLiPian = 4228,  -- 涂蜂蜡的玻璃片
    WenDuJiElement = 4220,  -- 温度计
	DianJiaReQi = 4233, -- 电加热器
	QianPan = 90001, --浅盘
	TuLaDeBoLiBan = 90002, --涂蜡的玻璃板
	TuFengLaDeYunMuPian = 90003,--涂蜂蜡的云母片
	SanJiaoJia = 90004, --三脚架
	ZhuSheQi = 4223, --注射器
	DaiKongDeYingZhiBan = 4221,	--带孔的硬纸板
	ShaoPingJia = 4331,  -- 烧瓶夹
	KongQiYaSuoYinHuoYi = 4338,  -- 空气压缩引火仪
	FengYiZhen = 4229,  --缝衣针
	QiTiShiYanDingLvYanShiQi = 4227,	--气体实验定律演示器
	ZuoGongGaiBianWuTiNeiNengZhuangZhi = 4341,	--做功改变物体内能装置
	FeiZaoYe = 4232,	--肥皂液
	DianLaoTie=4345,              --电烙铁
}