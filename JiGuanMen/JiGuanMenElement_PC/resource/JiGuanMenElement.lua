-- 机关门
agent JiGuanMenElementAgent = inheritsFrom(LabBaseAgent:New())
JiGuanMenElementAgent:AddBaseLogic(CircuitElementBaseLogic:New())  -- 继承电学基类


--==========数据配置=============
JiGuanMenElementAgent.elementType = CircuitElementType.JiGuanMenElement

--==========模型路径配置=============
--电池节数的模型分别是1-4节
JiGuanMenElementAgent.ModelPath= {}
JiGuanMenElementAgent.ModelPath["1"]="GameObjScale/JiGuangMenElement/door/Battery/Cube1"
JiGuanMenElementAgent.ModelPath["2"]="GameObjScale/JiGuangMenElement/door/Battery/Cube2"
JiGuanMenElementAgent.ModelPath["3"]="GameObjScale/JiGuangMenElement/door/Battery/Cube3"
JiGuanMenElementAgent.ModelPath["4"]="GameObjScale/JiGuangMenElement/door/Battery/Cube4"

JiGuanMenElementAgent.HightModelPath = {}
JiGuanMenElementAgent.HightModelPath["Battery"]="GameObjScale/JiGuangMenElement/door/Battery"

JiGuanMenElementAgent.wirePostModelPath = {}
JiGuanMenElementAgent.wirePostModelPath[1] = {}	--第一个是负极
JiGuanMenElementAgent.wirePostModelPath[1]["leapPath"] = "GameObjScale/JiGuangMenElement/JieXianZhu_Hei"
JiGuanMenElementAgent.wirePostModelPath[1]["knobPath"] = "GameObjScale/JiGuangMenElement/JieXianZhu_Hei/XuanNiu_02"
JiGuanMenElementAgent.wirePostModelPath[1]["coilingPath"] = "GameObjScale/JiGuangMenElement/JieXianZhu_Hei/xian002"

JiGuanMenElementAgent.wirePostModelPath[2] = {}
JiGuanMenElementAgent.wirePostModelPath[2]["leapPath"] = "GameObjScale/JiGuangMenElement/JieXianZhu_Hong"
JiGuanMenElementAgent.wirePostModelPath[2]["knobPath"] = "GameObjScale/JiGuangMenElement/JieXianZhu_Hong/XuanNiu_01"
JiGuanMenElementAgent.wirePostModelPath[2]["coilingPath"] = "GameObjScale/JiGuangMenElement/JieXianZhu_Hong/xian002"

--光标配置
JiGuanMenElementAgent.CursorTable = {}
JiGuanMenElementAgent.CursorTable["Drag"] = {}
JiGuanMenElementAgent.CursorTable["Drag"]["Drag"] = CursorStyles.BeginDrag
JiGuanMenElementAgent.CursorTable["Drag"]["Draging"] = CursorStyles.Draging
JiGuanMenElementAgent.CursorTable["Rotate"] = {}
JiGuanMenElementAgent.CursorTable["Rotate"]["Enter"] = CursorStyles.Rotate
JiGuanMenElementAgent.CursorTable["Rotate"]["Rotate"] = CursorStyles.Rotate


--吸附类型配置
JiGuanMenElementAgent.canAbsorbConfig = {}
JiGuanMenElementAgent.canAbsorbConfig[1] = tostring( CircuitElementType.TableElement)

--ui数据路径
JiGuanMenElementAgent.uidatapath = "JiGuanMenElement_PC/resource/JiGuanMenElement.json"

--数据序列化、反序列化、UI交互涉及到的配置
JiGuanMenElementAgent.labDataConfig = {}

--==========方法定义=============
--创建
function JiGuanMenElementAgent:Create(guid,paramsTable)
	local obj = JiGuanMenElementAgent:New()
	obj:LBABaseCreate(guid,paramsTable,obj) 
	obj:Init(paramsTable)
	return obj
end

--初始化
function JiGuanMenElementAgent:Init(paramsTable)
	local entityId = self:GetEntityId()
	self.entityId = entityId
	self:ACBind(self.entityId)						-- 初始绑定AC组件
	self:InitData(entityId,paramsTable)
	self:InitInteractive(self.entityId) 					-- 初始化绑定交互
	--self:InitText(entityId)
	self:InitActionValues()							-- 调用基类反序列化函数
end

-- 初始绑定AC组件
function JiGuanMenElementAgent:ACBind(entityId)
	self.VLabBestCameraAngle:Bind(entityId)			-- 最佳视角绑定
	self.VLabChangeModel:Bind(entityId) 			--绑定借口VLabChangeModel
	self.VLabLinkRelation:Bind(entityId)            -- 链接绑定
	self.VLabChildAdsorb:Bind(entityId)             -- 子吸附绑定  
 end

-- 初始化基础交互
function JiGuanMenElementAgent:InitInteractive(entityId)
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

-- 初始化数据
function JiGuanMenElementAgent:InitData(entityId,paramsTable)
	self:SetDianChiColor(4,"Orange")

	--向引擎请求相应创建对象
	local engineElementId = self:CreateCircuitComponent(EngineCircuitComponentType.Resistor)
	self.CiruiteElementSet:InitType("ResistorAction")
	self.CiruiteElementSet:AddComponent("ResistorAction", engineElementId)
	--电阻1
	local tResistor1 = self.CiruiteElementSet:GetPortIDs(engineElementId)
	tResistor1 = CSArrayToLuaArray(engineElementId,2)
	self.portTable = {  { ["id"] = engineElementId, ["port"] = tResistor1[1] },
						{ ["id"] = engineElementId, ["port"] = tResistor1[2] },
					 }
end


-- 初始化子吸附
function JiGuanMenElementAgent:InitChildAbsord(entityId)   
	self.VLabChildAdsorb:Bind(self.entityId) --子吸附绑定
	self.VLabChildAdsorb:Create(self.entityId, EmptyChildPath, tostring(self.elementType))
	self.VLabChildAdsorb:InitViewAdsorb(EmptyChildPath,self.canAbsorbConfig, EmptyChildPath, AbsorbDetectMode.BOX_COLLIDER_DETECT)
	self.VLabChildAdsorb:SetBoxColliderDetectParams(EmptyChildPath,Vector3(0, 0, 0), Vector3(0.01, 0.01, 0.01), 1, 0)			
	self.VLabChildAdsorb:AddActionListener(EmptyChildPath,AbsorbActionType.AbsorbFinish,self.OnChildAbsorbCallback)
	self.VLabChildAdsorb:AddActionListener(EmptyChildPath,AbsorbActionType.CancelAbsorbFinish,self.OnChildCancleAbsorbCallback)
end

-- 初始化子链接组件 
function JiGuanMenElementAgent:InitChildLink(entityId)
	local linkId = self.VLabLinkRelation:CreateChildLink(EmptyChildPath)
	self:SaveAbsorbLinkData(AbsorbLinkPartType.Child,EmptyChildPath,linkId)
end

--吸附
function JiGuanMenElementAgent:OnChildAbsorbCallback()
	local element = LabElementManager.GetElement(otherId)
	if element.elementType == CircuitElementType.TableElement then
		 element:LinkToTable(self, self.portTable)
		 print( " 宝箱传递电阻正负极，开关1负极，开关3正极 " )
		 self:LBADeleteInteractive(InteractiveACType.Drag, self.MoveId)
	end
end
--取消吸附
function JiGuanMenElementAgent:OnChildCancleAbsorbCallback()

end

--========== 基类回调方法 =============

--属性改变响应
function JiGuanMenElementAgent:ValueChangeCallback(jsonStr)
	local isOK,paramsTable = ToolClass.GetLuaTableFroJson(jsonStr)
	if not isOK or not self then
		return
	end
	self:OnValueChangeCallback(paramsTable)
end


-- 重写基类移动回调
function JiGuanMenElementAgent:OnEntireMove(objPath,eventType,WorldPos,offset,isFocus,linkMoveInfo)
	local bValue = (linkMoveInfo == "" or linkMoveInfo == nil) and true or false
	if not(bValue) then -- 被带动移动时，直接return
		return
	end
	
	self:CircuitInteractiveMove(objPath,eventType,WorldPos,offset,isFocus)
	if eventType == "BeginMove" then
		
	elseif eventType == "Moving" then
		
	elseif eventType == "EndMove" then
		
	end
end

--========== AC回调方法 =============



--========== 逻辑代码开始 =============
--设置标记符号
function JiGuanMenElementAgent:SetDianChiColor(number,color)
	local nColor = color
	for i = 1,number do 
		i = tostring(i)
		if nColor == "Red" then
			self.VLabChangeModel:ChangeMaterialColor(self.ModelPath[i],0,1,0,0)
		elseif nColor == "Blue" then
			self.VLabChangeModel:ChangeMaterialColor(self.ModelPath[i],0,0,1,0)
		elseif nColor == "Orange" then
			self.VLabChangeModel:ChangeMaterialColor(self.ModelPath[i],0,1,0.5,0)
		end
	end
end 

--========== UI事件代码开始 =============



--========== 序列化反序列化 =============



