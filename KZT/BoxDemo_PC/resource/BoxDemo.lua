-- 宝箱
agent BoxDemoAgent = inheritsFrom(LabBaseAgent:New())
BoxDemoAgent:AddBaseLogic(CircuitElementBaseLogic:New())  -- 继承电学基类


--==========数据配置=============
BoxDemoAgent.elementType = CircuitElementType.BoxDemo

--==========模型路径配置=============
BoxDemoAgent.ModelPath = {}
BoxDemoAgent.ModelPath["BOX_TOP"] = "GameObjScale/BoxDemo/BoxDemo/BOX_TOP"
BoxDemoAgent.ModelPath["A"] = "GameObjScale/BoxDemo/BoxDemo/PingXingXianJiGuangQi/AnNiu_A/A"
BoxDemoAgent.ModelPath["B"] = "GameObjScale/BoxDemo/BoxDemo/PingXingXianJiGuangQi/AnNiu_B/B"
BoxDemoAgent.ModelPath["C"] = "GameObjScale/BoxDemo/BoxDemo/PingXingXianJiGuangQi/AnNiu_C/C"
BoxDemoAgent.ModelPath["JXZ1"] = "GameObjScale/BoxDemo/BoxDemo/BOX_BOTTOM/JieXianZhu_Hei1"
BoxDemoAgent.ModelPath["JXZ2"] = "GameObjScale/BoxDemo/BoxDemo/BOX_BOTTOM/JieXianZhu_Hei2"
BoxDemoAgent.ModelPath["JXZ3"] = "GameObjScale/BoxDemo/BoxDemo/BOX_BOTTOM/JieXianZhu_Hei3"
BoxDemoAgent.ModelPath["JXZ4"] = "GameObjScale/BoxDemo/BoxDemo/BOX_BOTTOM/JieXianZhu_Hei4"

--吸附类型配置
BoxDemoAgent.canAbsorbConfig = {}
BoxDemoAgent.canAbsorbConfig[1] = tostring( CircuitElementType.TableElement)

--ui数据路径
BoxDemoAgent.uidatapath = "BoxDemo_PC/resource/BoxDemo.json"

--数据序列化、反序列化、UI交互涉及到的配置
BoxDemoAgent.labDataConfig = {}

--==========方法定义=============
--创建
function BoxDemoAgent:Create(guid,paramsTable)
	local obj = BoxDemoAgent:New()
	obj:LBABaseCreate(guid,paramsTable,obj) 
	obj:Init(paramsTable)
	return obj
end

--初始化
function BoxDemoAgent:Init(paramsTable)
	local entityId = self:GetEntityId()
	self.entityId = entityId
	self:InitData(paramsTable)
	self:ACBind(self.entityId)						-- 初始绑定AC组件
	self:InitInteractive(self.entityId) 			-- 初始化绑定交互
	self:InitChildAbsord(self.entityId)				-- 初始绑定子吸附组件
	self:InitChildLink(self.entityId)				-- 初始绑定子链接组件
	self:InitActionValues()							-- 调用基类反序列化函数
end

-- 初始绑定AC组件
function BoxDemoAgent:ACBind(entityId)
	self.VLabBestCameraAngle:Bind(entityId)			-- 最佳视角绑定
	self.VLabAbilityITween:Bind(entityId)			-- ITween
	self.VLabLinkRelation:Bind(entityId)            -- 链接绑定
	self.VLabChildAdsorb:Bind(entityId)             -- 子吸附绑定  
end

-- 初始化基础交互
function BoxDemoAgent:InitInteractive(entityId)

	--空节点绑定
	self:LBAInitInteractiveClick(EmptyChildPath,InputAxisType.Mastercontrol0,nil,InteractParam.InteractFlag)
	self:LBAInitInteractiveClick(self.ModelPath["A"],InputAxisType.Mastercontrol0,nil,InteractParam.InteractFlag)
	self:LBAInitInteractiveClick(self.ModelPath["B"],InputAxisType.Mastercontrol0,nil,InteractParam.InteractFlag)
	self:LBAInitInteractiveClick(self.ModelPath["C"],InputAxisType.Mastercontrol0,nil,InteractParam.InteractFlag)
	self:LBAInitInteractiveClick(self.ModelPath["BOX_TOP"],InputAxisType.Mastercontrol0,nil,InteractParam.InteractFlag)
	
	--双击
	self:LBAInitInteractiveDoubleClick(EmptyChildPath,InputAxisType.Mastercontrol0)

	-- 进入离开
	self:LBAInitInteractivePointMove(EmptyChildPath,InteractivePointMoveEventType.Enter,InputAxisType.Mastercontrol0)
	self:LBAInitInteractivePointMove(EmptyChildPath,InteractivePointMoveEventType.Exit,InputAxisType.Mastercontrol0)

	-- 移动
	self.MoveId = self:LBAInitInteractiveMove(EmptyChildPath,InteractiveMoveEventType.All,InputAxisType.Mastercontrol0)
	self:SetEntireMoveId(self.MoveId)
	
end

-- 初始化数据
function BoxDemoAgent:InitData(paramsTable)

	--向引擎请求相应创建1个电源对象
	local PowerAcId = self:CreateCircuitComponent(EngineCircuitComponentType.Power)
	--开关
	local SwitchId1 = self:CreateCircuitComponent(EngineCircuitComponentType.SwitchSPST)
	local SwitchId2 = self:CreateCircuitComponent(EngineCircuitComponentType.SwitchSPST)
	local SwitchId3 = self:CreateCircuitComponent(EngineCircuitComponentType.SwitchSPST)
	--电阻
	local Resistor1 = self:CreateCircuitComponent(EngineCircuitComponentType.Resistor)
	local Resistor2 = self:CreateCircuitComponent(EngineCircuitComponentType.Resistor)

	--和引擎能力 Component 绑定
	self.CiruiteElementSet:InitType("PowerAction")
	self.CiruiteElementSet:AddComponent("PowerAction", PowerAcId)

	--开关
	self.CiruiteElementSet:InitType("SwitchAction")
	self.CiruiteElementSet:AddComponent("SwitchAction", SwitchId1)
	self.CiruiteElementSet:AddComponent("SwitchAction", SwitchId2) 
	self.CiruiteElementSet:AddComponent("SwitchAction", SwitchId3) 

	--电阻
	self.CiruiteElementSet:InitType("ResistorAction")
	self.CiruiteElementSet:AddComponent("ResistorAction", Resistor1)

	--电源
	local tPowerAcId = self.CiruiteElementSet:GetPortIDs(PowerAcId)
	tPowerAcId = CSArrayToLuaArray(tPowerAcId,2)

	--开关1
	local tSwitchId1 = self.CiruiteElementSet:GetPortIDs(SwitchId1)
	tSwitchId1 = CSArrayToLuaArray(tSwitchId1,2)
	--开关2
	local tSwitchId2 = self.CiruiteElementSet:GetPortIDs(SwitchId2)
	tSwitchId2 = CSArrayToLuaArray(tSwitchId2,2)
	--开关3
	local tSwitchId3 = self.CiruiteElementSet:GetPortIDs(SwitchId3)
	tSwitchId3 = CSArrayToLuaArray(tSwitchId3,2)

	--电阻1
	local tResistor1 = self.CiruiteElementSet:GetPortIDs(Resistor1)
	tResistor1 = CSArrayToLuaArray(tResistor1,2)

	self:WirePostEngineLink(PowerAcId,tPowerAcId[1],SwitchId1,tSwitchId1[2])	--电源负极跟开关一端相连
	self:WirePostEngineLink(PowerAcId,tPowerAcId[1],SwitchId1,tSwitchId2[2])	--电源负极跟开关一端相连
	self:WirePostEngineLink(PowerAcId,tPowerAcId[2],SwitchId1,tSwitchId3[1])	--电源正极跟开关一端相连

	self.portTable = {  { ["id"] = Resistor1, ["port"] = tResistor1[1] },
						{ ["id"] = Resistor1, ["port"] = tResistor1[2] },
						{ ["id"] = tSwitchId1, ["port"] = tSwitchId1[1] },
						{ ["id"] = tSwitchId3, ["port"] = tSwitchId2[2] },
					 }

	self.tSwitchId1 = tSwitchId1
	self.tSwitchId2 = tSwitchId2
	self.tSwitchId3 = tSwitchId3

	self.CiruiteElementSet:Set(tostring(tSwitchId1), "isOpen", false)
	self.CiruiteElementSet:Set(tostring(tSwitchId2), "isOpen", false)
	self.CiruiteElementSet:Set(tostring(tSwitchId3), "isOpen", false)
	--初始化场景对象
	-- self:LBABaseInit(paramsTable)
end

--========== 基类回调方法 =============

function BoxDemoAgent:OnEntireClick( objPath,eventType,screenPos,worldPos, strParams )
	self:LBABaseInteractiveClick(objPath,eventType,screenPos,worldPos)

	if objPath == self.ModelPath["BOX_TOP"] then
		local pos = self.Transform:GetChildEulerAngles(self.ModelPath["BOX_TOP"],true)
		print("demo 单击测试" .. tostring(pos.x))
		if pos.x >= 1 then
		else
			self:ITween()
		end
	end
	
	if objPath == self.ModelPath["A"] then
		local pos = self.Transform:GetChildEulerAngles(objPath,true)
		if pos.y >= 1 then
			self.Transform:SetChildEulerAngles(objPath,Vector3(0, 0, 0), true)
			self.CiruiteElementSet:Set(tostring(self.tSwitchId1), "isOpen", false)
		else
			self.Transform:SetChildEulerAngles(objPath,Vector3(0, -20, 0), true)
			self.CiruiteElementSet:Set(tostring(self.tSwitchId1), "isOpen", true)
		end
		print("    按钮调试 A   ")
	elseif objPath == self.ModelPath["B"] then
		local pos = self.Transform:GetChildEulerAngles(objPath,true)
		if pos.y >= 1 then
			self.Transform:SetChildEulerAngles(objPath,Vector3(0, 0, 0), true)
			self.CiruiteElementSet:Set(tostring(self.tSwitchId2), "isOpen", false)
		else
			self.Transform:SetChildEulerAngles(objPath,Vector3(0, -20, 0), true)
			self.CiruiteElementSet:Set(tostring(self.tSwitchId2), "isOpen", true)
		end
		print("    按钮调试  B  ")
	elseif objPath == self.ModelPath["C"] then
		local pos = self.Transform:GetChildEulerAngles(objPath,true)
		if pos.y >= 1 then
			self.Transform:SetChildEulerAngles(objPath,Vector3(0, 0, 0), true)
			self.CiruiteElementSet:Set(tostring(self.tSwitchId3), "isOpen", false)
		else
			self.Transform:SetChildEulerAngles(objPath,Vector3(0, -20, 0), true)
			self.CiruiteElementSet:Set(tostring(self.tSwitchId3), "isOpen", true)
		end
		print("    按钮调试 C   ")
	end
end

function BoxDemoAgent:ITween()
	self.VLabAbilityITween:RotateTo(self.ModelPath["BOX_TOP"], { x = -90, time = 1, islocal = true , easetype = "Linear" ,
	oncomplete = function()
		-- Run(
			-- function()
			-- 	Wait(2)
			-- 	self.VLabAbilityITween:RotateTo(self.ModelPath["BOX_TOP"], { x = 0, time = 1, islocal = true , easetype = "Linear",
			-- 	oncomplete = function()
			-- 	end,})
			-- end
		-- )
	end,})
end

-- 重写基类移动回调
-- function BoxDemoAgent:OnEntireMove(objPath,eventType,WorldPos,offset,isFocus,linkMoveInfo)
-- 	local bValue = (linkMoveInfo == "" or linkMoveInfo == nil) and true or false
-- 	if not(bValue) then -- 被带动移动时，直接return
-- 		return
-- 	end
-- 	self:LBABaseInteractiveMove(objPath,eventType,WorldPos,offset,isFocus)
-- 	if eventType == "BeginMove" then	
-- 	elseif eventType == "Moving" then	
-- 	elseif eventType == "EndMove" then	
-- 	end
-- end

-- 初始化子吸附
function BoxDemoAgent:InitChildAbsord(entityId)   
	self.VLabChildAdsorb:Bind(self.entityId) --子吸附绑定
	self.VLabChildAdsorb:Create(self.entityId, EmptyChildPath, tostring(self.elementType))
	self.VLabChildAdsorb:InitViewAdsorb(EmptyChildPath,self.canAbsorbConfig, EmptyChildPath, AbsorbDetectMode.BOX_COLLIDER_DETECT)
	self.VLabChildAdsorb:SetBoxColliderDetectParams(EmptyChildPath,Vector3(0, 0, 0), Vector3(0.01, 0.01, 0.01), 1, 0)			
	self.VLabChildAdsorb:AddActionListener(EmptyChildPath,AbsorbActionType.AbsorbFinish,self.OnChildAbsorbCallback)
	self.VLabChildAdsorb:AddActionListener(EmptyChildPath,AbsorbActionType.CancelAbsorbFinish,self.OnChildCancleAbsorbCallback)
end

-- 初始化子链接组件 
function BoxDemoAgent:InitChildLink(entityId)
	local linkId = self.VLabLinkRelation:CreateChildLink(EmptyChildPath)
	self:SaveAbsorbLinkData(AbsorbLinkPartType.Child,EmptyChildPath,linkId)
end

--吸附
function BoxDemoAgent:OnChildAbsorbCallback()
	local element = LabElementManager.GetElement(otherId)
	if element.elementType == CircuitElementType.TableElement then
		 element:LinkToTable(self, self.portTable)
		 print( " 宝箱传递电阻正负极，开关1负极，开关3正极 " )
	end
end
--取消吸附
function BoxDemoAgent:OnChildCancleAbsorbCallback()

end


