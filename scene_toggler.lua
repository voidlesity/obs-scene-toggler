obs = obslua

last_scene = ""
toggled_scene_name = ""
hotkey_id = obs.OBS_INVALID_HOTKEY_ID
hotkey_pressed = false

function switch_scene(scene_name)
    local source = obs.obs_get_source_by_name(scene_name)
    if source ~= nil then
        obs.obs_frontend_set_current_scene(source)
        obs.obs_source_release(source)
    end
end

function toggle_scene(pressed)
    if pressed then
        if not hotkey_pressed then
            hotkey_pressed = true
            local current_scene = obs.obs_frontend_get_current_scene()

            if current_scene ~= nil then
                local scene_name = obs.obs_source_get_name(current_scene)
                obs.obs_source_release(current_scene)

                if scene_name ~= toggled_scene_name then
                    last_scene = scene_name
                    switch_scene(toggled_scene_name)
                else
                    switch_scene(last_scene)
                end
            end
        end
    else
        hotkey_pressed = false
    end
end

function script_description()
    return "Toggle between the currently active scene and a predefined scene."
end

function script_properties()
    local props = obs.obs_properties_create()

    -- Dropdown for scene selection
    local p = obs.obs_properties_add_list(props, "scene_list", "Select Scene", obs.OBS_COMBO_TYPE_LIST, obs.OBS_COMBO_FORMAT_STRING)
    local scenes = obs.obs_frontend_get_scenes()
    if scenes then
        for _, scene in ipairs(scenes) do
            local scene_name = obs.obs_source_get_name(scene)
            obs.obs_property_list_add_string(p, scene_name, scene_name)
            obs.obs_source_release(scene)
        end
    end

    return props
end

function script_update(settings)
    toggled_scene_name = obs.obs_data_get_string(settings, "scene_list")
    last_scene = obs.obs_data_get_string(settings, "last_scene")
end

function script_save(settings)
    obs.obs_data_set_string(settings, "last_scene", last_scene)
    
    local hotkey_save_data = obs.obs_hotkey_save(hotkey_id)
    if hotkey_save_data then
        local wrapper = obs.obs_data_create()
        obs.obs_data_set_array(wrapper, "hotkey_data", hotkey_save_data)
        local json_str = obs.obs_data_get_json(wrapper)
        obs.obs_data_set_string(settings, "toggle_scene_hotkey_data", json_str)
        obs.obs_data_release(wrapper)
        obs.obs_data_array_release(hotkey_save_data)
    end
end

function script_load(settings)
    hotkey_id = obs.obs_hotkey_register_frontend("toggle_scene_hotkey", "Toggle Scene Hotkey", toggle_scene)
    
    local json_str = obs.obs_data_get_string(settings, "toggle_scene_hotkey_data")
    if json_str and json_str ~= "" then
        local wrapper = obs.obs_data_create_from_json(json_str)
        local hotkey_save_data = obs.obs_data_get_array(wrapper, "hotkey_data")
        obs.obs_hotkey_load(hotkey_id, hotkey_save_data)
        obs.obs_data_array_release(hotkey_save_data)
        obs.obs_data_release(wrapper)
    end
end