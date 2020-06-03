let project = new Project('Phantom');
project.addAssets('Assets/**');
project.addShaders('Shaders/**');
project.addSources('Sources');
project.addLibrary('zui');
project.targetOptions.android.package = 'com.example.aaditya.app';
project.targetOptions.android.permissions = [
    'com.android.alarm.permission.SET_ALARM', 
    'android.permission.READ_CALENDAR', 
    'android.permission.WRITE_CALENDAR'];
project.targetOptions.android.installLocation = "auto";
// project.targetOptions.html5.disableContextMenu = true;
// project.targetOptions.html5.canvasId = 'my-custom-canvas-id';
// project.targetOptions.html5.scriptName = 'my-custom-script-name';
// project.targetOptions.html5.webgl = false;
resolve(project);
