#!/usr/bin/env python

import os
import sys
import argparse

parser = argparse.ArgumentParser(description='make python executable utility')
parser.add_argument('name', help='name of python file')
parser.add_argument('-s', '--subl', action='store_true', help='open with Sublime Text 3')
parser.add_argument('-e', '--emacs', action='store_true', help='open with emacs')
parser.add_argument('--tdma', action='store_true', help='import TDMA solver')
parser.add_argument('--hdf5', action='store_true', help='import h5py')
parser.add_argument('--os', action='store_true', help='import os')
parser.add_argument('--sys', action='store_true', help='import sys')
parser.add_argument('--hidespines', action='store_true', help='import hidespines')
parser.add_argument('--timer', action='store_true', help='import timer')
parser.add_argument('--texTools', action='store_true', help='import texTools')
parser.add_argument('-i', nargs='+', default=[], help='import custom package')
parser.add_argument('-f', nargs='+', default=[], help='import all from package')
args = parser.parse_args()

name = args.name + '.py'
sublime = args.subl
emacs = args.emacs
tdma = args.tdma
osBool = args.os
sysBool = args.sys
hidespines = args.hidespines
imp = [] + args.i
fr = [] + args.f

# make python file
if (os.path.isfile(name)):
    print('File exists')
    sys.exit()
else:
    f = open(name, 'w')

# set executable
os.system('chmod 700 %s' % (name))

# add shebang and import statements
f.write('#!/usr/bin/env python3\n\nimport numpy as np\nimport matplotlib.pyplot as plt\n')

# add hdf5
if (args.hdf5):
    f.write('\nimport h5py\n')

# add tdma
if (tdma):
    f.write('\nfrom TDMA import *\n')

# add os
if (osBool):
    f.write('\nimport os\n')

# add sys
if (sysBool):
    f.write('\nimport sys\n')

# add hidespines
if (hidespines):
    f.write('\nfrom hidespines import *\n')

# timer 
if (args.timer):
    f.write('\nfrom Timer import *\n')

# texTools
if (args.texTools):
    f.write('\nimport texTools as tex\n')
    
# add custom imports
for i in range(len(imp)):
    f.write('\nimport ' + args.i[i])

if (len(imp) > 0):
	f.write('\n')

# add from custom imports
for i in range(len(fr)):
    f.write('\nfrom ' + args.f[i] + ' import *')

if (len(fr) > 0):
	f.write('\n')

# add extra line
f.write('\n')

f.close()

# open with sublime 
if (sublime):
    os.system('subl %s' % (name))

# open with emacs 
if (emacs):
    os.system('emacs %s &' % (name))

