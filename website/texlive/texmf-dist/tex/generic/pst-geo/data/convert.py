from string import *

input=open('cities.data','r')
output=open('cities.tex','w')
nZeile=["% (c) Herbert Voss <voss _at_ perce.de\n"]
def umlaut(instr):
    return translate(instr, maketrans('äöü ÄÖÜß', 'aou_AOUs'))
def process(zeile):
    stadt=rstrip(zeile[0:23])
    Kstadt=umlaut(stadt)
    Land=rstrip(zeile[24:56])
    if (Land=="Deutschland"):
	Land = "Germany"
    elif (Land[0:3]=="USA"):
	Land ="USA"
    elif (find(Land,"Australien")>-1):
	Land ="Australia"
    elif (find(Land,"Italien")>-1):
	Land ="Italy"
    elif (find(Land,"Frankreich")>-1):
	Land ="France"
    elif (find(Land,"nemark")>0):
	Land ="Denmark"
    elif (find(Land,"britannien")>0):
	Land ="GreatBritain"
    elif (find(Land,"Elfenbein")>-1):
	Land ="IvoryCoast"
    elif (find(Land,"Emirate")>-1):
	Land ="Emirates"
    elif (find(Land,"rkei")>-1):
	Land ="Turkey"
    elif (find(Land,"thiopien")>-1):
	Land ="Ethiopia"
    elif (find(Land,"gypten")>-1):
	Land ="Egypt"
    elif (find(Land,"sterreich")>-1):
	Land ="Austria"
    elif (find(Land,"dafrika")>-1):
	Land ="SouthAfrica"
    Grad=zeile[57:59]
    Minuten=zeile[61:63]
    Breitengrad=float(Grad) + float(Minuten)/60.0
    NS=zeile[65]
    if (NS=="S"):
	Breitengrad = -Breitengrad
    Grad=zeile[68:71]
    Minuten=zeile[73:75]
    Laengengrad=float(Grad) + float(Minuten)/60.0
    OW=zeile[77]
    if (OW=="W"):
	Laengengrad = -Laengengrad
    if (Kstadt!=stadt):
	Zeile="\\mapput("+str(Laengengrad)+","+str(Breitengrad)+")["+Kstadt+"]{"+stadt+"}["+Land+"]\n"
#	Zeile="\\mapput[90]("+str(Laengengrad)+","+str(Breitengrad)+")["+Kstadt+"]{"+stadt+"}["+Land+"]\n"
    else:
	Zeile="\\mapput("+str(Laengengrad)+","+str(Breitengrad)+"){"+stadt+"}["+Land+"]\n"
#	Zeile="\\mapput[90]("+str(Laengengrad)+","+str(Breitengrad)+"){"+stadt+"}["+Land+"]\n"
    return Zeile
for line in input.readlines():
    Zeile = process(line)
    if (find(Zeile,"Italy")>0):	# take Italy from the original file
	Zeile = "% "+Zeile
    nZeile.append(Zeile)
input=open('villesItalia.tex','r')
nZeile.append("% Italy\n")
for line in input.readlines():
    if (find(line,"endinput")<0):
	Zeile=line[0:len(line)-1]+"[Italy]\n"
	nZeile.append(Zeile)
input.close()
nZeile.append("% France\n")
input=open('villesFrance.tex','r')
for line in input.readlines():
    if (find(line,"endinput")<0):
	Zeile=line[0:len(line)-1]+"[France]\n"
	nZeile.append(Zeile)
output.writelines(nZeile)
nZeile.append("\\endinput\n")
input.close()
output.close()
