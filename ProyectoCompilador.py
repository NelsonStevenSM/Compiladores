from PyQt5 import *
from PyQt5.QtGui import *
from PyQt5.QtWidgets import *
from PyQt5.QtCore import *
import subprocess
import sys, os, re


class Window(QWidget):
    def __init__(self):
        super().__init__()

        self.title = "Compiler SHS"
        self.top = 100
        self.left = 100
        self.width = 400
        self.height = 650

        self.setWindowIcon(QIcon("./Images/logo.png"))

        
        self.Widget()
        self.InitWindow()

    def Widget(self):

        # La parte Horizontal - Cabecera

        self.layoutT = QVBoxLayout()
        labelH = QLabel(self)
        labelH.setText("Input Text")
        labelH.setStyleSheet("font:bold 14pt\"Arial\";")

        self.textH = QTextEdit(self)

        self.layoutT.addWidget(labelH)
        self.layoutT.addWidget(self.textH)
    
        # Parte Vertical - foot

        self.layoutVB = QVBoxLayout()
        self.layoutVB.addStretch()

        self.layoutB = QHBoxLayout()

        layoutBR = QVBoxLayout()

        logo = QLabel(self)
        logo.setPixmap(QPixmap('./Images/logo.png'))
    
        layoutBR.addWidget(logo)
        
        self.layoutBC = QVBoxLayout()
        self.layoutBC.addSpacing(10)

        result = QLabel(self)
        result.setText("Result:")
        result.setStyleSheet("font:bold 14pt\"Arial\";")
        
        self.cadena = QLabel(self)
        self.cadena.setText("")

        self.layoutBC.addWidget(result)
        self.layoutBC.addWidget(self.cadena)

        self.layoutB.addLayout(layoutBR)
        self.layoutB.addLayout(self.layoutBC)

        self.BtnRun = QPushButton("Run", self)
        self.BtnRun.clicked.connect(self.Input)
        BtnClear = QPushButton("Clear", self)
        BtnClear.clicked.connect(self.Clear)
        
        # Parte Inferior derecha

        self.layoutWidV = QVBoxLayout()

        self.layoutWidV.addWidget(self.BtnRun)
        self.layoutWidV.addWidget(BtnClear)


        self.layoutB.addLayout(self.layoutWidV)

        self.layoutVB.addLayout(self.layoutB)

    def Input(self):

        text = self.textH.toPlainText()
        try:

            filename = 'CPy.txt'
            f = open(filename, "w")
            f.write(text)
            f.close()
            command = './a.out < '+filename

            return_value = subprocess.call(command, shell=True)

     #       if return_value == 0:
 #               self.cadena.setText("Valid string")
  #              self.cadena.setStyleSheet("font:italic 12pt\"Arial\";color:green;")
   #             self.layoutBC.addWidget(self.cadena)
    #        else:
      #          self.cadena.setText("Invalid string")
       #         self.cadena.setStyleSheet("font:italic 12pt\"Arial\";color:red;")
        #        self.layoutBC.addWidget(self.cadena)

        except IOError:
            print("Problem read file : "+ filename)
       

    def Clear(self):
        self.cadena.clear()
        self.textH.clear()
        self.BtnRun.setEnabled(True)

    def InitWindow(self):

        windowP = QVBoxLayout()
        windowP.addLayout(self.layoutT,3)
        self.layoutVB.addStretch(2)
        windowP.addLayout(self.layoutVB,0)
        

        self.setLayout(windowP)
        self.setWindowTitle(self.title)
        self.setGeometry(self.top, self.left, self.width, self.height)
        self.show()


if __name__ == "__main__":
    App = QApplication(sys.argv)
    window = Window()
    sys.exit(App.exec())


