# Builds a .qmod file for loading with QuestPatcher
$NDKPath = Get-Content $PSScriptRoot/ndkpath.txt

$buildScript = "$NDKPath/build/ndk-build"
if (-not ($PSVersionTable.PSEdition -eq "Core")) {
    $buildScript += ".cmd"
}

$ArchiveName = "phrogmonke_v1.0.0.qmod"
$TempArchiveName = "phrogmonke_v1.0.0.qmod.zip"

& $buildScript NDK_PROJECT_PATH=$PSScriptRoot APP_BUILD_SCRIPT=$PSScriptRoot/Android.mk NDK_APPLICATION_MK=$PSScriptRoot/Application.mk
Compress-Archive -Path "./libs/arm64-v8a/libphrogmonke.so", "./libs/arm64-v8a/libbeatsaber-hook_1_3_5.so", "./mod.json", "./coverImage.jpg" -DestinationPath $TempArchiveName -Force
Move-Item $TempArchiveName $ArchiveName -Force