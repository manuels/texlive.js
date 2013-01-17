"""Module to plot using Pgfplots.

This module provides a means to create and display a graph very quickly.  

In this code, the program used to display the created PDF is 'xpdf'.  Change
it to your favorite PDF reader, such as Acrobat Reader (called acroread or
something similar)

The code used to generate the graph is printed in the command line. Edit
your graph iteratively, and when you are satisfied with the graph, copy and
paste the relevant part to your TEX file. 

This module requires the numpy module.

For example of usage, see the executable part at the bottom.

"""
import numpy as np
import subprocess
import os
GRAPH_N = 0

class Pgf:
    def __init__(z, xlabel='', ylabel=''):
        """Initialize and provide axis labels."""
        z.buf = []
        z.options = []
        z.opt('xlabel={{{0}}}'.format(xlabel))
        z.opt('ylabel={{{0}}}'.format(ylabel))
        z.legend = []
    def opt(z, *args):
        """Write arguments to the AXIS environment."""
        for arg in args:
            z.options.append(arg)
    def plot(z, x, y, legend=None, *args):
        """Plot the data contained in the vectors x and y.

        Options to the \addplot command can be provided in *args.
        """
        coor = ''.join(['({0}, {1})'. format(u, v) for u, v in zip(x,y)])
        z.buf.append('\\addplot{0} coordinates {{{1}}};\n'.format(
                ('[' + ', '.join(args) + ']') if len(args) else '' ,coor))
        if legend is not None:
            z.legend.append(legend)
    def save(z, graph_n=None):
        """Generate graph.
        
        If graph_n is None or a number, the graph in a file beginning with
        zzz.  This file is meant to be temporary.  If graph_n is a string,
        that string is used as the file name.
        """
        if type(graph_n) is str:
            file_name = graph_n
        else:
            if graph_n is None:
                global GRAPH_N
                graph_n = GRAPH_N
                GRAPH_N += 1
            elif type(graph_n) is not int:
                raise Error('graph_n should be a string or an integer')
            file_name = 'zzz{0}'.format(graph_n)
        with open(file_name + '.tex', 'w') as f:
            b = []
            b.append('\\documentclass{article}\n')
            b.append('\\usepackage{pgfplots}\n')
            b.append('\\begin{document}\n')
            b.append('\\begin{tikzpicture}')
            b.append('\\begin{axis}[\n')
            b.append('{0}]'.format(',\n'.join(z.options)))
            b.extend(z.buf)
            if z.legend:
                b.append('\\legend{{' + '}, {'.join(z.legend) + '}}\n')
            b.append('\\end{axis}\n')
            b.append('\\end{tikzpicture}\n')
            b.append('\\end{document}')
            f.writelines(b)
        print(''.join(b))
        os.system('pdflatex {0}.tex'.format(file_name))
        os.remove(file_name + '.aux')
        os.remove(file_name + '.log')
        subprocess.Popen(['xpdf',  '{0}.pdf'.format(file_name)])
if __name__ == '__main__':
    """Example of usage."""
    x = np.linspace(0, 2*np.pi)
    p = Pgf('time', 'Voltage')
    p.opt('ybar')
    p.plot(x, np.sin(x), 'sin')
    p.plot(x, np.cos(x), 'cos')
    p.save()#'graph_test_pgf_1')
