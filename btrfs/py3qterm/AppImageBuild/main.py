from PyQt5 import QtWidgets, uic
import sys

form_1, base_1 = uic.loadUiType('mainwindow.ui')
form_2, base_2 = uic.loadUiType('choosedisk.ui')

import subprocess

output = subprocess.check_output(['bash', 'diskinfo.sh'])
niceoutput = output.decode("UTF-8")
print(niceoutput)
disks = niceoutput.split('\n')
print(disks)

class ChooseDiskDialog(base_2, form_2):
    def __init__(self):
        super(base_2, self).__init__()
        self.setupUi(self)
        self.comboBox.addItems(disks)


class Ui(base_1, form_1):
    def __init__(self):
        super(base_1, self).__init__()
        self.setupUi(self)
        self.show() # Show the GUI
        dialog = ChooseDiskDialog()
        dialog.exec_()

app = QtWidgets.QApplication(sys.argv)
window = Ui()
app.exec_()
