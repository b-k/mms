define_blind(Verbatim, <|\begin{verbatim}
$*
\end{verbatim}|>)


define_blind(Pic, <|\begin{figure}[htb]
    \begin{center}
    \begin{tabular}{cc}
    \rotatebox{90}{\abox{$2}{../asst/$1}}
    \end{tabular}

    \caption{$3}
    \label{m4_patsubst($1, <|\..*|>, <||>)}
    \end{center}
\end{figure}
|>)



Here comes the LaTeX header. It is cut/pasted/modified from another document, where it was cut/pasted/modified from another document, ..., meaning that it has a lot that could be excised.

First the ending, stored in m4 buffer 9, then we return to buffer 0 to start from the beginning.
m4_divert(9)
\bibliographystyle{plainnat}
\bibliography{MMSBibfile}
\end{document}
m4_divert(0)

