$wav = "https://github.com/dyl4nz/Functions/blob/main/powershell/Play-WAV/Moan.wav"
$w = -join($wav,"?raw=true", "?dl=1")
iwr $w -O $env:TMP\s.wav
function Play-WAV {
    $PlayWav = New-Object System.Media.SoundPlayer
    $PlayWav.SoundLocation = "$env:TMP\s.wav"
    $PlayWav.playsync()
}
Play-WAV
