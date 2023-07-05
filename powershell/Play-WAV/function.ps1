#============================================================================================================
#Credits to IAmJakoby who created this function, i do not take credit for this
#I have taken his function from existing codes and simplified it with a step by step explanation
#============================================================================================================
# Download the WAV file from a GitHub link
#When adding the link, add the link and add "?raw=true" to the end
$wav = "https://github.com/dyl4nz/powershell/blob/main/sound_fx/Anime%20Moan%20Sound%20Effect.wav?raw=true"

# Modify the download link
$w = -join($wav, "?dl=1")
iwr $w -O $env:TMP\s.wav

# Define the Play-WAV function
function Play-WAV {
    $PlayWav = New-Object System.Media.SoundPlayer
    $PlayWav.SoundLocation = "$env:TMP\s.wav"
    $PlayWav.playsync()
}

# Play the WAV file
Play-WAV
