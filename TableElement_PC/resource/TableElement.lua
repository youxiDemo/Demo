-- 桌子
agent TableElementAgent = inheritsFrom(LabBaseAgent:New())
TableElementAgent:AddBaseLogic(CircuitElementBaseLogic:New())  -- 继承电学基类


--==========数据配置=============
TableElementAgent.elementType = CircuitElementType.TableElement

--==========模型路径配置=============
TableElementAgent.ModelPath = {}
TableElementAgent.ModelPath["Power"] = "GameObjScale/MainGO/ChildComponent/Power"
TableElementAgent.ModelPath["SwitchSPST"] = "GameObjScale/MainGO/ChildComponent/Switch"
TableElementAgent.ModelPath["BoxDemo"] = "GameObjScale/MainGO/ChildComponent/Chest"
TableElementAgent.ModelPath["DoubleThrowSwitch"] = "GameObjScale/MainGO/ChildComponent/DoubleSwtich"

TableElementAgent.ModelPath["Lamp"] = {}
TableElementAgent.ModelPath["Lamp"][1] = "GameObjScale/MainGO/ChildComponent/Lamp_1"
TableElementAgent.ModelPath["Lamp"][2] = "GameObjScale/MainGO/ChildComponent/Lamp_2"
TableElementAgent.ModelPath["Lamp"][3] = "GameObjScale/MainGO/ChildComponent/Lamp_3"
TableElementAgent.ModelPath["JiGuanMenElement"] = "GameObjScale/MainGO/ChildComponent/Door"

--吸附类型配置
TableElementAgent.canAbsorbConfig = {}
TableElementAgent.canAbsorbConfig[tostring(CircuitElementType.DoubleThrowSwitch)] = 1
TableElementAgent.canAbsorbConfig[tostring(CircuitElementType.SwitchSPST)] = 1
TableElementAgent.canAbsorbConfig[tostring(CircuitElementType.Lamp)] = 3
TableElementAgent.canAbsorbConfig[tostring(CircuitElementType.Power)] = 1
TableElementAgent.canAbsorbConfig[tostring(CircuitElementType.JiGuanMenElement)] = 1
TableElementAgent.canAbsorbConfig[tostring(CircuitElementType.BoxDemo)] = 1


--ui数据路径
TableElementAgent.uidatapath = "TableElement_PC/resource/TableElement.json"

--数据序列化、反序列化、UI交互涉及到的配置
TableElementAgent.labDataConfig = {}

--==========方法定义=============
-- 初始化数据
function TableElementAgent:InitData(entityId)
	self.elementCount = 8
	self.lampCount = 0 
	self.PostTable = {}
end
	
--创建
function TableElementAgent:Create(guid,paramsTable)
	local obj = TableElementAgent:New()
	obj:LBABaseCreate(guid,paramsTable,obj) 
	obj:Init(paramsTable)
	return obj
end

--初始化
function TableElementAgent:Init(paramsTable)
	local entityId = self:GetEntityId()
	self.entityId = entityId
	self:InitData()
	self:ACBind(self.entityId)						-- 初始绑定AC组件
	self:InitInteractive(self.entityId) 					-- 初始化绑定交互
	self:InitParentAbsord(self.entityId)					-- 初始绑定父吸附组件
	self:InitParentLink(self.entityId)					-- 初始绑定父链接组件
	self:InitFlow()
	self:InitActionValues()							-- 调用基类反序列化函数
end

-- 初始绑定AC组件
function TableElementAgent:ACBind(entityId)
	self.VLabBestCameraAngle:Bind(entityId)			-- 最佳视角绑定
	self.VLabLinkRelation:Bind(entityId) --链接绑定
	-- self.VLabParentAdsorb:Bind(entityId) --父吸附绑定  (自行吸附配置下，然后把注释打开)
end

-- 初始化基础交互
function TableElementAgent:InitInteractive(entityId)
	-- 点击
	self:LBAInitInteractiveClick(EmptyChildPath,InputAxisType.Mastercontrol0)

	--双击
	self:LBAInitInteractiveDoubleClick(EmptyChildPath,InputAxisType.Mastercontrol0)

	-- 进入离开
	self:LBAInitInteractivePointMove(EmptyChildPath,InteractivePointMoveEventType.Enter,InputAxisType.Mastercontrol0)
	self:LBAInitInteractivePointMove(EmptyChildPath,InteractivePointMoveEventType.Exit,InputAxisType.Mastercontrol0)

	-- 移动
	self.MoveId = self:LBAInitInteractiveMove(EmptyChildPath,InteractiveMoveEventType.All,InputAxisType.Mastercontrol0)
	self:SetEntireMoveId(self.MoveId)
	
end

--初始化游戏流程
function TableElement:InitFlow()





end 

-- 初始化父吸附
function TableElementAgent:InitParentAbsord(entityId)
	self.VLabParentAdsorb:Create(entityId, EmptyChildPath, tostring(self.elementType)) 
	self.VLabParentAdsorb:InitViewAdsorb(EmptyChildPath,self.canAbsorbConfig)
	self.VLabParentAdsorb:AddActionListener(EmptyChildPath,AbsorbActionType.AbsorbFinish,self.OnParentAbsorbCallback)
	self.VLabParentAdsorb:AddActionListener(EmptyChildPath,AbsorbActionType.CancelAbsorbFinish,self.OnParentCancleAbsorbCallback)
	-- self.VLabParentAdsorb:AddActionListener(EmptyChildPath,AbsorbActionType.PreAbsorbFinish,self.OnParentPreAbsorbCallback)
	-- self.VLabParentAdsorb:AddActionListener(EmptyChildPath,AbsorbActionType.CancelPreAbsorbFinish,self.OnParentCanclePreAbsorbCallback)
end

	
-- 初始化父链接组件 
function TableElementAgent:InitParentLink(entityId)
	local linkId = self.VLabLinkRelation:CreateParentLink(EmptyChildPath)
	self:SaveAbsorbLinkData(AbsorbLinkPartType.Parent,EmptyChildPath,linkId)
end


--========== 基类回调方法 =============

-- 重写基类移动回调
function TableElementAgent:OnEntireMove(objPath,eventType,WorldPos,offset,isFocus,linkMoveInfo)
	local bValue = (linkMoveInfo == "" or linkMoveInfo == nil) and true or false
	if not(bValue) then -- 被带动移动时，直接return
		return
	end
	
	self:LBABaseInteractiveMove(objPath,eventType,WorldPos,offset,isFocus)
	if eventType == "BeginMove" then
		
	elseif eventType == "Moving" then
		
	elseif eventType == "EndMove" then
		
	end
end

----------------------------------------------吸附------------------------------------------------

-- 吸附父回调
function TableElementAgent:OnParentAbsorbCallback(selfId,selfPath,otherId,otherPath)
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
	if element then

		local pos 
		if element.elementType == CircuitElementType.Power then 
			pos = self.Transform:GetChildPosition(self.ModelPath["Power"],false)

		elseif element.elementType == CircuitElementType.SwitchSPST then 
			pos = self.Transform:GetChildPosition(self.ModelPath["Switch"],false)

		elseif element.elementType == CircuitElementType.Lamp then 
			self.lampCount = self.lampCount + 1 
			pos = self.Transform:GetChildPosition(self.ModelPath["Lamp_"..tostring(self.lampCount)],false)

		elseif element.elementType == CircuitElementType.DoubleThrowSwitch then 
			pos = self.Transform:GetChildPosition(self.ModelPath["DoubleSwitch"],false)

		elseif element.elementType == CircuitElementType.BoxDemo then 
			pos = self.Transform:GetChildPosition(self.ModelPath["Chest"],false)

		elseif element.elementType == CircuitElementType.JiGuanMenElement then 
			pos = self.Transform:GetChildPosition(self.ModelPath["Door"],false)

		end 
		element.Transform:SetPosition(pos.x,pos.y,pos.z)

		if self.elementCount <= 0 then 


		end 
	end 
end
	

-- 取消父吸附回调
function TableElementAgent:OnParentCancleAbsorbCallback(selfId,selfPath,otherId,otherPath)
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
end

----------------------------------------------对外接口------------------------------------------------
--保存接线柱信息到桌子中
function TableElementAgent:LinkToTable(element,portTable)
	if  not portTable or type(portTable) ~= "table" then 
		print("error args to set")
		return 
	end  
	if element then 
		self.elementCount = self.elementCount - 1
		if element.elementType == CircuitElementType.Lamp then 

			self.PostTable[element.elementType] = self.PostTable[element.elementType] or {}
			table.insert( self.PostTable[element.elementType],portTable)
		else
			local pos = self.Transform:GetChildPosition(self.ModelPath[tostring(element.elementType)],false)
			element.Transform:SetPosition(pos.x,pos.y,pos.z)
			self.PostTable[element.elementType] = portTable
		end 
	end 
end 

----------------------------------------------功能函数------------------------------------------------
