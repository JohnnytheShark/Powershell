# Basic Form and Controls

## Form: The main window of your application.

New-Object System.Windows.Forms.Form

## Label: Displays text.

New-Object System.Windows.Forms.Label

## TextBox: Allows user input.

New-Object System.Windows.Forms.TextBox

## Button: Executes an action when clicked.

New-Object System.Windows.Forms.Button

## CheckBox: Allows user to select or deselect an option.

New-Object System.Windows.Forms.CheckBox

## RadioButton: Allows user to select one option from a group.

New-Object System.Windows.Forms.RadioButton

## ComboBox: Drop-down list of options.

New-Object System.Windows.Forms.ComboBox

## ListBox: List of selectable items.

New-Object System.Windows.Forms.ListBox

## ProgressBar: Displays progress of a task.

New-Object System.Windows.Forms.ProgressBar

## PictureBox: Displays an image.

New-Object System.Windows.Forms.PictureBox

# Positioning and Sizing

## Location: Sets the position of a control.

$control.Location = New-Object System.Drawing.Point(x, y)

## Size: Sets the size of a control.

$control.Size = New-Object System.Drawing.Size(width, height)

# Events

## Add_Click: Adds a click event to a button.

$button.Add_Click({ $scriptBlock })

## Add_SelectedIndexChanged: Adds an event to a ComboBox when the selected item changes.

$comboBox.Add_SelectedIndexChanged({ $scriptBlock })

# Displaying the Form

## ShowDialog: Displays the form as a modal dialog box.

$form.ShowDialog()

## Show: Displays the form.

$form.Show()
