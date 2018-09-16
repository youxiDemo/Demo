--小灯泡
agent LampAgent = inheritsFrom(LabBaseAgent:New())
LampAgent:AddBaseLogic(CircuitElementBaseLogic:New())

--==========数据配置=============
LampAgent.elementType = CircuitElementType.Lamp
LampAgent.brokenRatio = 2	--损坏判断系数
LampAgent.delayBrokenTime = 0.3


--接线柱路径配置
LampAgent.wirePostModelPath = {}
LampAgent.wirePostModelPath[1] = {}	--第一个是负极
LampAgent.wirePostModelPath[1]["leapPath"] = "GameObjScale/XiaoDengPaoHeDengPaoDiZuo/JieXianZhu_Hei"
LampAgent.wirePostModelPath[1]["knobPath"] = "GameObjScale/XiaoDengPaoHeDengPaoDiZuo/JieXianZhu_Hei/JieXianZhu_Hei_XuanNiu"
LampAgent.wirePostModelPath[1]["coilingPath"] = "GameObjScale/XiaoDengPaoHeDengPaoDiZuo/JieXianZhu_Hei/xian002"

LampAgent.wirePostModelPath[2] = {}
LampAgent.wirePostModelPath[2]["leapPath"] = "GameObjScale/XiaoDengPaoHeDengPaoDiZuo/JieXianZhu_Hong"
LampAgent.wirePostModelPath[2]["knobPath"] = "GameObjScale/XiaoDengPaoHeDengPaoDiZuo/JieXianZhu_Hong/JieXianZhu_Hong_XuanNiu"
LampAgent.wirePostModelPath[2]["coilingPath"] = "GameObjScale/XiaoDengPaoHeDengPaoDiZuo/JieXianZhu_Hong/xian002"

LampAgent.childrenModelPath = {}
LampAgent.childrenModelPath["effectPath"] = "GameObjScale/light/light"
LampAgent.childrenModelPath["dengPao"] = "GameObjScale/light"

--ui数据路径
LampAgent.uidatapath = "LampElement_PC/resource/LampElement.json"

--灯泡颜色
LampAgent.Color = Color(255/255,181/255,69/255,65/255)

--数据序列化、反序列化、UI交互涉及到的配置
LampAgent.labDataConfig = {}

LampAgent.labDataConfig["FRatedVoltage"] = {}
LampAgent.labDataConfig["FRatedVoltage"]["DefaultValue"] = 2.5
LampAgent.labDataConfig["FRatedVoltage"]["Serialize"] = {typeName="number"}		
LampAgent.labDataConfig["FRatedVoltage"]["Deserialize"] = {typeName="number",useFunction="LampAgent.InitFRatedVoltage"}	
LampAgent.labDataConfig["FRatedVoltage"]["GetByUI"] = {typeName="number"}		
LampAgent.labDataConfig["FRatedVoltage"]["SetByUI"] = {typeName="number",useFunction="LampAgent.OnChangeFRatedVoltage"}	

LampAgent.labDataConfig["FRatedPower"] = {}
LampAgent.labDataConfig["FRatedPower"]["DefaultValue"] = 0.5
LampAgent.labDataConfig["FRatedPower"]["Serialize"] = {typeName="number"}		
LampAgent.labDataConfig["FRatedPower"]["Deserialize"] = {typeName="number",useFunction="LampAgent.InitFRatedPower"}	
LampAgent.labDataConfig["FRatedPower"]["GetByUI"] = {typeName="number"}		
LampAgent.labDataConfig["FRatedPower"]["SetByUI"] = {typeName="number",useFunction="LampAgent.OnChangeFRatedPower"}	

LampAgent.labDataConfig["MaxCurrent"] = {}
LampAgent.labDataConfig["MaxCurrent"]["GetByUI"] = {typeName="number",useFunction="LampAgent.OnGetMaxCurrent"}		
LampAgent.labDataConfig["MaxCurrent"]["SetByUI"] = {typeName="number",useFunction="LampAgent.OnSetMaxCurrent"}

--可吸附到的母体的类型配置  todo配置下
LampAgent.absorbParentConfig = {}
LampAgent.absorbParentConfig[1] = tostring(CircuitElementType.GanHuangGuanYanShiHeElement)
LampAgent.absorbParentConfig[2] = tostring(CircuitElementType.TableElement)
LampAgent.compositeParentDataConfig = {}
LampAgent.compositeParentDataConfig[1] = tostring(CircuitElementType.GanHuangGuanYanShiHeElement)


--==========方法定义=============
--创建
function LampAgent:Create(guid,paramsTable)
	local obj = LampAgent:New()
	obj:LBABaseCreate(guid,paramsTable,obj) 
		
	obj.FRatedVoltage = LampAgent.labDataConfig["FRatedVoltage"]["DefaultValue"]
	obj.FRatedPower = LampAgent.labDataConfig["FRatedPower"]["DefaultValue"]
	
	obj:Init(paramsTable)
	return obj
end

--初始化
function LampAgent:Init(paramsTable)
	--向引擎请求相应创建对象
	local engineElementId = self:CreateCircuitComponent(EngineCircuitComponentType.Resistor)
	self.engineElementId = engineElementId
	--和引擎能力 Component 绑定
	self.ResistorAction:BindComponent(engineElementId)
	
	--初始化场景对象
	self:LBABaseInit(paramsTable)
	
	--元件能力绑定
	local entityId = self:GetEntityId()
	self.VLabBestCameraAngle:Bind(entityId)
	self.VLabLightParticleCtrl:Bind(entityId)
	self.lightCtrlId = self.VLabLightParticleCtrl:CreateParticle(LampAgent.childrenModelPath["dengPao"],LampAgent.childrenModelPath["effectPath"])
	self.VLabLightParticleCtrl:ChangeParticleColor(self.lightCtrlId, LampAgent.Color)

	
	self.VLabChildAdsorb:Bind(entityId)
	self.VLabChildAdsorb:Create(entityId,EmptyChildPath,tostring(LampAgent.elementType))
	self.VLabChildAdsorb:InitViewAdsorb(EmptyChildPath,LampAgent.absorbParentConfig,EmptyChildPath,AbsorbDetectMode.SPHERE_COLLIDER_DETECT)
	self.VLabChildAdsorb:SetSphereColliderDetectParams(EmptyChildPath,0.3,Vector3(0.1, 0.1, 0.1) , 0.5, 0)
	self.VLabChildAdsorb:AddActionListener(EmptyChildPath,AbsorbActionType.AbsorbFinish,LampAgent.OnAbsorbToParentCallback)
	self.VLabChildAdsorb:AddActionListener(EmptyChildPath,AbsorbActionType.CancelAbsorbFinish,LampAgent.OnCancelAbsorbToParentCallback)
	

	--初始化接线柱能力
	local enginePortTable = self.ResistorAction.PortIDs
	enginePortTable = CSArrayToLuaArray(enginePortTable,2)
	self.enginePortTable = enginePortTable
	self:InitWirePost(engineElementId,2,LampAgent.wirePostModelPath,enginePortTable,paramsTable.ID)
	
	--交互功能绑定
	self.moveId =self:LBAInitInteractiveMove(EmptyChildPath, InteractiveMoveEventType.All, InputAxisType.Mastercontrol0)
	self.clickId = self:LBAInitInteractiveClick(EmptyChildPath, InputAxisType.Mastercontrol0, {}, "")
	self.doubleClickId =self:LBAInitInteractiveDoubleClick(EmptyChildPath, InputAxisType.Mastercontrol0, "")
	self:LBAInitInteractivePointMove(EmptyChildPath, InteractivePointMoveEventType.All, {}, "")
	
	--数据变化响应绑定
	self.ResistorAction:BindAttrChangeFunction(LampAgent.ValueChangeCallback)

	--初始化数据的设置
	self:InitActionValues()
end

--吸附到父物体的回调
function LampAgent:OnAbsorbToParentCallback(selfId, selfPath, otherId, otherPath)
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


function LampAgent:InitFRatedPower(nValue)
	if not nValue then
		return
	end
	
	self.FRatedPower = tonumber(nValue) or 0
	local fRatedVoltage = tonumber(ToolClass.GetTableValueByKey(self.elementTable,"FRatedVoltage",true)) or 0
	
	self:SetResistance(fRatedVoltage,self.FRatedPower)
end

function LampAgent:InitFRatedVoltage(nValue)
	if not nValue then
		return
	end
	
	self.FRatedVoltage = tonumber(nValue) or 0
	local fRatedPower = tonumber(ToolClass.GetTableValueByKey(self.elementTable,"FRatedPower",true)) or 0
	
	self:SetResistance(self.FRatedVoltage,fRatedPower)
end

--属性改变响应
function LampAgent:ValueChangeCallback(jsonStr)
	--print("=====ConstantResistor ValueChangeCallback:"..tostring(jsonStr))
	local isOK,paramsTable = ToolClass.GetLuaTableFroJson(jsonStr)
	if not isOK or not self then
		return
	end
   
    self:BaseProcessBreakDown()
	self:OnValueChangeCallback(paramsTable)
	
	for i,v in pairs(paramsTable) do
		local key = tostring(v["ParamKey"])	

		if key == "Current" then
			self:ProcessLight()
			break
		end
	end
end

--处理灯光亮度
function LampAgent:ProcessLight()
	local nLightCtrId = tonumber(self.lightCtrlId) or 0
	if self:IsBreakDown() then
		Run(function () 
			Wait(1)--等所有的元器件创建出来
			if self:IsBreakDown() then
				self.VLabLightParticleCtrl:SetParticleActive(nLightCtrId,false)
			end
		end)
	else
		local current = self.ResistorAction.Current
		local voltage = self.ResistorAction.Voltage
		local nowPower = current*voltage
		nowPower = math.abs(nowPower)
		Util.LogError(nowPower)
		if nowPower < 0.001 then
			self.VLabLightParticleCtrl:SetParticleActive(nLightCtrId,false)
		else
			if nowPower > 3 then
				nowPower = 3
			end
			local lightSize = nowPower/10
			--print("亮度"..lightSize)
			self.VLabLightParticleCtrl:ChangeParticleSize(nLightCtrId,lightSize)
			self.VLabLightParticleCtrl:SetParticleActive(nLightCtrId,true)
		end
	end	
end

--改变额定电压
function LampAgent:OnChangeFRatedVoltage(newValue)
	if not newValue then 
		--print("LampAgent:OnChangeFRatedVoltage newValue is nil!")
		return 
	end
	
	local fNewVoltage = tonumber(newValue) or 0	
	self.FRatedVoltage = fNewVoltage
	local fRatedPower = tonumber(self.FRatedPower) or 0
	self:SetResistance(fNewVoltage,fRatedPower)
	self:BaseProcessBreakDown()
end

--改变额定功率
function LampAgent:OnChangeFRatedPower(newValue)
	if not newValue then 
		--print("LampAgent:OnChangeFRatedPower newValue is nil!")
		return 
	end
	
	local fNewPower = tonumber(newValue) or 0	
	self.FRatedPower = fNewPower
	local fRatedVoltage = tonumber(self.FRatedVoltage) or 0
	self:SetResistance(fRatedVoltage,fNewPower)
	self:BaseProcessBreakDown()
end

--设置内阻
function LampAgent:SetResistance(ratedVoltage,ratedPower)
	local ratedVoltage = tonumber(ratedVoltage) or 0
	local ratedPower = tonumber(ratedPower) or 0
	
	if ratedPower <= 0 then
		ratedPower = 0.5
	end
	
	if ratedVoltage <= 0 then
		ratedVoltage = 2.5
	end
	
	local realResistance = math.abs(ratedVoltage*ratedVoltage/ratedPower)
	if realResistance < 0 then
		realResistance = 1
	end
	 
	self.ResistorAction.Resistance = realResistance
end

--损坏
function LampAgent:BreakDown()
	self.ResistorAction.IsOverload = true
	self:BaseBreakDown()
end

--修复
function LampAgent:FixBreakDown()
	self.ResistorAction.IsOverload = false
	self:BaseFixBreakDown()
end

--损坏判断
function LampAgent:IsBreakDown()
	local current = self.ResistorAction.Current
	local voltage = self.ResistorAction.Voltage
	local nowPower = current*voltage
	
	local fRatedPower = tonumber(self.FRatedPower) or 0
    local isBroken = math.abs(nowPower / fRatedPower) > LampAgent.brokenRatio
	if isBroken then
		self:SetBrokenReason(BrokenReason.HighCurrent)
	end
	
    return isBroken
end

function LampAgent:OnEntireMove(objPath,eventType,WorldPos,offset,isFocus)
	self:CircuitInteractiveMove(objPath,eventType,WorldPos,offset,isFocus)
end

function LampAgent:OnEntireClick(objPath,eventType,screenPos,worldPos)
	self:CircuitInteractiveClick(objPath,eventType,screenPos,worldPos)
end

function LampAgent:OnGetMaxCurrent(value)
	local fRatedPower = tonumber(self.FRatedPower) or 0
	local fRatedVoltage = tonumber(self.FRatedVoltage) or 0
	if fRatedVoltage == 0 then
		return 0
	end
	
	local fRatedCurrent = fRatedPower/fRatedVoltage
	return fRatedCurrent*LampAgent.brokenRatio
end

function LampAgent:OnSetMaxCurrent(value)
	local value = tonumber(value) or 0
	
	self.FRatedPower = value/LampAgent.brokenRatio * self.FRatedVoltage
end