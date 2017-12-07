local SD_MULTIEXCHANGE_LOADED = false

function SD_MULTIEXCHANGE_ON_INIT(addon, frame)
  if SD_MULTIEXCHANGE_LOADED then
    return
  end
  
  SD_MULTIEXCHANGE_LOADED = true
  
  _G['SD_EARTH_TOWER_SHOP_EXEC_OLD'] = _G['EARTH_TOWER_SHOP_EXEC']
  _G['EARTH_TOWER_SHOP_EXEC'] = SD_MULTIEXCHANGE_ET_SHOP_EXEC
end

function SD_MULTIEXCHANGE_VOID(arg)
  return
end

function SD_MULTIEXCHANGE_ET_SHOP_EXEC(parent, ctrl)
  local frame = ctrl:GetTopParentFrame();
  
  if string.find(frame:GetUserValue('SHOP_TYPE'), 'EarthTower') == 1 then
    return SD_EARTH_TOWER_SHOP_EXEC_OLD(parent, ctrl);
  end
  
  local fn_old = frame.ShowWindow;
  
  frame.ShowWindow = SD_MULTIEXCHANGE_VOID;
  
  SD_EARTH_TOWER_SHOP_EXEC_OLD(parent, ctrl);
  
  frame.ShowWindow = fn_old;
  
  SD_MULTIEXCHANGE_FREEZE_BTN(0, ctrl:GetParent():GetName(), ctrl:GetName());
end

function SD_MULTIEXCHANGE_FREEZE_BTN(flag, parent_name, button_name)
  local frame = ui.GetFrame('earthtowershop');
  local ctrl_set = GET_CHILD_RECURSIVELY(frame, parent_name);
  local btn = GET_CHILD_RECURSIVELY(ctrl_set, button_name);
  
  if flag == 1 then
    btn:SetEnable(1);
  else
    local scp = string.format("SD_MULTIEXCHANGE_FREEZE_BTN(1, \"%s\", \"%s\")", parent_name, button_name);
    ReserveScript(scp, 0.3);
    btn:SetEnable(0);
  end
end
