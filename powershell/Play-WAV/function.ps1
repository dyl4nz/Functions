#============================================================================================================
# ▐ ▄       ▄▄▄▄▄   ·▄▄▄▄   ▄· ▄▌·▄▄▄▄•
#•█▌▐█▪     •██     ██▪ ██ ▐█▪██▌▪▀·.█▌
#▐█▐▐▌ ▄█▀▄  ▐█.▪   ▐█· ▐█▌▐█▌▐█▪▄█▀▀▀•
#██▐█▌▐█▌.▐▌ ▐█▌·   ██. ██  ▐█▀·.█▌▪▄█▀
#▀▀ █▪ ▀█▄▀▪ ▀▀▀  ▀ ▀▀▀▀▀•   ▀ • ·▀▀▀ •
#============================================================================================================
#Credits to IAmJakoby who created this function, i do not take credit for any development of this
#I have taken his function from existing codes and simplified it with a step by step explanation
#============================================================================================================


#============================================================================================================
# Creates a variable containing the link 
$wav = "https://github.com/dyl4nz/Functions/blob/main/powershell/Play-WAV/Moan.wav"
#============================================================================================================
# Modify the download link:

# Makes a new variable called "$w" which joins the link and two extentions which are "?raw-true" and "?dl=1"
# Adding "?raw=true" forces the link to be considered as raw info
# Adding "?dl=1" forces the link to be downloaded instead of displayed 
$w = -join($wav,"?raw=true", "?dl=1")
#============================================================================================================
iwr $w -O $env:TMP\s.wav
# [iwr] is short for "Invoke-WebRequest", It is used to send an HTTP or HTTPS request to a specified URL and retrieve the content.
#
# [$w] is the variable containing the processed link, the HTTP/S request will be sent to this link to retrieve and download the file
#
#[-O] is a parameter of the Invoke-WebRequest function and is used to specify the output or in our case where the file is saved
#
# [$env:TMP\s.wav] is specifying that the file will be stored in the devices temporary file directory, and will be called "s.wav"
#============================================================================================================
# Define the Play-WAV function
function Play-WAV {
    $PlayWav = New-Object System.Media.SoundPlayer
    $PlayWav.SoundLocation = "$env:TMP\s.wav"
    $PlayWav.playsync()
}
# "function Play-WAV { }" defines anything in between the curled brackets to be classified as the function "Play-WAV"
#
# "$PlayWav = New-Object System.Media.SoundPlayer" Creates a new instance of the "System.Media.SoundPlayer" class which is used to play sound and assigns it to the variable $PlayWav.
#
# "$PlayWav.SoundLocation = "$env:TMP\s.wav"" creates a property of "PlayWav" called "SoundLocation" and assigns it to the file that has been downloaded in the temp folder
#
# "$PlayWav.playsync()" Plays the sound file synchronously, waiting for it to finish.
#============================================================================================================
# Play the WAV file by executing the created funtion
Play-WAV
