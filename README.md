![icon](https://github.com/LucasArusiewicz/Easy-Interface/assets/13992129/79987f8a-a253-4784-ad8c-46287f3ef6b6)
# Easy-Interface


Interface validation plugin for GDScript with graphical editor on Godot 4.

## Motivation
Have a simple and quick way to implement interfaces in GDScript.

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/J3J8Q28AR)

## Installation
### Asset Library
1. In Godot, open the `AssetLib` tab.
2. Search for and select "Easy Interface".
3. Download then install the plugin (be sure to only select the `easy_interfaces` directory).
4. Enable the plugin inside `Project/Project Setttings/Plugins`.

### Github Main (Latest)
1. Download the latest [`main branch`](https://github.com/LucasArusiewicz/Easy-Interface/archive/refs/heads/main.zip).
2. Extract the zip file and move the `addons/easy_interface` directory into project's root location.
3. Enable the plugin inside `Project/Project Setttings/Plugins`.

For more help,
see [Godot's official documentation](https://docs.godotengine.org/en/stable/tutorials/plugins/editor/installing_plugins.html)


## How to use

### Step by step:
- step 1: After installing and enabling the plugin, go to the "Easy Interface" tab.
- step 2: Create and edit a new interface using the "new interface" button, by default there are two example interfaces.
  
  **Don't forget to save, the plugin still doesn't save automatically**
- step 3: Go to the script that you want to implement the interface and add a constant named INTERFACES ([check the demo script](https://github.com/LucasArusiewicz/Easy-Interface/blob/main/demo.gd)).
- step 4: Go back to the "Easy Interface" tab and click on the "Validate" button. This step is temporary, validation and automatic saving are still under development.

Try commenting the properties, functions and signals in the demo script and performing validations to see the result


### Toolbar

Actions:
- Create new interface
  Creates a new card to represent an interface.
  
  ![new interface](https://github.com/LucasArusiewicz/Easy-Interface/assets/13992129/7f91a58e-7613-40b2-94c9-ce8cb9726701)

- Validate
  Checks the project scripts and validates according to the configured interfaces.
  
  ![validate](https://github.com/LucasArusiewicz/Easy-Interface/assets/13992129/10d23ef0-5204-4144-9329-b90a700838ec)
  
- Save
  Saves the created interfaces.
  
- Change canvas size
  It is possible to increase the size of the canvas where the interfaces are created.


## What to expect from the future?
I intend to update the plugin as I use it, any suggestions and changes that make sense would be welcome in the project.

Currently I described some ideas I have for the next updates, you can check them in the [issues tab](https://github.com/LucasArusiewicz/Easy-Interface/issues) or [project tab](https://github.com/users/LucasArusiewicz/projects/1).
