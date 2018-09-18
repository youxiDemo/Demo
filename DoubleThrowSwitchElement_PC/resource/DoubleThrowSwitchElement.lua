--单刀双掷开关
agent DoubleThrowSwitchAgent = inheritsFrom(LabBaseAgent:New())
DoubleThrowSwitchAgent:AddBaseLogic(CircuitElementBaseLogic:New())

--==========数据配置=============

DoubleThrowSwitchAgent.elementType = CircuitElementType.DoubleThrowSwitch

DoubleThrowSwitchAgent.CursorTable = {}
DoubleThrowSwitchAgent.CursorTable["Click"] = {}
DoubleThrowSwitchAgent.CursorTable["Click"]["Enter"] = CursorStyles.Click
DoubleThrowSwitchAgent.CursorTable["Click"]["Rotate"] = CursorStyles.Click
--接线柱路径配置
DoubleThrowSwitchAgent.wirePostModelPath_Left = {}
DoubleThrowSwitchAgent.wirePostModelPath_Left[1] = {}	--第一个是负极
DoubleThrowSwitchAgent.wirePostModelPath_Left[1]["leapPath"] = "GameObjScale/DanDaoShuangZhiKaiGuan/JieXianZhu_01"
DoubleThrowSwitchAgent.wirePostModelPath_Left[1]["knobPath"] = "GameObjScale/DanDaoShuangZhiKaiGuan/JieXianZhu_01/XuanNiu_01"
DoubleThrowSwitchAgent.wirePostModelPath_Left[1]["coilingPath"] = "GameObjScale/DanDaoShuangZhiKaiGuan/JieXianZhu_01/jiexian_01"

DoubleThrowSwitchAgent.wirePostModelPath_Left[2] = {}
DoubleThrowSwitchAgent.wirePostModelPath_Left[2]["leapPath"] = "GameObjScale/DanDaoShuangZhiKaiGuan/JieXianZhu_02"
DoubleThrowSwitchAgent.wirePostModelPath_Left[2]["knobPath"] = "GameObjScale/DanDaoShuangZhiKaiGuan/JieXianZhu_02/XuanNiu_02"
DoubleThrowSwitchAgent.wirePostModelPath_Left[2]["coilingPath"] = "GameObjScale/DanDaoShuangZhiKaiGuan/JieXianZhu_02/jiexian_02"

DoubleThrowSwitchAgent.wirePostModelPath_Right = {}
DoubleThrowSwitchAgent.wirePostModelPath_Right[2] = {}
DoubleThrowSwitchAgent.wirePostModelPath_Right[2]["leapPath"] = "GameObjScale/DanDaoShuangZhiKaiGuan/JieXianZhu_02"
DoubleThrowSwitchAgent.wirePostModelPath_Right[2]["knobPath"] = "GameObjScale/DanDaoShuangZhiKaiGuan/JieXianZhu_02/XuanNiu_02"
DoubleThrowSwitchAgent.wirePostModelPath_Right[2]["coilingPath"] = "GameObjScale/DanDaoShuangZhiKaiGuan/JieXianZhu_02/jiexian_02"

DoubleThrowSwitchAgent.wirePostModelPath_Right[1] = {}
DoubleThrowSwitchAgent.wirePostModelPath_Right[1]["leapPath"] = "GameObjScale/DanDaoShuangZhiKaiGuan/JieXianZhu_03"
DoubleThrowSwitchAgent.wirePostModelPath_Right[1]["knobPath"] = "GameObjScale/DanDaoShuangZhiKaiGuan/JieXianZhu_03/XuanNiu_03"
DoubleThrowSwitchAgent.wirePostModelPath_Right[1]["coilingPath"] = "GameObjScale/DanDaoShuangZhiKaiGuan/JieXianZhu_03/jiexian_03"

--===============
DoubleThrowSwitchAgent.absorbParentConfig = {}
DoubleThrowSwitchAgent.absorbParentConfig[1] = tostring(CircuitElementType.TableElement)

--子模型路径配置
DoubleThrowSwitchAgent.childrenModelPath = {}
DoubleThrowSwitchAgent.childrenModelPath["ZaDaoTou"] = "GameObjScale/DanDaoShuangZhiKaiGuan/ZhaDaoJinShuPian_wrapper/ZhaDaoJinShuPian/ZhaDaoShouBin"
DoubleThrowSwitchAgent.childrenModelPath["ZaDao"] = "GameObjScale/DanDaoShuangZhiKaiGuan/ZhaDaoJinShuPian_wrapper/ZhaDaoJinShuPian"
DoubleThrowSwitchAgent.childrenModelPath["DiZuo"] = "GameObjScale/DanDaoShuangZhiKaiGuan/DiZhuo"

-- DoubleThrowSwitchAgent.ignoreChildModePath={}
-- DoubleThrowSwitchAgent.ignoreChildModePath[1]="ZhaDaoJinShuPian"

--ui数据路径
DoubleThrowSwitchAgent.uidatapath = "DoubleThrowSwitchElement_PC/resource/DoubleThrowSwitchElement.json"

--数据序列化与反序列化配置表
DoubleThrowSwitchAgent.labDataConfig = {}

DoubleThrowSwitchAgent.labDataConfig["SwitchProcess"] = {}
DoubleThrowSwitchAgent.labDataConfig["SwitchProcess"]["DefaultValue"] = 0.75
DoubleThrowSwitchAgent.labDataConfig["SwitchProcess"]["Serialize"] = {typeName="number"}
DoubleThrowSwitchAgent.labDataConfig["SwitchProcess"]["Deserialize"] = {typeName="number",useFunction="DoubleThrowSwitchAgent.OnDeserializeOpenState"}

DoubleThrowSwitchAgent.labDataConfig["RotateAngle"] = {}
DoubleThrowSwitchAgent.labDataConfig["RotateAngle"]["DefaultValue"] = -30
DoubleThrowSwitchAgent.labDataConfig["RotateAngle"]["Serialize"] = {typeName="number"}
DoubleThrowSwitchAgent.labDataConfig["RotateAngle"]["Deserialize"] = {typeName="number",useFunction="DoubleThrowSwitchAgent.OnDeserializeAngle"}

--==========方法定义=============


--创建
function DoubleThrowSwitchAgent:Create(guid,paramsTable)
	local obj = DoubleThrowSwitchAgent:New()
	obj:LBABaseCreate(guid,paramsTable,obj)    
	obj:Init(paramsTable)
	return obj
end

--初始化
function DoubleThrowSwitchAgent:Init(paramsTable)
	--向引擎请求相应创建对象
	local engineElementId_Left = self:CreateCircuitComponent(EngineCircuitComponentType.SwitchSPST)
	local engineElementId_Right = self:CreateCircuitComponent(EngineCircuitComponentType.SwitchSPST)
	--和引擎能力 Component 绑定
	self.CiruiteElementSet:InitType("SwitchAction")
	self.CiruiteElementSet:AddComponent("SwitchAction",engineElementId_Left)
	self.CiruiteElementSet:AddComponent("SwitchAction",engineElementId_Right)
	 
	
	--初始化场景对象
	self:LBABaseInit(paramsTable)
	
	--初始化接线柱能力
	local enginePortTable1 = self.CiruiteElementSet:GetPortIDs(engineElementId_Left)
	local enginePortTable2 = self.CiruiteElementSet:GetPortIDs(engineElementId_Right)
	enginePortTable1 = CSArrayToLuaArray(enginePortTable1,2)
	
	enginePortTable2 = CSArrayToLuaArray(enginePortTable2,2)
	
	self:InitWirePost(engineElementId_Left,2,DoubleThrowSwitchAgent.wirePostModelPath_Left,enginePortTable1,paramsTable.ID)
	
	self:InitWirePost(engineElementId_Right,2,DoubleThrowSwitchAgent.wirePostModelPath_Right,enginePortTable2,paramsTable.ID)
	self.enginePortTable1 = enginePortTable1
	self.enginePortTable2 = enginePortTable2
	--元件功能绑定
	self.switchID1 = engineElementId_Left
	self.switchID2 = engineElementId_Right
	self:WirePostEngineLink(engineElementId_Left,enginePortTable1[2],engineElementId_Right,enginePortTable2[2])
	local entityId = self:GetEntityId()
	--子吸附
	self.VLabChildAdsorb:Bind(entityId)
	self.VLabChildAdsorb:Create(entityId,EmptyChildPath,tostring(DoubleThrowSwitchAgent.elementType))
	self.VLabChildAdsorb:InitViewAdsorb(EmptyChildPath,DoubleThrowSwitchAgent.absorbParentConfig, EmptyChildPath, AbsorbDetectMode.BOX_COLLIDER_DETECT)

	self.VLabChildAdsorb:SetBoxColliderDetectParams(EmptyChildPath,Vector3(0,0,0),Vector3(1,0.01,1) , 0.5, 0)
	self.VLabChildAdsorb:AddActionListener(EmptyChildPath,AbsorbActionType.AbsorbFinish, DoubleThrowSwitchAgent.OnAbsorbToParentCallback)
	self.VLabChildAdsorb:AddActionListener(EmptyChildPath,AbsorbActionType.CancelAbsorbFinish, DoubleThrowSwitchAgent.OnCancelAbsorbToParentCallback)

	--链接
	self.VLabLinkRelation:Bind(entityId)
	local linkId = self.VLabLinkRelation:CreateChildLink(EmptyChildPath)
	self:SaveAbsorbLinkData(AbsorbLinkPartType.Child, EmptyChildPath,linkId)
	
	--交互功能绑定

	self.VLabBestCameraAngle:Bind(entityId)
	self.AudioPathId = "GameObjScale"
	self.VLabEleSoundCtrl:Bind(entityId)
	self.VLabEleSoundCtrl:AddAudioSource(self.AudioPathId, EmptyChildPath)
	self.VLabEleSoundCtrl:LoadAudioClip(self.AudioPathId, "Audio/SwitchAudio","DoubleThrowSwitchElement")
	self.VLabEleSoundCtrl:SetAudioVolume(self.AudioPathId, 1)
	self.VLabEleSoundCtrl:AudioDefaultSetting(self.AudioPathId, false,false)

	-- 点击
	self.clickId = self:LBAInitInteractiveClick(EmptyChildPath,InputAxisType.Mastercontrol0,{})

	--双击
	self.doubleClickId = self:LBAInitInteractiveDoubleClick(EmptyChildPath,InputAxisType.Mastercontrol0,{})

	-- 进入离开
	self:LBAInitInteractivePointMove(EmptyChildPath,InteractivePointMoveEventType.All,InputAxisType.Mastercontrol0,{})

	-- 移动
	self.MoveId = self:LBAInitInteractiveMove(EmptyChildPath,InteractiveMoveEventType.All,InputAxisType.Mastercontrol0)

	self.rotaId = self:LBAInitInteractiveRotate(DoubleThrowSwitchAgent.childrenModelPath["ZaDaoTou"],InteractiveRotateEventType.Rotate,InputAxisType.Mastercontrol0,self.CursorTable["Click"])
	self:LBASetInteractiveRotateInfos(self.rotaId,{
		RotateType = RotateType.XZ,
		--IgnoreGameObjectPaths = DoubleThrowSwitchAgent.ignoreChildModePath ,
		RotateObject = DoubleThrowSwitchAgent.childrenModelPath["ZaDao"],
		Max = 30,
		Min = -150,
		OffsetAngle = Vector3(0, 180, 0)
	})

	--初始化数据的设置
	self.SwitchProcess = DoubleThrowSwitchAgent.labDataConfig["SwitchProcess"]["DefaultValue"]
	self.RotateAngle = DoubleThrowSwitchAgent.labDataConfig["RotateAngle"]["DefaultValue"]
	self.isClose = false 
	self:InitActionValues()
end
--吸附到父物体的回调
function DoubleThrowSwitchAgent:OnAbsorbToParentCallback(selfId, selfPath, otherId, otherPath)
	--print("吸附回调")
	local selfId = tonumber(selfId) or -1
	local selfPath = tostring(selfPath)
	local otherId = tonumber(otherId) or -1
	local otherPath = tostring(otherPath)
	if selfId < 0 or otherId < 0 then 
		print("Error absorbObject, empty id")
		return 
	end 
	local entityId = self:GetEntityId()
	if entityId ~= selfId then 
		return 
	end 
	local element = LabElementManager.GetElement(otherId)
	if element.elementType == CircuitElementType.TableElement then 
		local portTable = {{["id"] = self.switchID1,["port"] = self.enginePortTable1[2]},
							{["id"] = self.switchID1,["port"] = self.enginePortTable1[1]},
							{["id"] = self.switchID2,["port"] = self.enginePortTable2[1]}}
		if  element:LinkToTable(self,portTable) then 
			self:LBADeleteInteractive(InteractiveACType.Drag,self.moveId)
			self:LBADeleteInteractive(InteractiveACType.Click,self.clickId)
			self:LBADeleteInteractive(InteractiveACType.DoubleClick,self.doubleClickId)
		end
	end 
end 
--开关状态转换
function DoubleThrowSwitchAgent:SetOpenByProcess(process)
	if not process then 
		print("process is not exit")
		return 
	end 
	if process < 0.068 then 
		self.CiruiteElementSet:Set(tostring(self.switchID1), "isOpen", false)
		self.CiruiteElementSet:Set(tostring(self.switchID2), "isOpen", true)
		if self.isClose == false then 
			self.isClose = true
			self.VLabEleSoundCtrl:SetAudioPlayStatus(self.AudioPathId,0)
		end 
	elseif process >= 0.068 and process <=0.932 then 
		self.CiruiteElementSet:Set(tostring(self.switchID1), "isOpen", true)
		self.CiruiteElementSet:Set(tostring(self.switchID2), "isOpen", true)
		self.isClose = false 
	elseif process > 0.932 then 
		self.CiruiteElementSet:Set(tostring(self.switchID1), "isOpen", true)
		self.CiruiteElementSet:Set(tostring(self.switchID2), "isOpen", false)
		if self.isClose == false then 
			self.isClose = true
			self.VLabEleSoundCtrl:SetAudioPlayStatus(self.AudioPathId,0)
		end 
	end
	self.SwitchProcess = process
end


--铡刀旋转响应
function DoubleThrowSwitchAgent:OnEntireRotate(objPath, eventType, value, offset, process, isFocuse)

	if eventType == "Rotate" then
		if process then 
			self:SetOpenByProcess(process)
			
			self.RotateAngle = (1-process) * (-180)
		else 
			print("DoubleThrowSwitch:Rotate Error ,process is nil")
			return 
		end 
	end
end

--开关状态反序列化
function DoubleThrowSwitchAgent:OnDeserializeOpenState(value)
	if not value then 
		self.SetOpenByProcess(DoubleThrowSwitchAgent.labDataConfig["SwitchProcess"]["DefaultValue"])
		return 
	end 
	self:SetOpenByProcess(value)	
end 
--开关角度反序列化
function DoubleThrowSwitchAgent:OnDeserializeAngle(value)
	if not value then 
		self.Transform:SetChildEulerAngles(DoubleThrowSwitchAgent.childrenModelPath["ZaDao"],Vector3(0,-30,0),true)
		self.RotateAngle = -30
		return 
	end 
	self.RotateAngle = value
	self:LBASetInteractiveRotateInfos(self.rotaId,{[InteractiveRotateInfo.RotateOffset] = (value + 30)})
	self.Transform:SetChildEulerAngles(DoubleThrowSwitchAgent.childrenModelPath["ZaDao"],Vector3(0,value,0),true)
end 

function DoubleThrowSwitchAgent:OnEntireMove(objPath,eventType,WorldPos,offset,isFocus)
	self:CircuitInteractiveMove(objPath,eventType,WorldPos,offset,isFocus)
end

function DoubleThrowSwitchAgent:OnEntireMove(objPath, eventType,worldPos,offset,isFocus,linkMoveInfo)
	--self:NormalMove(objPath, eventType,worldPos,offset,isFocus,linkMoveInfo)
	self:CircuitInteractiveMove(objPath,eventType,WorldPos,offset,isFocus)
	if type(linkMoveInfo) ~= "string" and linkMoveInfo ~= nil then 
		return 
	end 
	if eventType == "BeginMove" then 
		self:BreakAbsorbLinkedParent(EmptyChildPath)
		self.VLabChildAdsorb:ChildDetecting(EmptyChildPath,true) 
	elseif eventType == "EndMove" then 
		self.VLabChildAdsorb:ChildDetecting(EmptyChildPath,false)
	end 
end 

function DoubleThrowSwitchAgent:OnEntireClick(objPath,eventType,screenPos,worldPos)
	self:CircuitInteractiveClick(objPath,eventType,screenPos,worldPos)
end

