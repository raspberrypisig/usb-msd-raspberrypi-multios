from PyQt5 import QtWidgets, uic
import sys
from py3qterm import TerminalWidget
#from py3qterm.procinfo import ProcessInfo
#import os
#print(os.environ['PYTHONPATH'])

print(sys.path)

form_1, base_1 = uic.loadUiType('mainwindow.ui')
form_2, base_2 = uic.loadUiType('choosedisk.ui')
form_3, base_3 = uic.loadUiType('preparedisk.ui')
form_4, base_4 = uic.loadUiType('raspbianlite.ui')

import subprocess

output = subprocess.check_output(['bash', 'diskinfo.sh'])
niceoutput = output.decode("UTF-8")
print(niceoutput)
disks = niceoutput.split('\n')
if len(disks) > 0:
    disks = disks[:-1]    
print(disks)
disks = ["SELECT DISK"] + disks


class TerminalWindow(QtWidgets.QTabWidget):
    def __init__(self):
        super(TerminalWindow, self).__init__()
        #self.proc_info = ProcessInfo()
        self.setTabPosition(QtWidgets.QTabWidget.South)
        #self._new_button = QPushButton(self)
        #self._new_button.setText("New")
        #self._new_button.clicked.connect(self.new_terminal)
        #self.setCornerWidget(self._new_button)
        #self.setTabsClosable(True)
        #self.setMovable(True)
        self.setWindowTitle("Terminal")
        self.resize(800, 600)
        #self._terms = []
        #self.tabCloseRequested[int].connect(self._on_close_request)
        #self.currentChanged[int].connect(self._on_current_changed)
        #QTimer.singleShot(0, self.new_terminal)  # create lazy on idle
        #self.startTimer(100)
        term = TerminalWidget(self)
        self.setCurrentWidget(term)
        term.setFocus()


class RaspbianLite(base_4, form_4):
    def __init__(self):
        super(base_4, self).__init__()
        self.setupUi(self)
        self.openButton.clicked.connect(self.open)

    def open(self):
        options = QtWidgets.QFileDialog.Options()
        #options |= QtWidgets.QFileDialog.DontUseNativeDialog
        filename, _ = QtWidgets.QFileDialog.getOpenFileName(self,"QFileDialog.getOpenFileName()", "","All Files (*);;Python Files (*.py)", options=options)
        if filename:
            self.raspbianlocation.setText(filename)
            t = TerminalWindow()
            t.show()

class PrepareDiskDialog(base_3, form_3):
    def __init__(self, selection):
        super(base_3, self).__init__()
        self.setupUi(self)
        self.selection = selection
        self.usbdisk.setText(selection)

    def accept(self):
        print("accepted")
        selectedDisk = self.selection.split(':')[0]
        print(f"selected disk:{selectedDisk}")
        super().accept()
        r = RaspbianLite()
        r.exec_()


    def reject(self):
        super().reject()
        sys.exit()


class ChooseDiskDialog(base_2, form_2):
    def __init__(self):
        super(base_2, self).__init__()
        self.setupUi(self)
        self.comboBox.addItems(disks)
        self.pushButton.clicked.connect(self.accept)

    def accept(self):
        selection = self.comboBox.currentText()
        if selection != "SELECT DISK":
            super().accept()
            dialog = PrepareDiskDialog(selection)
            dialog.exec_()

    def reject(self):
        super().reject()
        sys.exit()


class Ui(base_1, form_1):
    def __init__(self):
        super(base_1, self).__init__()
        self.setupUi(self)
        self.show() # Show the GUI
        dialog = ChooseDiskDialog()
        dialog.exec_()

app = QtWidgets.QApplication(sys.argv)
window = Ui()
sys.exit(app.exec_())
