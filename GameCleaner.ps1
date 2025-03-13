
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

#!!!CODE MADE BY @realrico ON DISCORD!!!
function Get-InstalledGames {
    $games = @()

    
    $userGamePaths = @(
        "$env:USERPROFILE\Documents\My Games\*",
        "$env:USERPROFILE\Documents\*Games*",
        "$env:USERPROFILE\Downloads\*Games*",
        "$env:USERPROFILE\AppData\Local\*Games*",
        "$env:USERPROFILE\AppData\Roaming\*Games*",
        "$env:USERPROFILE\AppData\Local\Programs\*",
        "$env:USERPROFILE\Desktop\*Games*"
    )

    foreach ($path in $userGamePaths) {
        
        $directories = Get-ChildItem -Path $path -Directory -ErrorAction SilentlyContinue
        foreach ($dir in $directories) {
            if (Test-Path "$($dir.FullName)\game.exe" -or Test-Path "$($dir.FullName)\*.exe") {
                $games += $dir.Name
            }
        }
    }

    
    $gamePaths = @(
        "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\",
        "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\" 
    )

    foreach ($path in $gamePaths) {
        if (Test-Path $path) {
            Get-ChildItem $path | ForEach-Object {
                $displayName = $_.GetValue("DisplayName")
                if ($displayName) {
                    $games += $displayName
                }
            }
        }
    }

    return $games
}


function DeepCleanRust($logBox) {
    $logBox.AppendText("Starting deep clean for Rust...`r`n")

    
    $steamPaths = @(
        "C:\Program Files (x86)\Steam\userdata",
        "C:\Program Files (x86)\Steam\appcache",
        "C:\Program Files (x86)\Steam\config",
        "C:\Program Files (x86)\Steam\logs",
        "C:\Program Files (x86)\Steam\dumps",
        "C:\Program Files (x86)\Steam\temp"
    )

    
    foreach ($dirPath in $steamPaths) {
        if (Test-Path $dirPath) {
            Get-ChildItem -Path $dirPath -Force -ErrorAction SilentlyContinue | ForEach-Object {
                try {
                    if ($_.PSIsContainer) {
                        Remove-Item -Path $_.FullName -Recurse -Force -ErrorAction Stop
                        $logBox.AppendText("[+] Deleted directory: $($_.FullName)`r`n")
                    } else {
                        Remove-Item -Path $_.FullName -Force -ErrorAction Stop
                        $logBox.AppendText("[+] Deleted file: $($_.FullName)`r`n")
                    }
                } catch {
                    $logBox.AppendText("[!] Permission denied for: $($_.FullName)`r`n")
                }
            }
        } else {
            $logBox.AppendText("[-] Directory not found: $dirPath`r`n")
        }
    }

    
    $registryKeys = @(
        "HKCU:\SOFTWARE\Facepunch Studios LTD\Rust",
        "HKCU:\SOFTWARE\Valve\Steam\Users"
    )

    foreach ($regKey in $registryKeys) {
        try {
            Remove-Item -Path $regKey -Recurse -Force -ErrorAction Stop
            $logBox.AppendText("[+] Deleted registry key: $regKey`r`n")
        } catch {
            $logBox.AppendText("[-] Failed to delete registry key: $regKey`r`n")
        }
    }

    
    $depotCachePath = "C:\Program Files (x86)\Steam\depotcache"
    if (Test-Path $depotCachePath) {
        Get-ChildItem -Path $depotCachePath -Force -ErrorAction SilentlyContinue | ForEach-Object {
            try {
                Remove-Item -Path $_.FullName -Force -ErrorAction Stop
                $logBox.AppendText("[+] Deleted file in depotcache: $($_.FullName)`r`n")
            } catch {
                $logBox.AppendText("[!] Permission denied for: $($_.FullName)`r`n")
            }
        }
    } else {
        $logBox.AppendText("[-] Depot cache directory not found: $depotCachePath`r`n")
    }

    
    $specificFile = "C:\Eos_seed.bin"
    if (Test-Path $specificFile) {
        try {
            Remove-Item -Path $specificFile -Force -ErrorAction Stop
            $logBox.AppendText("[+] Deleted: $specificFile`r`n")
        } catch {
            $logBox.AppendText("[-] Failed to delete: $specificFile`r`n")
        }
    } else {
        $logBox.AppendText("[-] File not found: $specificFile`r`n")
    }

    $logBox.AppendText("Deep clean completed for Rust.`r`n")
}


function AntiCheatCleaner {
    param (
        [System.Windows.Forms.TextBox]$logBox
    )

    $logBox.AppendText("Starting Anti-Cheat cleaner...`r`n")

    
    $registryCommands = @(
        'REG DELETE "HKLM\SOFTWARE\Classes\.CETRAINER" /f',
        'REG DELETE "HKLM\SOFTWARE\Classes\.CT" /f',
        'REG DELETE "HKLM\SOFTWARE\Classes\CheatEngine" /f',
        'REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Cheat Engine_is1" /f',
        'REG DELETE "HKCU\Software\Cheat Engine" /f',
        'REG DELETE "HKLM\SYSTEM\CurrentControlSet\Services\BEService" /f',
        'REG DELETE "HKLM\SYSTEM\CurrentControlSet\Services\ucldr_battlegrounds_gl" /f',
        'REG DELETE "HKLM\SYSTEM\CurrentControlSet\Services\xhunter1" /f',
        'REG DELETE "HKLM\SYSTEM\CurrentControlSet\Services\zksvc" /f',
        'REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Riot Vanguard" /f',
        'REG DELETE "HKLM\SYSTEM\CurrentControlSet\Services\vgc" /f',
        'REG DELETE "HKLM\SYSTEM\CurrentControlSet\Services\vgk" /f',
        'REG DELETE "HKLM\SYSTEM\ControlSet001\Services\BEService" /f',
        'REG DELETE "HKLM\SYSTEM\ControlSet001\Services\ucldr_battlegrounds_gl" /f',
        'REG DELETE "HKLM\SYSTEM\ControlSet001\Services\xhunter1" /f',
        'REG DELETE "HKLM\SYSTEM\ControlSet001\Services\zksvc" /f',
        'REG DELETE "HKLM\SOFTWARE\vgk" /f',
        'REG DELETE "HKLM\SOFTWARE\WOW6432Node\EasyAntiCheat_EOS" /f',
        'REG DELETE "HKLM\SYSTEM\ControlSet001\Services\EasyAntiCheat_EOS" /f',
        'REG DELETE "HKLM\SYSTEM\CurrentControlSet\Services\EasyAntiCheat_EOS" /f',
        'REG DELETE "HKLM\SYSTEM\ControlSet001\Services\EasyAntiCheat" /f',
        'REG DELETE "HKLM\SYSTEM\CurrentControlSet\Services\EasyAntiCheat" /f',
        'REG DELETE "HKLM\SYSTEM\ControlSet001\Services\atvi-randgrid_sr" /f',
        'REG DELETE "HKLM\SYSTEM\CurrentControlSet\Services\atvi-randgrid_sr" /f',
        'REG DELETE "HKLM\SOFTWARE\WOW6432Node\EasyAntiCheat" /f',
        'REG DELETE "HKLM\SOFTWARE\WOW6432Node\Valve\Steam\Apps\rust_EAC_EOS" /f',
        'REG DELETE "HKLM\SYSTEM\CurrentControlSet\Services\EAAntiCheat" /f',
        'REG DELETE "HKLM\SYSTEM\CurrentControlSet\Services\EAAntiCheatService" /f',
        'REG DELETE "HKLM\SYSTEM\ControlSet001\Services\EAAntiCheat" /f',
        'REG DELETE "HKLM\SYSTEM\ControlSet001\Services\EAAntiCheatService" /f',
        'REG DELETE "HKLM\SYSTEM\CurrentControlSet\Services\PnkBstrA" /f',
        'REG DELETE "HKLM\SYSTEM\CurrentControlSet\Services\PnkBstrB" /f',
        'REG DELETE "HKLM\SYSTEM\ControlSet001\Services\PnkBstrA" /f',
        'REG DELETE "HKLM\SYSTEM\ControlSet001\Services\PnkBstrB" /f',
        'REG DELETE "HKLM\SOFTWARE\WOW6432Node\Valve\Steam\Apps\1938090" /v "Randgrid_install" /f',
        'REG DELETE "HKLM\SOFTWARE\WOW6432Node\Valve\Steam\Apps\1938090" /v "Randgrid_sdset" /f',
        'REG DELETE "HKLM\SOFTWARE\WOW6432Node\Valve\Steam\Apps\1938090" /v "Randgrid_uninstall" /f'
    )

    
    $removeCommands = @(
        'rmdir /S /Q "C:\Program Files (x86)\EasyAntiCheat"',
        'rmdir /S /Q "C:\Program Files (x86)\EasyAntiCheat_EOS"',
        'rmdir /S /Q "C:\Program Files\Riot Vanguard"',
        'rmdir /S /Q "C:\Program Files (x86)\Common Files\BattlEye"',
        'rmdir /S /Q "C:\Users\%username%\AppData\Local\BattlEye"',
        'rmdir /S /Q "C:\Program Files\Common Files\PUBG"',
        'rmdir /S /Q "C:\Program Files\Common Files\Wellbia.com"',
        'rmdir /S /Q "C:\Users\%username%\AppData\Local\WELLBIA"',
        'rmdir /S /Q "C:\Users\%username%\AppData\LocalLow\Facepunch Studios LTD"',
        'rmdir /S /Q "C:\Users\%username%\AppData\Roaming\EasyAntiCheat"',
        'rmdir /S /Q "C:\Users\%username%\AppData\Local\GameAnalytics"',
        'rmdir /S /Q "C:\Users\%username%\AppData\LocalLow\Facepunch"',
        'rmdir /S /Q "C:\Users\%username%\AppData\Local\DayZ\BattlEye"',
        'rmdir /S /Q "C:\Users\%username%\AppData\Local\FLiNGTrainer"',
        'rmdir /S /Q "C:\Program Files\EA\AC"',
        'rmdir /S /Q "C:\ProgramData\eaanticheat"',
        'rmdir /S /Q "C:\Users\%username%\AppData\Roaming\EA\AC"',
        'rmdir /S /Q "C:\Users\%username%\AppData\Roaming\EAAntiCheat.Installer.Tool"',
        'rmdir /S /Q "C:\Users\%username%\AppData\Local\Activision\bootstrapper"',
        'rmdir /S /Q "C:\Users\%username%\AppData\Local\Activision\Call of Duty"',
        'rmdir /S /Q "C:\Users\%username%\AppData\Roaming\Battle.net\Telemetry"'
    )

    
    $deleteFiles = @(
        'del /F /Q "C:\Windows\xhunter1.sys"',
        'del /F /Q "C:\Windows\xhunters.log"',
        'del /F /Q "C:\Windows\SysWOW64\EasyAntiCheat.exe"',
        'del /F /Q "C:\Windows\System32\drivers\ACE-BASE.sys"',
        'del /F /Q "C:\Windows\system32\drivers\eaanticheat.sys"',
        'del /F /Q "C:\Windows\SysWOW64\PnkBstrB.exe"',
        'del /F /Q "C:\Windows\SysWOW64\PnkBstrA.exe"',
        'del /F /Q "C:\Windows\SysWOW64\pbsvc.exe"',
        'del /F /Q "C:\Windows\System32\eac_usermode_*.dll"'
    )

    
    foreach ($command in $registryCommands) {
        try {
            Invoke-Expression $command
            $logBox.AppendText("[+] Executed: $command`r`n")
        } catch {
            $logBox.AppendText("[-] Failed to execute: $command`r`n")
        }
    }

    
    foreach ($command in $removeCommands) {
        try {
            Invoke-Expression $command
            $logBox.AppendText("[+] Removed: $command`r`n")
        } catch {
            $logBox.AppendText("[-] Failed to remove: $command`r`n")
        }
    }

    foreach ($command in $deleteFiles) {
        try {
            Invoke-Expression $command
            $logBox.AppendText("[+] Deleted: $command`r`n")
        } catch {
            $logBox.AppendText("[-] Failed to delete: $command`r`n")
        }
    }

    $logBox.AppendText("Anti-Cheat cleaning completed.`r`n")
}


function ShowLoginScreen {
    $loginForm = New-Object System.Windows.Forms.Form
    $loginForm.Text = "Login - @realrico on discord"
    $loginForm.Size = New-Object System.Drawing.Size(400, 200)
    $loginForm.FormBorderStyle = "FixedDialog"
    $loginForm.StartPosition = "CenterScreen"
    $loginForm.BackColor = [System.Drawing.Color]::FromArgb(30, 30, 30)

    
    $passwordLabel = New-Object System.Windows.Forms.Label
    $passwordLabel.Text = "Password:"
    $passwordLabel.Location = New-Object System.Drawing.Point(30, 80)
    $passwordLabel.ForeColor = [System.Drawing.Color]::White
    $passwordLabel.Font = New-Object System.Drawing.Font("Arial", 12)
    $loginForm.Controls.Add($passwordLabel)
    
    $passwordTextBox = New-Object System.Windows.Forms.TextBox
    $passwordTextBox.Location = New-Object System.Drawing.Point(150, 80) 
    $passwordTextBox.Size = New-Object System.Drawing.Size(200, 30)
    $passwordTextBox.Font = New-Object System.Drawing.Font("Arial", 12) 
    $passwordTextBox.UseSystemPasswordChar = $true
    $passwordTextBox.MaxLength = 100 
    $passwordTextBox.BackColor = [System.Drawing.Color]::FromArgb(40, 40, 40) 
    $passwordTextBox.ForeColor = [System.Drawing.Color]::White 
    $loginForm.Controls.Add($passwordTextBox)

    
    $loginButton = New-Object System.Windows.Forms.Button
    $loginButton.Text = "Login"
    $loginButton.Location = New-Object System.Drawing.Point(150, 130)
    $loginButton.Size = New-Object System.Drawing.Size(80, 30)
    $loginButton.BackColor = [System.Drawing.Color]::FromArgb(70, 130, 180)
    $loginButton.ForeColor = [System.Drawing.Color]::White
    $loginButton.FlatStyle = "Flat"
    $loginForm.Controls.Add($loginButton)

    
    $loginButton.Add_Click({
        $password = $passwordTextBox.Text

        
        if ($password -eq "rico") {
            $loginForm.DialogResult = [System.Windows.Forms.DialogResult]::OK
            $loginForm.Close()
        } else {
            [System.Windows.Forms.MessageBox]::Show("Invalid password.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
        }
    })

    
    $loginForm.ShowDialog() | Out-Null

    return $loginForm.DialogResult -eq [System.Windows.Forms.DialogResult]::OK
}


function ShowMainUI {
    
    $form = New-Object System.Windows.Forms.Form
    $form.Text = "Rico Cleaner - @realrico on discord"
    $form.Size = New-Object System.Drawing.Size(500, 450)
    $form.FormBorderStyle = "FixedDialog"
    $form.StartPosition = "CenterScreen"
    $form.BackColor = [System.Drawing.Color]::FromArgb(25, 25, 25)

    
    $header = New-Object System.Windows.Forms.Label
    $header.Text = "Select a Game to Clean"
    $header.Location = New-Object System.Drawing.Point(20, 20)
    $header.Size = New-Object System.Drawing.Size(450, 30)
    $header.ForeColor = [System.Drawing.Color]::White
    $header.Font = New-Object System.Drawing.Font("Arial", 14, [System.Drawing.FontStyle]::Bold)
    $form.Controls.Add($header)

    
    $listBox = New-Object System.Windows.Forms.ListBox
    $listBox.Size = New-Object System.Drawing.Size(450, 200)
    $listBox.Location = New-Object System.Drawing.Point(20, 60)
    $listBox.BackColor = [System.Drawing.Color]::FromArgb(30, 30, 30)
    $listBox.ForeColor = [System.Drawing.Color]::White
    $listBox.Font = New-Object System.Drawing.Font("Consolas", 10)
    $form.Controls.Add($listBox)

    
    $cleanButton = New-Object System.Windows.Forms.Button
    $cleanButton.Text = "Clean Selected Game"
    $cleanButton.Location = New-Object System.Drawing.Point(20, 280)
    $cleanButton.Size = New-Object System.Drawing.Size(200, 30)
    $cleanButton.BackColor = [System.Drawing.Color]::FromArgb(70, 130, 180)
    $cleanButton.ForeColor = [System.Drawing.Color]::White
    $cleanButton.Enabled = $false
    $cleanButton.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Bold)
    $form.Controls.Add($cleanButton)

    
    $antiCheatButton = New-Object System.Windows.Forms.Button
    $antiCheatButton.Text = "Anti Cheat Cleaner"
    $antiCheatButton.Location = New-Object System.Drawing.Point(250, 280)
    $antiCheatButton.Size = New-Object System.Drawing.Size(200, 30)
    $antiCheatButton.BackColor = [System.Drawing.Color]::FromArgb(70, 130, 180)
    $antiCheatButton.ForeColor = [System.Drawing.Color]::White
    $form.Controls.Add($antiCheatButton)

    
    $logBox = New-Object System.Windows.Forms.TextBox
    $logBox.Multiline = $true
    $logBox.ScrollBars = "Vertical"
    $logBox.ReadOnly = $true
    $logBox.Size = New-Object System.Drawing.Size(450, 120)
    $logBox.Location = New-Object System.Drawing.Point(20, 320)
    $logBox.BackColor = [System.Drawing.Color]::FromArgb(30, 30, 30)
    $logBox.ForeColor = [System.Drawing.Color]::White
    $logBox.Font = New-Object System.Drawing.Font("Consolas", 10)
    $form.Controls.Add($logBox)

    
    $installedGames = Get-InstalledGames
    if ($installedGames.Count -eq 0) {
        $logBox.AppendText("No games found.`r`n")
    } else {
        foreach ($game in $installedGames) {
            $listBox.Items.Add($game)
        }
    }

    
    $listBox.Add_SelectedIndexChanged({
        $cleanButton.Enabled = $listBox.SelectedItem -ne $null
    })

    
    $cleanButton.Add_Click({
        $selectedGame = $listBox.SelectedItem
        if ($selectedGame -eq "Rust") {
            DeepCleanRust $logBox
        } else {
            $logBox.AppendText("Cleaning function for $selectedGame not implemented yet.`r`n")
        }
    })

    
    $antiCheatButton.Add_Click({
        AntiCheatCleaner $logBox
    })

    
    $form.ShowDialog() | Out-Null
}


if (ShowLoginScreen) {
    ShowMainUI
}


#!!!CODE MADE BY @realrico ON DISCORD!!!
