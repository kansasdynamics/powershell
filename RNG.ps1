Function Get-RandomNumber {
    Function Convert-Values {
        try {
            $form.Tag = $tb_Input.Text;
            $form.Tag = [int32]$form.Tag;
            $RandomNumber = Get-Random -Minimum 1 -Maximum $form.Tag
            $RandomNumber.ToString($RandomNumber)
            $tb_Output.ForeColor = 'Gray'
            $tb_Output.Text = $RandomNumber
        }
        catch {
            $tb_Output.ForeColor = 'Red'
            $tb_Output.Text = 'Please enter a number.'
        }
    }

    Add-Type -AssemblyName System.Drawing
    Add-Type -AssemblyName System.Windows.Forms

    $form = New-Object System.Windows.Forms.Form
    $form.Text = 'Random Number'
    $form.FormBorderStyle = 'FixedSingle'
    $form.StartPosition = 'CenterScreen'
    $form.AutoSizeMode = 'GrowAndShrink'
    $form.Topmost = $true

    $lbl_Input = New-Object System.Windows.Forms.Label
    $lbl_Input.Location = New-Object System.Drawing.Size(10, 10)
    $lbl_Input.Size = New-Object System.Drawing.Size(80, 20)
    $lbl_Input.AutoSize = $true
    $lbl_Input.Text = 'Enter Maximum Number'

    $lbl_Output = New-Object System.Windows.Forms.Label
    $lbl_Output.Location = New-Object System.Drawing.Size(10, 60)
    $lbl_Output.Size = New-Object System.Drawing.Size(80, 20)
    $lbl_Output.AutoSize = $true
    $lbl_Output.Text = 'Result'

    $tb_InputYLoc = $lbl_Input.Height + $lbl_Input.Location.Y

    $tb_Input = New-Object System.Windows.Forms.TextBox
    $tb_Input.Location = New-Object System.Drawing.Size(10, $tb_InputYLoc)
    $tb_Input.Size = New-Object System.Drawing.Size(180, 150)
    $tb_Input.AcceptsReturn = $true
    $tb_Input.AcceptsTab = $true
    $tb_Input.Multiline = $false

    $tb_OutputYLoc = $lbl_Output.Height + $lbl_Output.Location.Y

    $tb_Output = New-Object System.Windows.Forms.RichTextBox
    $tb_Output.Location = New-Object System.Drawing.Size(10, $tb_OutputYLoc)
    $tb_Output.Size = New-Object System.Drawing.Size(180, 20)
    $tb_Output.AcceptsTab = $true
    $tb_Output.Multiline = $false
    $tb_Output.Enabled = $false

    $form = New-Object System.Windows.Forms.Form
    $form.Text = 'RNG'
    $form.FormBorderStyle = 'FixedSingle'
    $form.StartPosition = 'CenterScreen'
    $form.AutoSizeMode = 'GrowAndShrink'
    $form.Topmost = $true
    
    $gb_Buttons = New-Object System.Windows.Forms.GroupBox

    $btn_Enter = New-Object System.Windows.Forms.Button
    $btn_Enter.Size = New-Object System.Drawing.Size(55, 25)
    $btn_Enter.Text = 'Enter'
    $btn_Enter.Add_Click({Convert-Values})

    $btn_Clear = New-Object System.Windows.Forms.Button
    $btn_Clear.Size = New-Object System.Drawing.Size(55, 25)
    $btn_Clear.Text = 'Clear'
    $btn_Clear.Add_Click({$tb_Output.Text = $null; $tb_Input.Text = $null})

    $form.AcceptButton = $btn_Enter

    $gb_ButtonsYSize = $btn_Clear.Height + 20
    $gb_Buttons.Height = $gb_ButtonsYSize
    $formHeight = ($lbl_Input.Height + $tb_Input.Height) + ($lbl_Output.Height + $tb_Output.Height) + $gb_Buttons.Height + 60
    $form.Width = '220'
    $gb_ButtonsXSize = $tb_Input.Width
    $gb_ButtonsYLoc = $lbl_Output.Height + $lbl_Output.Location.Y + $lbl_Output.Height
    $gb_Buttons.Location = "10,$gb_ButtonsYLoc"
    $form.Height = $formHeight + 5
    $gb_Buttons.Width = $gb_ButtonsXSize
    $btn_EnterY = $gb_Buttons.Height - $btn_Enter.Height - $gb_Buttons.Margin.Top - ($btn_Enter.Margin.Top) - 2
    $btn_Enter.Location = New-Object System.Drawing.Size(15, $btn_EnterY)
    $btn_ClearX = $gb_Buttons.Width - $btn_Clear.Width - 15
    $btn_ClearY = $gb_Buttons.Height - $btn_Clear.Height - $gb_Buttons.Margin.Top - ($btn_Clear.Margin.Top) - 2
    $btn_Clear.Location = New-Object System.Drawing.Size($btn_ClearX, $btn_ClearY)

    $gb_Buttons.controls.AddRange(@($btn_Clear, $btn_Enter))
    $form.Controls.AddRange(@($lbl_Input, $tb_Input, $lbl_Output, $tb_Output, $gb_Buttons))
    $form.Add_Shown({$form.Activate()})
    $form.ShowDialog() > $null
}
Get-RandomNumber