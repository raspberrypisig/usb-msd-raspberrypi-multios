#!/usr/bin/env python
# -*- coding: utf-8 -*-
import os
import sys

import sys

from qtpy.QtWidgets import QApplication, QWidget, QTabWidget, QPushButton
from qtpy.QtCore import QTimer, QRect, Qt, Signal
from qtpy.QtGui import (QClipboard, QPainter, QFont, QBrush, QColor,
                        QPen, QPixmap, QImage, QContextMenuEvent)

from py3qterm import TerminalWidget
from py3qterm.procinfo import ProcessInfo


class TabbedTerminal(QTabWidget):

    def __init__(self, parent=None):
        super(TabbedTerminal, self).__init__(parent)        
        self._terms = []
        self.new_terminal()
        self._terms[0].send('pwd\n'.encode())

    def _on_close_request(self, idx):
        term = self.widget(idx)
        term.stop()

    def _on_current_changed(self, idx):
        term = self.widget(idx)
        self._update_title(term)

    def new_terminal(self):
        term = TerminalWidget(parent=self)
        term.session_closed.connect(self._on_session_closed)
        self.addTab(term, "Moo Terminal")
        self._terms.append(term)
        self.setCurrentWidget(term)
        term.setFocus()

    def timerEvent(self, event):
        self._update_title(self.currentWidget())

    def _update_title(self, term):
        if term is None:
            self.setWindowTitle("Terminal")
            return
        idx = self.indexOf(term)
        pid = term.pid()
        self.proc_info.update()
        child_pids = [pid] + self.proc_info.all_children(pid)
        for pid in reversed(child_pids):
            cwd = self.proc_info.cwd(pid)
            if cwd:
                break
        try:
            cmd = self.proc_info.commands[pid]
            title = "%s: %s" % (os.path.basename(cwd), cmd)
        except:
            title = "Terminal"
        self.setTabText(idx, title)
        self.setWindowTitle(title)

    def _on_session_closed(self):
        term = self.sender()
        try:
            self._terms.remove(term)
        except:
            pass
        self.removeTab(self.indexOf(term))
        widget = self.currentWidget()
        if widget:
            widget.setFocus()
        if self.count() == 0:
            self.new_terminal()


if __name__ == "__main__":
    app = QApplication(sys.argv)
    win = TabbedTerminal()
    win.resize(800,600)
    win.show() 
    app.exec_()
