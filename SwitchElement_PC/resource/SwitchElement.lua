--单刀单掷开关
agent SwitchSPSTAgent = inheritsFrom(LabBaseAgent:New())
SwitchSPSTAgent:AddBaseLogic(CircuitElementBaseLogic:New())

--==========数据配置=============

SwitchSPSTAgent.elementType = CircuitElementType.SwitchSPST

--接线柱路径配置
SwitchSPSTAgent.wirePostModelPath = {}
SwitchSPSTAgent.wirePostModelPath[1] = {}	--第一个是负极
SwitchSPSTAgent.wirePostModelPath[1]["leapPath"] = "GameObjScale/DanDaoDanZhiKaiGuan/JieXianZhu_01"
SwitchSPSTAgent.wirePostModelPath[1]["knobPath"] = "GameObjScale/DanDaoDanZhiKaiGuan/JieXianZhu_01/XuanNiu_01"
SwitchSPSTAgent.wirePostModelPath[1]["coilingPath"] = "GameObjScale/DanDaoDanZhiKaiGuan/JieXianZhu_01/xian002"

SwitchSPSTAgent.wirePostModelPath[2] = {}
SwitchSPSTAgent.wirePostModelPath[2]["leapPath"] = "GameObjScale/DanDaoDanZhiKaiGuan/JieXianZhu_02"
SwitchSPSTAgent.wirePostModelPath[2]["knobPath"] = "GameObjScale/DanDaoDanZhiKaiGuan/JieXianZhu_02/XuanNiu_02"
SwitchSPSTAgent.wirePostModelPath[2]["coilingPath"] = "GameObjScale/DanDaoDanZhiKaiGuan/JieXianZhu_02/xian002"

--子模型路径配置
SwitchSPSTAgent.childrenModelPath = {}
SwitchSPSTAgent.childrenModelPath["zadao"] = "GameObjScale/DanDaoDanZhiKaiGuan/ZhaDaoJinShuPianWrapper/ZhaDaoJinShuPian"
SwitchSPSTAgent.childrenModelPath["zadaotou"] = "GameObjScale/DanDaoDanZhiKaiGuan/ZhaDaoJinShuPianWrapper/ZhaDaoJinShuPian/ZhaDaoShouBin"
SwitchSPSTAgent.childrenModelPath["dizuo"] = "GameObjScale/DanDaoDanZhiKaiGuan/DiZuo"

SwitchSPSTAgent.ignoreChildModePath={}
SwitchSPSTAgent.ignoreChildModePath[1]="ZhaDaoJinShuPian"

--旧连接关系与模型路径的对应表
SwitchSPSTAgent.newPostModelPathToOldIndex = {}
SwitchSPSTAgent.newPostModelPathToOldIndex[SwitchSPSTAgent.wirePostModelPath[1]["leapPath"]] = "0"
SwitchSPSTAgent.newPostModelPathToOldIndex[SwitchSPSTAgent.wirePostModelPath[2]["leapPath"]] = "1"

--实验室对象旧属性名与新属性名的映射关系
SwitchSPSTAgent.oldKeyToNewKey["OpenState"] = "realAgent.SwitchAction.isOpen"

--ui数据路径
SwitchSPSTAgent.uidatapath = "SwitchElement_PC/resource/SwitchElement.json"

--数据序列化与反序列化配置表
SwitchSPSTAgent.labDataConfig = {}

SwitchSPSTAgent.labDataConfig["SwitchAction.isOpen"] = {}
SwitchSPSTAgent.labDataConfig["SwitchAction.isOpen"]["DefaultValue"] = true
SwitchSPSTAgent.labDataConfig["SwitchAction.isOpen"]["Serialize"] = {typeName="boolean"}
SwitchSPSTAgent.labDataConfig["SwitchAction.isOpen"]["Deserialize"] = {typeName="boolean",useFunction="SwitchSPSTAgent.OnDeserializeOpenState"}

SwitchSPSTAgent.absorbParentConfig = {}
SwitchSPSTAgent.absorbParentConfig[1] = tostring(CircuitElementType.TableElement)
--==========方法定义=============
--创建
function SwitchSPSTAgent:Create(guid,paramsTable)
	local obj = SwitchSPSTAgent:New()
	obj:LBABaseCreate(guid,paramsTable,obj)    
	obj:Init(paramsTable)
	return obj
end

--初始化
function SwitchSPSTAgent:Init(paramsTable)
	--向引擎请求相应创建对象
	local engineElementId = self:CreateCircuitComponent(EngineCircuitComponentType.SwitchSPST)
	self.engineElementId = engineElementId
	--和引擎能力 Component 绑定
	self.SwitchAction:BindComponent(engineElementId)
	
	--初始化场景对象
	self:LBABaseInit(paramsTable)
	
	--初始化接线柱能力
	local enginePortTable = self.SwitchAction.PortIDs
	enginePortTable = CSArrayToLuaArray(enginePortTable,2)
	self.enginePortTable = enginePortTable
	self:InitWirePost(engineElementId,2,SwitchSPSTAgent.wirePostModelPath,enginePortTable,paramsTable.ID)
	
	--交互功能绑定
	local entityId = self:GetEntityId()
	self.VLabBestCameraAngle:Bind(entityId)

	self.AudioPathId = "GameObjScale"
	self.VLabEleSoundCtrl:Bind(entityId)
	self.VLabEleSoundCtrl:AddAudioSource(self.AudioPathId, EmptyChildPath)
	self.VLabEleSoundCtrl:LoadAudioClip(self.AudioPathId, "Audio/SwitchAudio","SwitchElement")
	self.VLabEleSoundCtrl:SetAudioVolume(self.AudioPathId, 1)
	self.VLabEleSoundCtrl:AudioDefaultSetting(self.AudioPathId, false,false)

	self.VLabChildAdsorb:Bind(entityId)
	self.VLabChildAdsorb:Create(entityId,EmptyChildPath,tostring(SwitchSPSTAgent.elementType))
	self.VLabChildAdsorb:InitViewAdsorb(EmptyChildPath,SwitchSPSTAgent.absorbParentConfig,EmptyChildPath,AbsorbDetectMode.SPHERE_COLLIDER_DETECT)
	self.VLabChildAdsorb:SetSphereColliderDetectParams(EmptyChildPath,0.3,Vector3(0.1, 0.1, 0.1) , 0.5, 0)
	self.VLabChildAdsorb:AddActionListener(EmptyChildPath,AbsorbActionType.AbsorbFinish,SwitchSPSTAgent.OnAbsorbToParentCallback)
	self.VLabChildAdsorb:AddActionListener(EmptyChildPath,AbsorbActionType.CancelAbsorbFinish,SwitchSPSTAgent.OnCancelAbsorbToParentCallback)
	
	self:LBAInitInteractiveMove(EmptyChildPath, InteractiveMoveEventType.All, InputAxisType.Mastercontrol0)	
	
	local cursorTable = 
	{
		[CursorType.Enter] = CursorStyles.BeginClick,
		[CursorType.Rotate] = CursorStyles.Click
	}
	local rotid = self:LBAInitInteractiveRotate(SwitchSPSTAgent.childrenModelPath["zadaotou"], InteractiveRotateEventType.Rotate, InputAxisType.Mastercontrol0, cursorTable, "")

	local rotateTable =
	{
		[InteractiveRotateInfo.RotateObject] = SwitchSPSTAgent.childrenModelPath["zadao"],
		--[InteractiveRotateInfo.IgnoreGameObjectPaths] = SwitchSPSTAgent.ignoreChildModePath,
		[InteractiveRotateInfo.RotateType] = RotateAxies.Y,
		[InteractiveRotateInfo.Max] = 30,
		[InteractiveRotateInfo.Min] = -40,
		[InteractiveRotateInfo.OffsetAngle] = Vector3(0, 180, 0)
	}
	self:LBASetInteractiveRotateInfos(rotid, rotateTable)
	self.clickId = self:LBAInitInteractiveClick(EmptyChildPath, InputAxisType.Mastercontrol0, {}, "")
	self.doubleClickId =self:LBAInitInteractiveDoubleClick(EmptyChildPath, InputAxisType.Mastercontrol0, "")	
	self.moveId =self:LBAInitInteractivePointMove(EmptyChildPath, InteractivePointMoveEventType.All, {}, "")
	
	--初始化数据的设置
	self:InitActionValues()
end

--吸附到父物体的回调
function SwitchSPSTAgent:OnAbsorbToParentCallback(selfId, selfPath, otherId, otherPath)
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

function SwitchSPSTAgent:ZhaDaoEnterCallback(enter)
	--[[if enter then
		if LAB_MGR.CurrentCursorName == 'None' or LAB_MGR.CurrentCursorName == 'Default' then
			LAB_MGR.VLabCursorStyle:SetCursor(CursorStyles.BeginClick)
		end
	elseif not enter then
		if LAB_MGR.CurrentCursorName == 'BeginClick' then
			LAB_MGR.VLabCursorStyle:SetCursor(CursorStyles.None)
		end
	end--]]
end

--开关状态转换
function SwitchSPSTAgent:SetOpenState(openState)
	if not self.SwitchAction then
		print("SwitchSPST:SwitchOpenState no SwitchAction")
		return
	end

	local newOpenState = true
	if not openState then
		newOpenState = false
	end
	
	if self.SwitchAction.isOpen == newOpenState then
		return
	end
	
	self.SwitchAction.isOpen = newOpenState
	if self.SwitchAction.isOpen == false then 
		self.VLabEleSoundCtrl:SetAudioPlayStatus(self.AudioPathId,0)
	end 

end

--取开关状态
function SwitchSPSTAgent:GetOpenState()
	if not self.circuitAgent.SwitchAction then
		print("SwitchSPST:GetOpenState no circuitAgent")
		return true
	end
	
	return self.SwitchAction.isOpen
end

--铡刀旋转响应
function SwitchSPSTAgent:OnEntireRotate(objPath, eventType, value, offset, process, isFocuse)
	if eventType == "Rotate" then
		if process > 0.922 then
			self:SetOpenState(false)
		else
			self:SetOpenState(true)
		end
	
	end
end

function SwitchSPSTAgent:OnEntireMove(objPath,eventType,WorldPos,offset,isFocus)
	self:CircuitInteractiveMove(objPath,eventType,WorldPos,offset,isFocus)

	self:LBABaseInteractiveMove(objPath, eventType, worldPos, offset, isFocus)
	if AbsorbLinkMovePath == tostring(objPath) then
		return
	end

	if eventType == "BeginMove" then
		self:BreakAbsorbLinkedParent(EmptyChildPath)
		self.VLabChildAdsorb:ChildDetecting(EmptyChildPath,true)
	elseif eventType == "EndMove" then
		self.VLabChildAdsorb:ChildDetecting(EmptyChildPath,false)
	elseif eventType == "Moving" then	
	end

end

function SwitchSPSTAgent:OnEntireClick(objPath,eventType,screenPos,worldPos)
	self:CircuitInteractiveClick(objPath,eventType,screenPos,worldPos)
end

--初始化开关状态
function SwitchSPSTAgent:OnDeserializeOpenState(value)	
	if type(value) == "boolean" then
		if value then
			--开启
			self.Transform:SetChildEulerAngles(SwitchSPSTAgent.childrenModelPath["zadao"],Vector3(0,-45,0),true)
		else
			--关闭
			self.Transform:SetChildEulerAngles(SwitchSPSTAgent.childrenModelPath["zadao"],Vector3(0,0,0), true)
		end
		self:SetOpenState(value)
	end
end