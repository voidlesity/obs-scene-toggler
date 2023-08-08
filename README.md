# OBS Toggle Scene Plugin

## **Description**:
This plugin allows you to toggle between the currently active scene and a predefined scene in OBS using a hotkey.

## **Installation**:

1. Copy the provided script (provided above) and save it as `scene_toggler.lua` on your computer.
2. Open OBS Studio.
3. Navigate to `Tools` > `Scripts`.
4. Click on the `+` (Add) button and select the `scene_toggler.lua` script you saved in step 1.
5. The script should now appear in the list of scripts within OBS.

## **Configuration**:

1. Once the script is loaded in OBS, you should see a property named "Select Scene" in the script's properties pane.
2. Use the dropdown list to select the scene you wish to toggle to.
3. Close the scripts window.

## **Usage**:

1. Navigate to `File` > `Settings` > `Hotkeys`.
2. Scroll down to find "Toggle Scene Hotkey".
3. Set your desired hotkey for the toggle functionality.
4. Click "OK" to save your hotkey setting.
5. Now, whenever you press the hotkey, it will toggle between the currently active scene and the predefined scene you selected in the configuration step.

## **Troubleshooting**:

- Ensure the `scene_toggler.lua` script is loaded in the Scripts section.
- If the scene doesn't switch, double-check that the scene name in the dropdown list is correct and exists in your OBS.
- Make sure the hotkey you set isn't already in use by another function in OBS.
