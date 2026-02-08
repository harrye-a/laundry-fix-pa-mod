
function Begin()
    Object.SetProperty( "BeepSpeed", 1.2 );
    lastBeep = 0;
end

function Update( timePassed )
    local beepSpeed = tonumber(Object.GetProperty("BeepSpeed"));
    
    lastBeep = lastBeep + timePassed;
    
    if lastBeep >= beepSpeed then
        Object.Sound("__FoodFamily", "InfirmaryDefibNormal");
        lastBeep = lastBeep - beepSpeed;
    end
end