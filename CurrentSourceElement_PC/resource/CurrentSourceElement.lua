--电源
agent PowerAgent = inheritsFrom(LabBaseAgent:New())
PowerAgent:AddBaseLogic(CircuitElementBaseLogic:New()) 

--==========数据配置=============
PowerAgent.elementType = CircuitElementType.Power
PowerAgent.maxCurrent = 10
PowerAgent.delayBrokenTime = 3

--接线柱路径配置
PowerAgent.wirePostModelPath3V = {}
PowerAgent.wirePostModelPath3V[1] = {}	--第一个是负极
PowerAgent.wirePostModelPath3V[1]["leapPath"] = "GameObjScale/DianChiZu/DianChiZu3V/JieXianZhu/JieXianZhu_Hei"
PowerAgent.wirePostModelPath3V[1]["knobPath"] = "GameObjScale/DianChiZu/DianChiZu3V/JieXianZhu/JieXianZhu_Hei/JieXianZhu_Hei_XuanNiu"
PowerAgent.wirePostModelPath3V[1]["coilingPath"] = "GameObjScale/DianChiZu/DianChiZu3V/JieXianZhu/JieXianZhu_Hei/xian002"

PowerAgent.wirePostModelPath3V[2] = {}
PowerAgent.wirePostModelPath3V[2]["leapPath"] = "GameObjScale/DianChiZu/DianChiZu3V/JieXianZhu/JieXianZhu_Hong"
PowerAgent.wirePostModelPath3V[2]["knobPath"] = "GameObjScale/DianChiZu/DianChiZu3V/JieXianZhu/JieXianZhu_Hong/JieXianZhu_Hong_XuanNiu"
PowerAgent.wirePostModelPath3V[2]["coilingPath"] = "GameObjScale/DianChiZu/DianChiZu3V/JieXianZhu/JieXianZhu_Hong/xian002"

PowerAgent.wirePostModelPath1_5V = {}
PowerAgent.wirePostModelPath1_5V[1] = {}	--第一个是负极
PowerAgent.wirePostModelPath1_5V[1]["leapPath"] = "GameObjScale/DianChiZu/DianChiZu1.5V/JieXianZhu/JieXianZhu_Hei"
PowerAgent.wirePostModelPath1_5V[1]["knobPath"] = "GameObjScale/DianChiZu/DianChiZu1.5V/JieXianZhu/JieXianZhu_Hei/JieXianZhu_Hei_XuanNiu"
PowerAgent.wirePostModelPath1_5V[1]["coilingPath"] = "GameObjScale/DianChiZu/DianChiZu1.5V/JieXianZhu/JieXianZhu_Hei/xian002"

PowerAgent.wirePostModelPath1_5V[2] = {}
PowerAgent.wirePostModelPath1_5V[2]["leapPath"] = "GameObjScale/DianChiZu/DianChiZu1.5V/JieXianZhu/JieXianZhu_Hong"
PowerAgent.wirePostModelPath1_5V[2]["knobPath"] = "GameObjScale/DianChiZu/DianChiZu1.5V/JieXianZhu/JieXianZhu_Hong/JieXianZhu_Hong_XuanNiu"
PowerAgent.wirePostModelPath1_5V[2]["coilingPath"] = "GameObjScale/DianChiZu/DianChiZu1.5V/JieXianZhu/JieXianZhu_Hong/xian002"

PowerAgent.wirePostModelPath6V = {}
PowerAgent.wirePostModelPath6V[1] = {}	--第一个是负极
PowerAgent.wirePostModelPath6V[1]["leapPath"] = "GameObjScale/DianChiZu/DianChiZu6V/JieXianZhu/JieXianZhu_Hei"
PowerAgent.wirePostModelPath6V[1]["knobPath"] = "GameObjScale/DianChiZu/DianChiZu6V/JieXianZhu/JieXianZhu_Hei/JieXianZhu_Hei_XuanNiu"
PowerAgent.wirePostModelPath6V[1]["coilingPath"] = "GameObjScale/DianChiZu/DianChiZu6V/JieXianZhu/JieXianZhu_Hei/xian002"

PowerAgent.wirePostModelPath6V[2] = {}
PowerAgent.wirePostModelPath6V[2]["leapPath"] = "GameObjScale/DianChiZu/DianChiZu6V/JieXianZhu/JieXianZhu_Hong"
PowerAgent.wirePostModelPath6V[2]["knobPath"] = "GameObjScale/DianChiZu/DianChiZu6V/JieXianZhu/JieXianZhu_Hong/JieXianZhu_Hong_XuanNiu"
PowerAgent.wirePostModelPath6V[2]["coilingPath"] = "GameObjScale/DianChiZu/DianChiZu6V/JieXianZhu/JieXianZhu_Hong/xian002"

PowerAgent.wirePostModelPath4_5V = {}
PowerAgent.wirePostModelPath4_5V[1] = {}	--第一个是负极
PowerAgent.wirePostModelPath4_5V[1]["leapPath"] = "GameObjScale/DianChiZu/DianChiZu4.5V/JieXianZhu/JieXianZhu_Hei"
PowerAgent.wirePostModelPath4_5V[1]["knobPath"] = "GameObjScale/DianChiZu/DianChiZu4.5V/JieXianZhu/JieXianZhu_Hei/JieXianZhu_Hei_XuanNiu"
PowerAgent.wirePostModelPath4_5V[1]["coilingPath"] = "GameObjScale/DianChiZu/DianChiZu4.5V/JieXianZhu/JieXianZhu_Hei/xian002"

PowerAgent.wirePostModelPath4_5V[2] = {}
PowerAgent.wirePostModelPath4_5V[2]["leapPath"] = "GameObjScale/DianChiZu/DianChiZu4.5V/JieXianZhu/JieXianZhu_Hong"
PowerAgent.wirePostModelPath4_5V[2]["knobPath"] = "GameObjScale/DianChiZu/DianChiZu4.5V/JieXianZhu/JieXianZhu_Hong/JieXianZhu_Hong_XuanNiu"
PowerAgent.wirePostModelPath4_5V[2]["coilingPath"] = "GameObjScale/DianChiZu/DianChiZu4.5V/JieXianZhu/JieXianZhu_Hong/xian002"

PowerAgent.absorbParentConfig = {}
PowerAgent.absorbParentConfig[1] = tostring(CircuitElementType.TableElement)

PowerAgent.wirePostModelPath= {}
PowerAgent.wirePostModelPath["4.5"] = PowerAgent.wirePostModelPath4_5V
PowerAgent.wirePostModelPath["1.5"] = PowerAgent.wirePostModelPath1_5V
PowerAgent.wirePostModelPath["3"] = PowerAgent.wirePostModelPath3V
PowerAgent.wirePostModelPath["6"] = PowerAgent.wirePostModelPath6V

PowerAgent.modelPath= {}
PowerAgent.modelPath["4.5"] = "GameObjScale/DianChiZu/DianChiZu4.5V"
PowerAgent.modelPath["1.5"] = "GameObjScale/DianChiZu/DianChiZu1.5V"
PowerAgent.modelPath["3"] = "GameObjScale/DianChiZu/DianChiZu3V"
PowerAgent.modelPath["6"] = "GameObjScale/DianChiZu/DianChiZu6V"

--ui数据路径
PowerAgent.uidatapath = "CurrentSourceElement_PC/resource/CurrentSourceElement.json"

--数据序列化、反序列化、UI交互涉及到的配置
PowerAgent.labDataConfig = {}

PowerAgent.labDataConfig["PowerAction.Voltage"] = {}
PowerAgent.labDataConfig["PowerAction.Voltage"]["DefaultValue"] = 3
PowerAgent.labDataConfig["PowerAction.Voltage"]["Serialize"] = {typeName="number"}		
PowerAgent.labDataConfig["PowerAction.Voltage"]["Deserialize"] = {typeName="number",useFunction = "PowerAgent.OnBatteryVoltageChange"}	
PowerAgent.labDataConfig["PowerAction.Voltage"]["GetByUI"] = {typeName="number"}		
PowerAgent.labDataConfig["PowerAction.Voltage"]["SetByUI"] = {typeName="number",useFunction = "PowerAgent.OnBatteryVoltageChange"}

PowerAgent.labDataConfig["PowerAction.InternalResistance"] = {}
PowerAgent.labDataConfig["PowerAction.InternalResistance"]["DefaultValue"] = 0.1
PowerAgent.labDataConfig["PowerAction.InternalResistance"]["Serialize"] = {typeName="number"}		
PowerAgent.labDataConfig["PowerAction.InternalResistance"]["Deserialize"] = {typeName="number"}
PowerAgent.labDataConfig["PowerAction.InternalResistance"]["GetByUI"] = {typeName="number"}		
PowerAgent.labDataConfig["PowerAction.InternalResistance"]["SetByUI"] = {typeName="number"}

--可吸附到的母体的类型配置  todo配置下
-- PowerAgent.absorbParentConfig = {}
-- PowerAgent.absorbParentConfig[1] = tostring(CircuitElementType.GanHuangGuanYanShiHeElement)

PowerAgent.compositeParentDataConfig = {}
PowerAgent.compositeParentDataConfig[1] = tostring(CircuitElementType.GanHuangGuanYanShiHeElement)


--==========方法定义=============
--创建
function PowerAgent:Create(guid,paramsTable)
	local obj = PowerAgent:New()
	obj:LBABaseCreate(guid,paramsTable,obj) 
	obj:Init(paramsTable)
	
	return obj
end

--初始化
function PowerAgent:Init(paramsTable)
	--向引擎请求相应创建对象
	local engineElementId = self:CreateCircuitComponent(EngineCircuitComponentType.Power)
	self.engineElementId = engineElementId
	--Util.LogError(string.format(" PowerAgent:Init self.engineElementId %s ", self.engineElementId) );

	--和引擎能力 Component 绑定
	self.PowerAction:BindComponent(engineElementId)
	
	--初始化场景对象
	self:LBABaseInit(paramsTable)
	
	--初始化接线柱能力
	self.oldLeapMotherId = paramsTable.ID
	
	--原件能力绑定
	local entityId = self:GetEntityId()
	self.VLabChangeModel:Bind(entityId)
	self.VLabBestCameraAngle:Bind(entityId)

	self.VLabChildAdsorb:Bind(entityId)
	self.VLabChildAdsorb:Create(entityId,EmptyChildPath,tostring(PowerAgent.elementType))
	self.VLabChildAdsorb:InitViewAdsorb(EmptyChildPath,PowerAgent.absorbParentConfig, EmptyChildPath, AbsorbDetectMode.BOX_COLLIDER_DETECT)
	self.VLabChildAdsorb:SetBoxColliderDetectParams(EmptyChildPath,Vector3(0,0.05,0),Vector3(1,0.01,1) , 0.5, 0)
	self.VLabChildAdsorb:AddActionListener(EmptyChildPath,AbsorbActionType.AbsorbFinish,PowerAgent.OnAbsorbToParentCallback)
	self.VLabChildAdsorb:AddActionListener(EmptyChildPath,AbsorbActionType.CancelAbsorbFinish,PowerAgent.OnCancelAbsorbToParentCallback)
	
	self.VLabLinkRelation:Bind(entityId)
	local linkId = self.VLabLinkRelation:CreateChildLink(EmptyChildPath)
	self:SaveAbsorbLinkData(AbsorbLinkPartType.Child,EmptyChildPath,linkId)
	
	--子部件高亮
	self.highLightId_1p5 = self.VLabHighlighter:CreateSubHighlighter(PowerAgent.modelPath["1.5"])
	self.highLightId_3 = self.VLabHighlighter:CreateSubHighlighter(PowerAgent.modelPath["3"])
	self.highLightId_4p5 = self.VLabHighlighter:CreateSubHighlighter(PowerAgent.modelPath["4.5"])
	self.highLightId_6 = self.VLabHighlighter:CreateSubHighlighter(PowerAgent.modelPath["6"])
	
	-- --子吸附
	-- self.VLabChildAdsorb:Bind(entityId)
	-- self.VLabChildAdsorb:Create(entityId,EmptyChildPath,tostring(PowerAgent.elementType))
	-- self.VLabChildAdsorb:InitViewAdsorb(EmptyChildPath,PowerAgent.absorbParentConfig, EmptyChildPath, AbsorbDetectMode.BOX_COLLIDER_DETECT)

	-- self.VLabChildAdsorb:SetBoxColliderDetectParams(EmptyChildPath,Vector3(0,0,0),Vector3(1,0.01,1) , 0.5, 0)
	-- self.VLabChildAdsorb:AddActionListener(EmptyChildPath,AbsorbActionType.AbsorbFinish, PowerAgent.OnAbsorbToParentCallback)
	-- self.VLabChildAdsorb:AddActionListener(EmptyChildPath,AbsorbActionType.CancelAbsorbFinish, PowerAgent.OnCancelAbsorbToParentCallback)


	--交互功能绑定
	self.moveId = self:LBAInitInteractiveMove(EmptyChildPath, InteractiveMoveEventType.All, InputAxisType.Mastercontrol0)
	self.clickId = self:LBAInitInteractiveClick(EmptyChildPath, InputAxisType.Mastercontrol0, {}, "")
	self.doubleClickId = self:LBAInitInteractiveDoubleClick(EmptyChildPath, InputAxisType.Mastercontrol0, "")
	self:LBAInitInteractivePointMove(EmptyChildPath, InteractivePointMoveEventType.All, {}, "")
	
	--数据变化响应绑定
	self.PowerAction:BindAttrChangeFunction(PowerAgent.ValueChangeCallback)
	self:BindPath(self.modelPath)
	
	--初始化数据的设置
	self:InitActionValues()
	self.PowerAction.isAC = false
	self.isPPostConnect = false--正极是否连接
	self.isNPostConnect = false--负极是否连接
end

--吸附到父物体的回调
function PowerAgent:OnAbsorbToParentCallback(selfId, selfPath, otherId, otherPath)
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
		local portTable = {{["id"] = self.engineElementId,["port"] = self.enginePortTable[1]},
								{["id"] = self.engineElementId,["port"] = self.enginePortTable[2]}}
		if  element:LinkToTable(self,portTable) then 
			self:LBADeleteInteractive(InteractiveACType.Drag,self.moveId)
			self:LBADeleteInteractive(InteractiveACType.Click,self.clickId)
			self:LBADeleteInteractive(InteractiveACType.DoubleClick,self.doubleClickId)
		end
	end 
end 

function PowerAgent:BindPath(path)
	return self.VLabChangeModel:BindPath(path)
end

function PowerAgent:ChanageModel(id)
	return self.VLabChangeModel:ChangeModle(id)
end

function PowerAgent:ValueChangeCallback(strJson)
	local isOK,params = ToolClass.GetLuaTableFroJson(strJson)
	if not isOK or not self then
		return
	end
	
	self:BaseProcessBreakDown()
	self:OnValueChangeCallback(params)
	
	for i,v in pairs(params) do
		local key = tostring(v["ParamKey"])
		
		if key == "Voltage" then
		
		elseif key == "Current" then
		
		end
	end
end


--损坏判断
function PowerAgent:IsBreakDown() 
	
	local current = self.PowerAction.Current
	local internalResistance = self.PowerAction.InternalResistance 
	local voltage = self.PowerAction.Voltage
	
	--理想电池不会烧毁
	if internalResistance == 0 then
		return false
	end

	--print(" PowerAgent:IsBreakDown current " .. current)

	--print(" PowerAgent:IsBreakDown current after roundOff " .. current)

	current = math.abs(Util.Round(current, 3))

	-- print(" PowerAgent:IsBreakDown current after abs " .. current)

	
	-- print(" PowerAgent:IsBreakDown internalResistance " .. internalResistance)
	-- print(" PowerAgent:IsBreakDown voltage " .. voltage)
	-- print(" PowerAgent:IsBreakDown voltage / internalResistance " .. voltage / internalResistance)

	local compareCurrent = math.abs(Util.Round(voltage / internalResistance, 3))

	--print(" PowerAgent:IsBreakDown compareCurrent " .. compareCurrent)

	--current = 30

	self.isBreak = (current >= compareCurrent)  
	local isBroken = self.isBreak
	if isBroken then
		self:SetBrokenReason(BrokenReason.HighCurrent)
	end
	
	return isBroken
end

--损坏功能覆写
function PowerAgent:BreakDown()
	if self.isBreak then
		self.PowerAction.IsOverload = true
		self:BaseBreakDown()
	end
end

--修复功能覆写
function PowerAgent:FixBreakDown()
	self.PowerAction.IsOverload = false
	self:BaseFixBreakDown()
end

--电压值改变的响应
function PowerAgent:OnBatteryVoltageChange(newValue)
	if not newValue then 
		print("PowerAgent:OnBatteryVoltageChange newValue is nil!")
		return 
	end
	
	self:ChanageModel(tostring(newValue))
	self:OnChangeLeapModel(tostring(newValue))
	self.PowerAction.Voltage = tonumber(newValue) or 0

	if self.isHighLight then
		self:SetHighlight(true,true)
	end
end

function PowerAgent:OnChangeLeapModel(newValue) 
	local postModelPath = self.wirePostModelPath[newValue]

	if (self.wirePostList == nil or table.getn(self.wirePostList) == 0) then 
		print("self.wirePostList == nil") 
		local enginePortTable = self.PowerAction.PortIDs
		enginePortTable = CSArrayToLuaArray(enginePortTable,2)
		self.enginePortTable = enginePortTable
		self:InitWirePost(self.engineElementId,2,postModelPath,enginePortTable, self.oldLeapMotherId) 	
	else 
		self:ChangeLeapModel(postModelPath)
		if self.isNPostConnect then
			self.Transform:ShowChild(self.wirePostModelPath[newValue][1]["leapPath"].."/effect_line_haveLink(Clone)")
		end
		if self.isPPostConnect then 
			self.Transform:ShowChild(self.wirePostModelPath[newValue][2]["leapPath"].."/effect_line_haveLink(Clone)")
		end
  end
end


function PowerAgent:OnPostLinked(post,node)
	if not post then
		return
	end	
	local currentVoltage = tostring(self.PowerAction.Voltage)
	local postModelPath = self.wirePostModelPath[currentVoltage]

	if post.modelPath == postModelPath[1]["leapPath"] then
		self.isNPostConnect = true
	elseif post.modelPath == postModelPath[2]["leapPath"] then
		self.isPPostConnect = true
	end
end

function PowerAgent:OnPostUnLinked(post,node)
	if not post then
		return
	end	
	local currentVoltage = tostring(self.PowerAction.Voltage)
	local postModelPath = self.wirePostModelPath[currentVoltage]

	if post.modelPath == postModelPath[1]["leapPath"] then
		self.isNPostConnect = false
	elseif post.modelPath == postModelPath[2]["leapPath"] then
		self.isPPostConnect = false
	end
end
-- function PowerAgent:SingleClickCallback(objpath,eventType,screenpos,worldps)
-- 	if eventType == "Click"	then
-- 	self.UIData:LeftClickInteractive(self.entityId,EmptyChildPath,screenpos,worldps)
-- 	end
-- end

function PowerAgent:MoveCallback(objpath, eventType, pos)
	print("MoveCallback")
	self:CircuitInteractiveMove(objPath, eventType,WorldPos)
	self.UIData:MoveInteractive(self.entityId, objpath, eventType, pos)
end

function PowerAgent:OnEntireMove(objPath,eventType,WorldPos,offset,isFocus)
	self:CircuitInteractiveMove(objPath,eventType,WorldPos,offset,isFocus)
	if type(linkMoveInfo) ~= "string" and linkMoveInfo ~= nil then 
		return 
	end 
	if eventType == "BeginMove" then 
		self:BreakAbsorbLinkedParent(EmptyChildPath)
		print("开始移动回调")
		self.VLabChildAdsorb:ChildDetecting(EmptyChildPath,true) 
	elseif eventType == "EndMove" then 
		self.VLabChildAdsorb:ChildDetecting(EmptyChildPath,false)
	end 
end

function PowerAgent:OnEntireClick(objPath,eventType,screenPos,worldPos)
	self:CircuitInteractiveClick(objPath,eventType,screenPos,worldPos)
end

--重写高亮的实现
function PowerAgent:SetHighlight(bHighlight,bForce)
	if self.isHighLight == bHighlight and not bForce then
		return
	end

	self.isHighLight = bHighlight
	
	self.VLabHighlighter:SubHighlight(self.highLightId_1p5,false,ElementHighLightColor)
	self.VLabHighlighter:SubHighlight(self.highLightId_3,false,ElementHighLightColor)
	self.VLabHighlighter:SubHighlight(self.highLightId_4p5,false,ElementHighLightColor)
	self.VLabHighlighter:SubHighlight(self.highLightId_6,false,ElementHighLightColor)
	
	if bHighlight then
		local voltage = self.PowerAction.Voltage
		if math.abs(voltage-1.5) <= 0.001 then
			self.VLabHighlighter:SubHighlight(self.highLightId_1p5,true,ElementHighLightColor)
		elseif math.abs(voltage-3) <= 0.001 then
			self.VLabHighlighter:SubHighlight(self.highLightId_3,true,ElementHighLightColor)
		elseif math.abs(voltage-4.5) <= 0.001 then
			self.VLabHighlighter:SubHighlight(self.highLightId_4p5,true,ElementHighLightColor)
		elseif math.abs(voltage-6) <= 0.001 then
			self.VLabHighlighter:SubHighlight(self.highLightId_6,true,ElementHighLightColor)	
		end
	end
end
--销毁处理
function PowerAgent:Quit()
	local msgBody = {}
	msgBody.elementType = PowerAgent.elementType
	msgBody.entityId = self:GetEntityId()
	msgBody.moveType =  InteractiveType.Delete
	MessageDispatcher.Send(MessageType.CommonStateChange,self,msgBody) 
 
	self:LBABaseDestroy()
end